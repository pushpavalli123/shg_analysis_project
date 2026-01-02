"""
SHG Performance & Economic Impact Analysis
Python script for data analysis and visualization
"""

import sqlite3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
import os

# Set style for better-looking plots
sns.set_style("whitegrid")
plt.rcParams['figure.figsize'] = (12, 6)
plt.rcParams['font.size'] = 10

# Database connection
DB_NAME = 'shg_database.db'

def connect_db():
    """Connect to SQLite database"""
    return sqlite3.connect(DB_NAME)

def create_database():
    """Create database and insert sample data"""
    print("Creating database and inserting sample data...")
    conn = connect_db()
    cursor = conn.cursor()
    
    # Read and execute schema
    with open('database_schema.sql', 'r') as f:
        schema = f.read()
        cursor.executescript(schema)
    
    # Read and execute sample data
    with open('insert_sample_data.sql', 'r') as f:
        data = f.read()
        cursor.executescript(data)
    
    conn.commit()
    conn.close()
    print("Database created successfully!")

def load_data():
    """Load data from database into pandas DataFrames"""
    conn = connect_db()
    
    # Load all tables
    villages_df = pd.read_sql_query("SELECT * FROM Villages", conn)
    members_df = pd.read_sql_query("SELECT * FROM SHG_Members", conn)
    activities_df = pd.read_sql_query("SELECT * FROM Livelihood_Activity", conn)
    loans_df = pd.read_sql_query("SELECT * FROM SHG_Loans", conn)
    
    # Create merged datasets for analysis
    members_villages = pd.merge(members_df, villages_df, on='village_id', how='left')
    members_activities = pd.merge(members_df, activities_df, on='member_id', how='left')
    members_activities = pd.merge(members_activities, villages_df, on='village_id', how='left')
    members_loans = pd.merge(members_df, loans_df, on='member_id', how='left')
    members_loans = pd.merge(members_loans, villages_df, on='village_id', how='left')
    
    conn.close()
    
    return {
        'villages': villages_df,
        'members': members_df,
        'activities': activities_df,
        'loans': loans_df,
        'members_villages': members_villages,
        'members_activities': members_activities,
        'members_loans': members_loans
    }

def analyze_income_growth_by_activity(data):
    """Analyze income growth by livelihood activity"""
    df = data['members_activities'].copy()
    df = df[df['status'] == 'Active']
    
    # Calculate income growth
    df['income_growth'] = ((df['monthly_income'] - df['initial_income']) / df['initial_income']) * 100
    
    activity_summary = df.groupby('activity_type').agg({
        'member_id': 'count',
        'initial_income': 'mean',
        'monthly_income': 'mean',
        'income_growth': 'mean',
        'investment_amount': 'sum'
    }).round(2)
    
    activity_summary.columns = ['Member_Count', 'Avg_Initial_Income', 'Avg_Current_Income', 
                                'Avg_Income_Growth_%', 'Total_Investment']
    
    print("\n" + "="*80)
    print("INCOME GROWTH BY LIVELIHOOD ACTIVITY")
    print("="*80)
    print(activity_summary)
    
    # Visualization
    fig, axes = plt.subplots(2, 2, figsize=(16, 12))
    
    # 1. Income growth percentage by activity
    activity_summary['Avg_Income_Growth_%'].plot(kind='bar', ax=axes[0, 0], color='steelblue')
    axes[0, 0].set_title('Average Income Growth by Activity Type', fontsize=14, fontweight='bold')
    axes[0, 0].set_xlabel('Activity Type')
    axes[0, 0].set_ylabel('Income Growth (%)')
    axes[0, 0].tick_params(axis='x', rotation=45)
    axes[0, 0].grid(axis='y', alpha=0.3)
    
    # 2. Member count by activity
    activity_summary['Member_Count'].plot(kind='bar', ax=axes[0, 1], color='coral')
    axes[0, 1].set_title('Member Distribution by Activity Type', fontsize=14, fontweight='bold')
    axes[0, 1].set_xlabel('Activity Type')
    axes[0, 1].set_ylabel('Number of Members')
    axes[0, 1].tick_params(axis='x', rotation=45)
    axes[0, 1].grid(axis='y', alpha=0.3)
    
    # 3. Investment vs Income
    axes[1, 0].scatter(activity_summary['Total_Investment'], 
                      activity_summary['Avg_Current_Income'], 
                      s=activity_summary['Member_Count']*50, 
                      alpha=0.6, c=range(len(activity_summary)), cmap='viridis')
    axes[1, 0].set_title('Investment vs Current Income by Activity', fontsize=14, fontweight='bold')
    axes[1, 0].set_xlabel('Total Investment (₹)')
    axes[1, 0].set_ylabel('Average Current Income (₹)')
    axes[1, 0].grid(alpha=0.3)
    for i, activity in enumerate(activity_summary.index):
        axes[1, 0].annotate(activity, 
                           (activity_summary['Total_Investment'].iloc[i],
                            activity_summary['Avg_Current_Income'].iloc[i]))
    
    # 4. Income comparison
    x = np.arange(len(activity_summary.index))
    width = 0.35
    axes[1, 1].bar(x - width/2, activity_summary['Avg_Initial_Income'], width, 
                   label='Initial Income', color='lightblue')
    axes[1, 1].bar(x + width/2, activity_summary['Avg_Current_Income'], width, 
                   label='Current Income', color='steelblue')
    axes[1, 1].set_title('Initial vs Current Income by Activity', fontsize=14, fontweight='bold')
    axes[1, 1].set_xlabel('Activity Type')
    axes[1, 1].set_ylabel('Income (₹)')
    axes[1, 1].set_xticks(x)
    axes[1, 1].set_xticklabels(activity_summary.index, rotation=45, ha='right')
    axes[1, 1].legend()
    axes[1, 1].grid(axis='y', alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('income_growth_by_activity.png', dpi=300, bbox_inches='tight')
    print("\nChart saved as 'income_growth_by_activity.png'")
    plt.close()

def analyze_loan_repayment(data):
    """Analyze loan repayment rates by village"""
    df = data['members_loans'].copy()
    
    # Calculate repayment rate by village
    village_loan_summary = df.groupby('village_name').agg({
        'loan_id': 'count',
        'loan_amount': 'sum',
        'total_paid': 'sum',
        'status': lambda x: (x == 'Completed').sum()
    })
    
    village_loan_summary['repayment_rate'] = (
        village_loan_summary['status'] / village_loan_summary['loan_id'] * 100
    ).round(2)
    
    village_loan_summary.columns = ['Total_Loans', 'Total_Loan_Amount', 'Total_Paid', 
                                    'Completed_Loans', 'Repayment_Rate_%']
    
    print("\n" + "="*80)
    print("LOAN REPAYMENT ANALYSIS BY VILLAGE")
    print("="*80)
    print(village_loan_summary)
    
    # Visualization
    fig, axes = plt.subplots(2, 2, figsize=(16, 12))
    
    # 1. Repayment rate by village
    village_loan_summary['Repayment_Rate_%'].plot(kind='bar', ax=axes[0, 0], color='green')
    axes[0, 0].set_title('Loan Repayment Rate by Village', fontsize=14, fontweight='bold')
    axes[0, 0].set_xlabel('Village')
    axes[0, 0].set_ylabel('Repayment Rate (%)')
    axes[0, 0].tick_params(axis='x', rotation=45)
    axes[0, 0].grid(axis='y', alpha=0.3)
    axes[0, 0].axhline(y=85, color='r', linestyle='--', label='Target (85%)')
    axes[0, 0].legend()
    
    # 2. Loan status distribution
    loan_status = df['status'].value_counts()
    axes[0, 1].pie(loan_status.values, labels=loan_status.index, autopct='%1.1f%%', 
                   startangle=90, colors=['#2ecc71', '#3498db', '#e74c3c'])
    axes[0, 1].set_title('Loan Status Distribution', fontsize=14, fontweight='bold')
    
    # 3. Total loans vs repayments
    x = np.arange(len(village_loan_summary.index))
    width = 0.35
    axes[1, 0].bar(x - width/2, village_loan_summary['Total_Loan_Amount'], width, 
                   label='Loan Amount', color='lightcoral')
    axes[1, 0].bar(x + width/2, village_loan_summary['Total_Paid'], width, 
                   label='Amount Paid', color='lightgreen')
    axes[1, 0].set_title('Loan Amount vs Amount Paid by Village', fontsize=14, fontweight='bold')
    axes[1, 0].set_xlabel('Village')
    axes[1, 0].set_ylabel('Amount (₹)')
    axes[1, 0].set_xticks(x)
    axes[1, 0].set_xticklabels(village_loan_summary.index, rotation=45, ha='right')
    axes[1, 0].legend()
    axes[1, 0].grid(axis='y', alpha=0.3)
    
    # 4. Loan amount distribution
    axes[1, 1].hist(df['loan_amount'], bins=20, color='skyblue', edgecolor='black')
    axes[1, 1].set_title('Loan Amount Distribution', fontsize=14, fontweight='bold')
    axes[1, 1].set_xlabel('Loan Amount (₹)')
    axes[1, 1].set_ylabel('Frequency')
    axes[1, 1].grid(axis='y', alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('loan_repayment_analysis.png', dpi=300, bbox_inches='tight')
    print("\nChart saved as 'loan_repayment_analysis.png'")
    plt.close()

def analyze_member_distribution(data):
    """Analyze member distribution by various factors"""
    df = data['members_villages'].copy()
    
    # Age-wise analysis
    df['age_group'] = pd.cut(df['age'], bins=[0, 30, 40, 100], labels=['20-30', '31-40', '40+'])
    
    age_summary = df.groupby('age_group', observed=True).agg({
        'member_id': 'count',
        'initial_income': 'mean',
        'current_income': 'mean'
    })
    age_summary['income_growth'] = (
        (age_summary['current_income'] - age_summary['initial_income']) / 
        age_summary['initial_income'] * 100
    ).round(2)
    
    print("\n" + "="*80)
    print("MEMBER DISTRIBUTION ANALYSIS")
    print("="*80)
    print("\nAge-wise Distribution:")
    print(age_summary)
    
    # Village-wise distribution
    village_summary = df.groupby('village_name').agg({
        'member_id': 'count',
        'current_income': 'mean'
    })
    village_summary.columns = ['Member_Count', 'Avg_Income']
    
    print("\nVillage-wise Distribution:")
    print(village_summary)
    
    # Visualization
    fig, axes = plt.subplots(2, 2, figsize=(16, 12))
    
    # 1. Age distribution
    age_counts = df['age_group'].value_counts().sort_index()
    axes[0, 0].bar(age_counts.index, age_counts.values, color='teal')
    axes[0, 0].set_title('Member Distribution by Age Group', fontsize=14, fontweight='bold')
    axes[0, 0].set_xlabel('Age Group')
    axes[0, 0].set_ylabel('Number of Members')
    axes[0, 0].grid(axis='y', alpha=0.3)
    
    # 2. Village distribution
    village_summary['Member_Count'].plot(kind='bar', ax=axes[0, 1], color='orange')
    axes[0, 1].set_title('Member Distribution by Village', fontsize=14, fontweight='bold')
    axes[0, 1].set_xlabel('Village')
    axes[0, 1].set_ylabel('Number of Members')
    axes[0, 1].tick_params(axis='x', rotation=45)
    axes[0, 1].grid(axis='y', alpha=0.3)
    
    # 3. Income growth by age group
    age_summary['income_growth'].plot(kind='bar', ax=axes[1, 0], color='purple')
    axes[1, 0].set_title('Income Growth by Age Group', fontsize=14, fontweight='bold')
    axes[1, 0].set_xlabel('Age Group')
    axes[1, 0].set_ylabel('Income Growth (%)')
    axes[1, 0].grid(axis='y', alpha=0.3)
    
    # 4. Education level distribution
    edu_counts = df['education_level'].value_counts()
    axes[1, 1].pie(edu_counts.values, labels=edu_counts.index, autopct='%1.1f%%', 
                   startangle=90, colors=['#3498db', '#2ecc71', '#e74c3c', '#f39c12'])
    axes[1, 1].set_title('Member Distribution by Education Level', fontsize=14, fontweight='bold')
    
    plt.tight_layout()
    plt.savefig('member_distribution_analysis.png', dpi=300, bbox_inches='tight')
    print("\nChart saved as 'member_distribution_analysis.png'")
    plt.close()

def identify_top_earners(data):
    """Identify top earners and their details"""
    df = data['members_activities'].copy()
    df = df[df['status'] == 'Active']
    
    df['income_growth'] = ((df['monthly_income'] - df['initial_income']) / df['initial_income']) * 100
    
    top_earners = df.nlargest(10, 'monthly_income')[
        ['member_name', 'village_name', 'activity_type', 'initial_income', 
         'monthly_income', 'income_growth']
    ].round(2)
    
    print("\n" + "="*80)
    print("TOP 10 EARNERS")
    print("="*80)
    print(top_earners.to_string(index=False))
    
    # Visualization
    fig, axes = plt.subplots(1, 2, figsize=(16, 6))
    
    # 1. Top earners bar chart
    top_earners_sorted = top_earners.sort_values('monthly_income')
    axes[0].barh(range(len(top_earners_sorted)), top_earners_sorted['monthly_income'], 
                 color='gold')
    axes[0].set_yticks(range(len(top_earners_sorted)))
    axes[0].set_yticklabels(top_earners_sorted['member_name'], fontsize=9)
    axes[0].set_title('Top 10 Earners - Monthly Income', fontsize=14, fontweight='bold')
    axes[0].set_xlabel('Monthly Income (₹)')
    axes[0].grid(axis='x', alpha=0.3)
    
    # 2. Top earners by activity type
    top_by_activity = top_earners.groupby('activity_type')['monthly_income'].mean().sort_values(ascending=False)
    top_by_activity.plot(kind='bar', ax=axes[1], color='crimson')
    axes[1].set_title('Average Income of Top Earners by Activity', fontsize=14, fontweight='bold')
    axes[1].set_xlabel('Activity Type')
    axes[1].set_ylabel('Average Monthly Income (₹)')
    axes[1].tick_params(axis='x', rotation=45)
    axes[1].grid(axis='y', alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('top_earners_analysis.png', dpi=300, bbox_inches='tight')
    print("\nChart saved as 'top_earners_analysis.png'")
    plt.close()
    
    return top_earners

def generate_summary_report(data):
    """Generate comprehensive summary report"""
    members_df = data['members']
    loans_df = data['loans']
    activities_df = data['activities']
    
    summary = {
        'Total_Villages': len(data['villages']),
        'Total_Members': len(members_df),
        'Total_Activities': len(activities_df[activities_df['status'] == 'Active']),
        'Total_Loans': len(loans_df),
        'Total_Loan_Amount': loans_df['loan_amount'].sum(),
        'Total_Loan_Paid': loans_df['total_paid'].sum(),
        'Avg_Initial_Income': members_df['initial_income'].mean(),
        'Avg_Current_Income': members_df['current_income'].mean(),
        'Overall_Income_Growth_%': ((members_df['current_income'].mean() - 
                                     members_df['initial_income'].mean()) / 
                                    members_df['initial_income'].mean() * 100),
        'Loan_Repayment_Rate_%': (len(loans_df[loans_df['status'] == 'Completed']) / 
                                  len(loans_df) * 100)
    }
    
    print("\n" + "="*80)
    print("COMPREHENSIVE SUMMARY REPORT")
    print("="*80)
    for key, value in summary.items():
        if isinstance(value, float):
            print(f"{key}: {value:.2f}")
        else:
            print(f"{key}: {value}")
    
    return summary

def export_results_to_csv(data):
    """Export analysis results to CSV files"""
    print("\n" + "="*80)
    print("EXPORTING RESULTS TO CSV")
    print("="*80)
    
    # Export main tables
    data['members'].to_csv('export_members.csv', index=False)
    data['activities'].to_csv('export_activities.csv', index=False)
    data['loans'].to_csv('export_loans.csv', index=False)
    data['villages'].to_csv('export_villages.csv', index=False)
    
    # Export merged analysis datasets
    data['members_villages'].to_csv('export_members_villages.csv', index=False)
    data['members_activities'].to_csv('export_members_activities.csv', index=False)
    data['members_loans'].to_csv('export_members_loans.csv', index=False)
    
    print("All data exported to CSV files successfully!")

def main():
    """Main execution function"""
    print("="*80)
    print("SHG PERFORMANCE & ECONOMIC IMPACT ANALYSIS")
    print("="*80)
    
    # Check if database exists, if not create it
    if not os.path.exists(DB_NAME):
        create_database()
    else:
        print(f"Database '{DB_NAME}' already exists. Using existing database.")
    
    # Load data
    print("\nLoading data from database...")
    data = load_data()
    
    # Perform analyses
    print("\nPerforming analyses...")
    analyze_income_growth_by_activity(data)
    analyze_loan_repayment(data)
    analyze_member_distribution(data)
    top_earners = identify_top_earners(data)
    summary = generate_summary_report(data)
    
    # Export results
    export_results_to_csv(data)
    
    print("\n" + "="*80)
    print("ANALYSIS COMPLETE!")
    print("="*80)
    print("\nGenerated files:")
    print("- income_growth_by_activity.png")
    print("- loan_repayment_analysis.png")
    print("- member_distribution_analysis.png")
    print("- top_earners_analysis.png")
    print("- export_*.csv (multiple CSV files)")
    print("\n" + "="*80)

if __name__ == "__main__":
    main()

