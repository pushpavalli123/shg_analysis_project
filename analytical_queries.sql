-- SHG Performance & Economic Impact Analysis - Analytical Queries
-- 10+ SQL queries for comprehensive analysis

-- Query 1: Total member count by village
SELECT 
    v.village_name,
    v.district_name,
    COUNT(m.member_id) AS total_members
FROM Villages v
LEFT JOIN SHG_Members m ON v.village_id = m.village_id
GROUP BY v.village_id, v.village_name, v.district_name
ORDER BY total_members DESC;

-- Query 2: Average income growth percentage by village
SELECT 
    v.village_name,
    v.district_name,
    COUNT(m.member_id) AS member_count,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(((AVG(m.current_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS avg_income_growth_percent
FROM Villages v
JOIN SHG_Members m ON v.village_id = m.village_id
GROUP BY v.village_id, v.village_name, v.district_name
ORDER BY avg_income_growth_percent DESC;

-- Query 3: Income growth by livelihood activity type
SELECT 
    la.activity_type,
    COUNT(DISTINCT la.member_id) AS member_count,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(la.monthly_income), 2) AS avg_current_income,
    ROUND(((AVG(la.monthly_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS income_growth_percent,
    ROUND(SUM(la.investment_amount), 2) AS total_investment
FROM Livelihood_Activity la
JOIN SHG_Members m ON la.member_id = m.member_id
WHERE la.status = 'Active'
GROUP BY la.activity_type
ORDER BY income_growth_percent DESC;

-- Query 4: Loan repayment rate by village
SELECT 
    v.village_name,
    v.district_name,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    SUM(CASE WHEN l.status = 'Completed' THEN 1 ELSE 0 END) AS completed_loans,
    SUM(CASE WHEN l.status = 'Active' THEN 1 ELSE 0 END) AS active_loans,
    SUM(CASE WHEN l.status = 'Defaulted' THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND((SUM(CASE WHEN l.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(l.loan_id)), 2) AS repayment_rate_percent,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_amount,
    ROUND(SUM(l.total_paid), 2) AS total_amount_paid
FROM Villages v
JOIN SHG_Members m ON v.village_id = m.village_id
JOIN SHG_Loans l ON m.member_id = l.member_id
GROUP BY v.village_id, v.village_name, v.district_name
ORDER BY repayment_rate_percent DESC;

-- Query 5: Age-wise income growth analysis
SELECT 
    CASE 
        WHEN m.age BETWEEN 20 AND 30 THEN '20-30'
        WHEN m.age BETWEEN 31 AND 40 THEN '31-40'
        WHEN m.age > 40 THEN '40+'
    END AS age_group,
    COUNT(m.member_id) AS member_count,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(((AVG(m.current_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS income_growth_percent
FROM SHG_Members m
GROUP BY age_group
ORDER BY age_group;

-- Query 6: Top 10 earners with their details
SELECT 
    m.member_id,
    m.member_name,
    v.village_name,
    v.district_name,
    m.age,
    m.gender,
    m.initial_income,
    m.current_income,
    la.activity_type,
    la.monthly_income AS activity_income,
    ROUND(((m.current_income - m.initial_income) / m.initial_income) * 100, 2) AS income_growth_percent
FROM SHG_Members m
JOIN Villages v ON m.village_id = v.village_id
LEFT JOIN Livelihood_Activity la ON m.member_id = la.member_id AND la.status = 'Active'
ORDER BY m.current_income DESC
LIMIT 10;

-- Query 7: Loan performance analysis (repayment efficiency)
SELECT 
    l.status,
    COUNT(l.loan_id) AS loan_count,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_amount,
    ROUND(SUM(l.total_paid), 2) AS total_paid,
    ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(l.interest_rate), 2) AS avg_interest_rate,
    ROUND((SUM(l.total_paid) * 100.0 / SUM(l.loan_amount)), 2) AS repayment_percentage
FROM SHG_Loans l
GROUP BY l.status
ORDER BY loan_count DESC;

-- Query 8: Member distribution by education level
SELECT 
    m.education_level,
    COUNT(m.member_id) AS member_count,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(((AVG(m.current_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS income_growth_percent
FROM SHG_Members m
GROUP BY m.education_level
ORDER BY member_count DESC;

-- Query 9: Activity-wise investment and return analysis
SELECT 
    la.activity_type,
    COUNT(DISTINCT la.member_id) AS member_count,
    ROUND(SUM(la.investment_amount), 2) AS total_investment,
    ROUND(AVG(la.investment_amount), 2) AS avg_investment,
    ROUND(SUM(la.monthly_income), 2) AS total_monthly_income,
    ROUND(AVG(la.monthly_income), 2) AS avg_monthly_income,
    ROUND((AVG(la.monthly_income) / AVG(la.investment_amount)) * 100, 2) AS monthly_return_percent
FROM Livelihood_Activity la
WHERE la.status = 'Active'
GROUP BY la.activity_type
ORDER BY monthly_return_percent DESC;

-- Query 10: Overall SHG performance summary
SELECT 
    COUNT(DISTINCT v.village_id) AS total_villages,
    COUNT(DISTINCT m.member_id) AS total_members,
    COUNT(DISTINCT la.activity_id) AS total_activities,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_amount,
    ROUND(SUM(l.total_paid), 2) AS total_loan_paid,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(((AVG(m.current_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS overall_income_growth_percent,
    ROUND((SUM(CASE WHEN l.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(l.loan_id)), 2) AS overall_repayment_rate
FROM Villages v
LEFT JOIN SHG_Members m ON v.village_id = m.village_id
LEFT JOIN Livelihood_Activity la ON m.member_id = la.member_id
LEFT JOIN SHG_Loans l ON m.member_id = l.member_id;

-- Query 11: Gender-wise performance analysis
SELECT 
    m.gender,
    COUNT(m.member_id) AS member_count,
    ROUND(AVG(m.initial_income), 2) AS avg_initial_income,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(((AVG(m.current_income) - AVG(m.initial_income)) / AVG(m.initial_income)) * 100, 2) AS income_growth_percent
FROM SHG_Members m
GROUP BY m.gender;

-- Query 12: District-wise comprehensive analysis
SELECT 
    v.district_name,
    COUNT(DISTINCT v.village_id) AS village_count,
    COUNT(DISTINCT m.member_id) AS member_count,
    ROUND(AVG(m.current_income), 2) AS avg_current_income,
    ROUND(SUM(l.loan_amount), 2) AS total_loans_disbursed,
    ROUND(SUM(l.total_paid), 2) AS total_repayments,
    ROUND((SUM(CASE WHEN l.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(l.loan_id)), 2) AS repayment_rate
FROM Villages v
JOIN SHG_Members m ON v.village_id = m.village_id
LEFT JOIN SHG_Loans l ON m.member_id = l.member_id
GROUP BY v.district_name
ORDER BY member_count DESC;

-- Query 13: Members with highest income growth percentage
SELECT 
    m.member_id,
    m.member_name,
    v.village_name,
    m.initial_income,
    m.current_income,
    ROUND(((m.current_income - m.initial_income) / m.initial_income) * 100, 2) AS income_growth_percent,
    la.activity_type
FROM SHG_Members m
JOIN Villages v ON m.village_id = v.village_id
LEFT JOIN Livelihood_Activity la ON m.member_id = la.member_id AND la.status = 'Active'
ORDER BY income_growth_percent DESC
LIMIT 15;

-- Query 14: Loan tenure analysis
SELECT 
    l.tenure_months,
    COUNT(l.loan_id) AS loan_count,
    ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(l.monthly_emi), 2) AS avg_monthly_emi,
    ROUND((SUM(CASE WHEN l.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(l.loan_id)), 2) AS completion_rate
FROM SHG_Loans l
GROUP BY l.tenure_months
ORDER BY l.tenure_months;

