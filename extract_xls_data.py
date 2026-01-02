"""
Extract and process data from the original XLS file
G1_SHGsUnderNRLM(DistrictLevel).xls
"""

import pandas as pd
import sqlite3

def extract_xls_data():
    """Extract data from the XLS file and display structure"""
    print("="*80)
    print("EXTRACTING DATA FROM XLS FILE")
    print("="*80)
    
    # Read the Excel file
    df = pd.read_excel('G1_SHGsUnderNRLM(DistrictLevel).xls')
    
    print("\nFile Shape:", df.shape)
    print("\nColumns:", df.columns.tolist())
    print("\nFirst 10 rows:")
    print(df.head(10))
    
    # Clean the data - the file has a multi-row header
    # Row 0 has column names, Row 1 has sub-headers
    if df.iloc[0, 0] == 'S.No.':
        # Set proper column names
        df.columns = ['S.No.', 'District_Name', 'New', 'Revived', 'Pre_NRLM', 'Sub_Total', 'Total_Members']
        # Remove header rows
        df = df.iloc[2:].reset_index(drop=True)
        # Remove rows with NaN in District_Name
        df = df[df['District_Name'].notna()]
        # Convert numeric columns
        numeric_cols = ['S.No.', 'New', 'Revived', 'Pre_NRLM', 'Sub_Total', 'Total_Members']
        for col in numeric_cols:
            if col in df.columns:
                df[col] = pd.to_numeric(df[col], errors='coerce')
    
    print("\n" + "="*80)
    print("CLEANED DATA")
    print("="*80)
    print(df.head(15))
    
    print("\n" + "="*80)
    print("DATA SUMMARY")
    print("="*80)
    print(f"Total Districts: {len(df)}")
    print(f"Total SHGs (New): {df['New'].sum() if 'New' in df.columns else 'N/A'}")
    print(f"Total SHGs (Revived): {df['Revived'].sum() if 'Revived' in df.columns else 'N/A'}")
    print(f"Total SHGs (Pre-NRLM): {df['Pre_NRLM'].sum() if 'Pre_NRLM' in df.columns else 'N/A'}")
    print(f"Total Members: {df['Total_Members'].sum() if 'Total_Members' in df.columns else 'N/A'}")
    
    # Save cleaned data to CSV
    df.to_csv('extracted_district_data.csv', index=False)
    print("\nCleaned data saved to 'extracted_district_data.csv'")
    
    # Optionally, you can insert this data into the database
    # For now, we'll just display it
    return df

def create_district_reference_table():
    """Create a reference table in the database with district-level data"""
    df = extract_xls_data()
    
    conn = sqlite3.connect('shg_database.db')
    cursor = conn.cursor()
    
    # Create district reference table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS District_Reference (
            district_id INTEGER PRIMARY KEY AUTOINCREMENT,
            district_name TEXT NOT NULL UNIQUE,
            shgs_new INTEGER,
            shgs_revived INTEGER,
            shgs_pre_nrlm INTEGER,
            shgs_sub_total INTEGER,
            total_members INTEGER
        )
    """)
    
    # Insert data
    for _, row in df.iterrows():
        try:
            cursor.execute("""
                INSERT OR REPLACE INTO District_Reference 
                (district_name, shgs_new, shgs_revived, shgs_pre_nrlm, shgs_sub_total, total_members)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (
                row['District_Name'],
                int(row['New']) if pd.notna(row['New']) else None,
                int(row['Revived']) if pd.notna(row['Revived']) else None,
                int(row['Pre_NRLM']) if pd.notna(row['Pre_NRLM']) else None,
                int(row['Sub_Total']) if pd.notna(row['Sub_Total']) else None,
                int(row['Total_Members']) if pd.notna(row['Total_Members']) else None
            ))
        except Exception as e:
            print(f"Error inserting {row['District_Name']}: {e}")
    
    conn.commit()
    conn.close()
    print("\nDistrict reference data inserted into database!")

if __name__ == "__main__":
    # Extract and display data
    df = extract_xls_data()
    
    # Optionally create reference table in database
    print("\n" + "="*80)
    response = input("Do you want to create a district reference table in the database? (y/n): ")
    if response.lower() == 'y':
        create_district_reference_table()

