"""
Setup script to create database and insert sample data
Run this before running the main analysis script
"""

import sqlite3
import os

def setup_database():
    """Create database and insert sample data"""
    DB_NAME = 'shg_database.db'
    
    # Remove existing database if it exists (optional - comment out if you want to keep existing data)
    if os.path.exists(DB_NAME):
        print(f"Database '{DB_NAME}' already exists.")
        print("To recreate it, delete the file and run this script again.")
        print("Using existing database for now.")
        return
    
    print("="*80)
    print("SETTING UP SHG DATABASE")
    print("="*80)
    
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    
    # Read and execute schema
    print("\n1. Creating database schema...")
    with open('database_schema.sql', 'r', encoding='utf-8') as f:
        schema = f.read()
        cursor.executescript(schema)
    print("   [OK] Schema created successfully!")
    
    # Read and execute sample data
    print("\n2. Inserting sample data...")
    with open('insert_sample_data.sql', 'r', encoding='utf-8') as f:
        data = f.read()
        cursor.executescript(data)
    print("   [OK] Sample data inserted successfully!")
    
    conn.commit()
    
    # Verify data insertion
    print("\n3. Verifying data insertion...")
    cursor.execute("SELECT COUNT(*) FROM Villages")
    village_count = cursor.fetchone()[0]
    print(f"   [OK] Villages: {village_count}")
    
    cursor.execute("SELECT COUNT(*) FROM SHG_Members")
    member_count = cursor.fetchone()[0]
    print(f"   [OK] SHG Members: {member_count}")
    
    cursor.execute("SELECT COUNT(*) FROM Livelihood_Activity")
    activity_count = cursor.fetchone()[0]
    print(f"   [OK] Livelihood Activities: {activity_count}")
    
    cursor.execute("SELECT COUNT(*) FROM SHG_Loans")
    loan_count = cursor.fetchone()[0]
    print(f"   [OK] SHG Loans: {loan_count}")
    
    conn.close()
    
    print("\n" + "="*80)
    print("DATABASE SETUP COMPLETE!")
    print("="*80)
    print(f"\nDatabase file: {DB_NAME}")
    print("\nYou can now run 'python shg_analysis.py' to perform the analysis.")

if __name__ == "__main__":
    setup_database()

