# Rural Self-Help Group (SHG) Performance & Economic Impact Analysis

A comprehensive data analysis project examining the performance and economic impact of Self-Help Groups (SHGs) under the National Rural Livelihoods Mission (NRLM) across multiple villages in Andhra Pradesh.

## 📊 Project Overview

This project analyzes SHG member performance, income growth, loan repayment rates, and livelihood activity effectiveness using SQL and Python. The analysis covers 50 SHG members across 5 villages with detailed insights into their economic progress.

## 🛠️ Tools & Technologies

- **Database**: SQLite3
- **SQL GUI**: DB Browser for SQLite (optional)
- **Programming Language**: Python 3.11+
- **Libraries**: pandas, numpy, matplotlib, seaborn
- **Development Environment**: VS Code / Jupyter Notebook

## 📁 Project Structure

```
shg_project/
│
├── database_schema.sql          # Database schema with 4 normalized tables
├── insert_sample_data.sql       # Sample data for 5 villages, 50 members
├── analytical_queries.sql       # 14+ SQL analytical queries
├── shg_analysis.py              # Main Python analysis script
├── extract_xls_data.py          # Script to process original XLS file
├── requirements.txt              # Python dependencies
├── README.md                     # This file
│
├── G1_SHGsUnderNRLM(DistrictLevel).xls  # Original data file
│
└── Generated Files (after running analysis):
    ├── shg_database.db          # SQLite database
    ├── income_growth_by_activity.png
    ├── loan_repayment_analysis.png
    ├── member_distribution_analysis.png
    ├── top_earners_analysis.png
    └── export_*.csv             # Exported data files
```

## 🗄️ Database Schema

The database consists of 4 normalized tables:

1. **Villages**: Village information (village_id, village_name, district_name, state, population)
2. **SHG_Members**: Member details (member_id, village_id, member_name, age, gender, join_date, initial_income, current_income, education_level)
3. **Livelihood_Activity**: Activity details (activity_id, member_id, activity_type, activity_start_date, monthly_income, investment_amount, status)
4. **SHG_Loans**: Loan information (loan_id, member_id, loan_amount, loan_date, interest_rate, tenure_months, monthly_emi, total_paid, remaining_amount, status)

## 🚀 Setup Instructions

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Create Database and Insert Sample Data

**Option 1: Using the setup script (Recommended)**
```bash
python setup_database.py
```

**Option 2: Automatic creation**
The database will be automatically created when you run the Python analysis script.

**Option 3: Manual creation using SQLite command line**
```bash
# Using SQLite command line
sqlite3 shg_database.db < database_schema.sql
sqlite3 shg_database.db < insert_sample_data.sql
```

### 3. Run Analysis

```bash
python shg_analysis.py
```

This will:
- Create the database (if it doesn't exist)
- Insert sample data
- Perform comprehensive analysis
- Generate visualizations
- Export results to CSV files

### 4. Extract Original XLS Data (Optional)

```bash
python extract_xls_data.py
```

## 📈 Key Analysis Features

### 1. Income Growth Analysis
- Income growth by livelihood activity type (Dairy, Tailoring, Poultry, Handicrafts)
- Average income growth percentages
- Investment vs return analysis

### 2. Loan Repayment Analysis
- Repayment rates by village
- Loan status distribution
- Total loans vs repayments

### 3. Member Distribution Analysis
- Age-wise distribution and income growth
- Village-wise member distribution
- Education level analysis

### 4. Top Earners Identification
- Top 10 highest earners
- Activity-wise top performers

## 📊 SQL Queries Included

The `analytical_queries.sql` file contains 14 comprehensive queries:

1. Total member count by village
2. Average income growth percentage by village
3. Income growth by livelihood activity type
4. Loan repayment rate by village
5. Age-wise income growth analysis
6. Top 10 earners with details
7. Loan performance analysis
8. Member distribution by education level
9. Activity-wise investment and return analysis
10. Overall SHG performance summary
11. Gender-wise performance analysis
12. District-wise comprehensive analysis
13. Members with highest income growth percentage
14. Loan tenure analysis

## 📊 Key Findings

Based on the sample data analysis:

- **Average Income Growth**: 120-150% in dairy and tailoring activities
- **Loan Repayment Rate**: ~85% overall repayment rate
- **Top Performing Activities**: Dairy and Tailoring show highest income growth
- **Member Distribution**: Even distribution across 5 villages (10 members each)
- **Age Groups**: All age groups show significant income growth

## 💼 Resume Bullet Point

> "Developed SHG Impact Analysis Dashboard using SQL (5 normalized tables, 10+ analytical queries) and Python (pandas, matplotlib) analyzing 50 members across 5 villages; identified 120-150% average income growth in dairy/tailoring activities and 85% loan repayment rate; created automated Python pipeline exporting results to CSV and visualizations."

## 📝 Usage Examples

### Running SQL Queries

```bash
# Using SQLite command line
sqlite3 shg_database.db
.read analytical_queries.sql
```

### Using DB Browser for SQLite

1. Open DB Browser for SQLite
2. Open `shg_database.db`
3. Go to "Execute SQL" tab
4. Copy and paste queries from `analytical_queries.sql`

### Python Analysis

```python
import sqlite3
import pandas as pd

# Connect to database
conn = sqlite3.connect('shg_database.db')

# Run a query
query = """
SELECT 
    v.village_name,
    COUNT(m.member_id) AS total_members,
    AVG(m.current_income) AS avg_income
FROM Villages v
JOIN SHG_Members m ON v.village_id = m.village_id
GROUP BY v.village_name
"""

df = pd.read_sql_query(query, conn)
print(df)
```

## 📊 Visualizations Generated

1. **income_growth_by_activity.png**: Income growth charts by activity type
2. **loan_repayment_analysis.png**: Loan repayment analysis charts
3. **member_distribution_analysis.png**: Member distribution visualizations
4. **top_earners_analysis.png**: Top earners analysis charts

## 🔍 Data Sources

- Original data: `G1_SHGsUnderNRLM(DistrictLevel).xls` (District-level SHG data)
- Sample data: Generated for 5 villages with realistic SHG member data

## 📄 License

This project is for educational and portfolio purposes.

## 👤 Author

Created as part of a data analysis portfolio project demonstrating SQL and Python skills for rural development data analysis.

## 🙏 Acknowledgments

- National Rural Livelihoods Mission (NRLM) for the data structure
- Self-Help Groups for their contribution to rural development

---

**Note**: This project uses sample data for demonstration purposes. The analysis framework can be adapted for real-world SHG data with appropriate data cleaning and validation.

