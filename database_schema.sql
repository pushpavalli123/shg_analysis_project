-- SHG Performance & Economic Impact Analysis Database Schema
-- Created for Rural Self-Help Group Analysis Project

-- Table 1: Villages
CREATE TABLE IF NOT EXISTS Villages (
    village_id INTEGER PRIMARY KEY AUTOINCREMENT,
    village_name TEXT NOT NULL,
    district_name TEXT NOT NULL,
    state TEXT NOT NULL DEFAULT 'Andhra Pradesh',
    population INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: SHG_Members
CREATE TABLE IF NOT EXISTS SHG_Members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    village_id INTEGER NOT NULL,
    member_name TEXT NOT NULL,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL CHECK(gender IN ('Male', 'Female', 'Other')),
    join_date DATE NOT NULL,
    initial_income DECIMAL(10, 2) NOT NULL,
    current_income DECIMAL(10, 2) NOT NULL,
    education_level TEXT,
    FOREIGN KEY (village_id) REFERENCES Villages(village_id)
);

-- Table 3: Livelihood_Activity
CREATE TABLE IF NOT EXISTS Livelihood_Activity (
    activity_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    activity_type TEXT NOT NULL,
    activity_start_date DATE NOT NULL,
    monthly_income DECIMAL(10, 2) NOT NULL,
    investment_amount DECIMAL(10, 2),
    status TEXT DEFAULT 'Active' CHECK(status IN ('Active', 'Inactive', 'Completed')),
    FOREIGN KEY (member_id) REFERENCES SHG_Members(member_id)
);

-- Table 4: SHG_Loans
CREATE TABLE IF NOT EXISTS SHG_Loans (
    loan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    loan_amount DECIMAL(10, 2) NOT NULL,
    loan_date DATE NOT NULL,
    interest_rate DECIMAL(5, 2) DEFAULT 12.00,
    tenure_months INTEGER NOT NULL,
    monthly_emi DECIMAL(10, 2) NOT NULL,
    total_paid DECIMAL(10, 2) DEFAULT 0.00,
    remaining_amount DECIMAL(10, 2) NOT NULL,
    status TEXT DEFAULT 'Active' CHECK(status IN ('Active', 'Completed', 'Defaulted')),
    FOREIGN KEY (member_id) REFERENCES SHG_Members(member_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_member_village ON SHG_Members(village_id);
CREATE INDEX IF NOT EXISTS idx_activity_member ON Livelihood_Activity(member_id);
CREATE INDEX IF NOT EXISTS idx_loan_member ON SHG_Loans(member_id);
CREATE INDEX IF NOT EXISTS idx_activity_type ON Livelihood_Activity(activity_type);
CREATE INDEX IF NOT EXISTS idx_loan_status ON SHG_Loans(status);

