-- Sample Data Insertion Script
-- Inserting data for 5 villages and 50 SHG members

-- Insert 5 Villages
INSERT INTO Villages (village_name, district_name, state, population) VALUES
('Rampur', 'Anantapur', 'Andhra Pradesh', 3500),
('Devipur', 'Chittoor', 'Andhra Pradesh', 4200),
('Krishnapur', 'Kurnool', 'Andhra Pradesh', 3800),
('Lakshmipur', 'Guntur', 'Andhra Pradesh', 4500),
('Sitapur', 'East Godavari', 'Andhra Pradesh', 3900);

-- Insert 50 SHG Members (10 per village)
-- Village 1: Rampur
INSERT INTO SHG_Members (village_id, member_name, age, gender, join_date, initial_income, current_income, education_level) VALUES
(1, 'Lakshmi Devi', 32, 'Female', '2020-01-15', 5000.00, 12000.00, 'Primary'),
(1, 'Radha Kumari', 28, 'Female', '2020-02-20', 4500.00, 11000.00, 'Secondary'),
(1, 'Sita Devi', 35, 'Female', '2019-11-10', 6000.00, 15000.00, 'Primary'),
(1, 'Geeta Sharma', 30, 'Female', '2020-03-05', 5500.00, 13500.00, 'Secondary'),
(1, 'Meera Bai', 40, 'Female', '2019-08-22', 7000.00, 18000.00, 'Illiterate'),
(1, 'Kamala Devi', 25, 'Female', '2020-05-12', 4000.00, 10000.00, 'Secondary'),
(1, 'Sunita Kumari', 33, 'Female', '2020-01-30', 5200.00, 12500.00, 'Primary'),
(1, 'Priya Sharma', 29, 'Female', '2020-04-18', 4800.00, 11500.00, 'Secondary'),
(1, 'Anita Devi', 37, 'Female', '2019-12-05', 6500.00, 16000.00, 'Primary'),
(1, 'Rekha Kumari', 31, 'Female', '2020-02-28', 5100.00, 12200.00, 'Secondary');

-- Village 2: Devipur
INSERT INTO SHG_Members (village_id, member_name, age, gender, join_date, initial_income, current_income, education_level) VALUES
(2, 'Sarojini Devi', 34, 'Female', '2020-06-10', 5800.00, 14000.00, 'Secondary'),
(2, 'Usha Kumari', 27, 'Female', '2020-07-15', 4700.00, 11200.00, 'Primary'),
(2, 'Manjula Devi', 36, 'Female', '2020-05-20', 6200.00, 15500.00, 'Primary'),
(2, 'Vijaya Lakshmi', 29, 'Female', '2020-08-05', 4900.00, 11800.00, 'Secondary'),
(2, 'Padma Devi', 38, 'Female', '2020-04-12', 6800.00, 17000.00, 'Illiterate'),
(2, 'Sushila Kumari', 26, 'Female', '2020-09-18', 4400.00, 10500.00, 'Secondary'),
(2, 'Indira Devi', 32, 'Female', '2020-06-25', 5600.00, 13800.00, 'Primary'),
(2, 'Kavita Sharma', 30, 'Female', '2020-07-30', 5400.00, 13000.00, 'Secondary'),
(2, 'Nirmala Devi', 35, 'Female', '2020-05-08', 6000.00, 14800.00, 'Primary'),
(2, 'Rajeshwari Kumari', 28, 'Female', '2020-08-22', 5000.00, 12000.00, 'Secondary');

-- Village 3: Krishnapur
INSERT INTO SHG_Members (village_id, member_name, age, gender, join_date, initial_income, current_income, education_level) VALUES
(3, 'Chandrakala Devi', 33, 'Female', '2020-10-05', 5700.00, 14200.00, 'Primary'),
(3, 'Pushpa Kumari', 31, 'Female', '2020-11-12', 5300.00, 12800.00, 'Secondary'),
(3, 'Lalita Devi', 39, 'Female', '2020-09-20', 7100.00, 18500.00, 'Illiterate'),
(3, 'Shanti Kumari', 28, 'Female', '2020-12-08', 4800.00, 11600.00, 'Secondary'),
(3, 'Ganga Devi', 34, 'Female', '2020-10-25', 5900.00, 14500.00, 'Primary'),
(3, 'Yamuna Kumari', 29, 'Female', '2020-11-30', 5100.00, 12300.00, 'Secondary'),
(3, 'Saraswati Devi', 36, 'Female', '2020-09-15', 6400.00, 16200.00, 'Primary'),
(3, 'Durga Kumari', 30, 'Female', '2020-12-18', 5500.00, 13200.00, 'Secondary'),
(3, 'Parvati Devi', 37, 'Female', '2020-10-10', 6600.00, 16800.00, 'Primary'),
(3, 'Kali Kumari', 32, 'Female', '2020-11-25', 5800.00, 14000.00, 'Secondary');

-- Village 4: Lakshmipur
INSERT INTO SHG_Members (village_id, member_name, age, gender, join_date, initial_income, current_income, education_level) VALUES
(4, 'Madhuri Devi', 35, 'Female', '2021-01-10', 6000.00, 15000.00, 'Primary'),
(4, 'Jyoti Kumari', 27, 'Female', '2021-02-15', 4600.00, 11000.00, 'Secondary'),
(4, 'Deepa Devi', 38, 'Female', '2021-01-25', 6900.00, 17500.00, 'Illiterate'),
(4, 'Neeta Kumari', 30, 'Female', '2021-03-05', 5400.00, 13000.00, 'Secondary'),
(4, 'Seema Devi', 33, 'Female', '2021-02-20', 5700.00, 14200.00, 'Primary'),
(4, 'Ritu Kumari', 29, 'Female', '2021-03-18', 5000.00, 12000.00, 'Secondary'),
(4, 'Pooja Devi', 36, 'Female', '2021-01-15', 6300.00, 15800.00, 'Primary'),
(4, 'Sneha Kumari', 31, 'Female', '2021-02-28', 5600.00, 13500.00, 'Secondary'),
(4, 'Divya Devi', 34, 'Female', '2021-03-10', 5900.00, 14800.00, 'Primary'),
(4, 'Anjali Kumari', 28, 'Female', '2021-04-05', 4900.00, 11800.00, 'Secondary');

-- Village 5: Sitapur
INSERT INTO SHG_Members (village_id, member_name, age, gender, join_date, initial_income, current_income, education_level) VALUES
(5, 'Rani Devi', 37, 'Female', '2021-05-12', 6700.00, 17200.00, 'Primary'),
(5, 'Kiran Kumari', 32, 'Female', '2021-06-20', 5800.00, 14000.00, 'Secondary'),
(5, 'Maya Devi', 29, 'Female', '2021-07-08', 5100.00, 12300.00, 'Secondary'),
(5, 'Tara Kumari', 35, 'Female', '2021-05-25', 6100.00, 15200.00, 'Primary'),
(5, 'Asha Devi', 31, 'Female', '2021-06-15', 5500.00, 13200.00, 'Secondary'),
(5, 'Bharti Kumari', 33, 'Female', '2021-07-22', 5700.00, 14200.00, 'Primary'),
(5, 'Chhaya Devi', 36, 'Female', '2021-05-18', 6500.00, 16500.00, 'Primary'),
(5, 'Dipti Kumari', 30, 'Female', '2021-06-28', 5400.00, 13000.00, 'Secondary'),
(5, 'Esha Devi', 34, 'Female', '2021-07-15', 5900.00, 14800.00, 'Primary'),
(5, 'Farah Kumari', 28, 'Female', '2021-08-05', 4800.00, 11600.00, 'Secondary');

-- Insert Livelihood Activities
-- Dairy Activities
INSERT INTO Livelihood_Activity (member_id, activity_type, activity_start_date, monthly_income, investment_amount, status) VALUES
(1, 'Dairy', '2020-03-01', 12000.00, 50000.00, 'Active'),
(3, 'Dairy', '2020-01-01', 15000.00, 75000.00, 'Active'),
(5, 'Dairy', '2019-10-01', 18000.00, 100000.00, 'Active'),
(13, 'Dairy', '2020-07-01', 14000.00, 60000.00, 'Active'),
(15, 'Dairy', '2020-05-01', 17000.00, 90000.00, 'Active'),
(23, 'Dairy', '2020-11-01', 18500.00, 110000.00, 'Active'),
(33, 'Dairy', '2021-02-01', 17500.00, 95000.00, 'Active'),
(41, 'Dairy', '2021-06-01', 17200.00, 92000.00, 'Active'),
(45, 'Dairy', '2021-06-01', 16500.00, 85000.00, 'Active'),
(47, 'Dairy', '2021-07-01', 14800.00, 70000.00, 'Active');

-- Tailoring Activities
INSERT INTO Livelihood_Activity (member_id, activity_type, activity_start_date, monthly_income, investment_amount, status) VALUES
(2, 'Tailoring', '2020-04-01', 11000.00, 30000.00, 'Active'),
(4, 'Tailoring', '2020-05-01', 13500.00, 40000.00, 'Active'),
(6, 'Tailoring', '2020-07-01', 10000.00, 25000.00, 'Active'),
(11, 'Tailoring', '2020-08-01', 11200.00, 32000.00, 'Active'),
(12, 'Tailoring', '2020-09-01', 15500.00, 50000.00, 'Active'),
(14, 'Tailoring', '2020-10-01', 11800.00, 35000.00, 'Active'),
(21, 'Tailoring', '2020-12-01', 11600.00, 33000.00, 'Active'),
(24, 'Tailoring', '2021-01-01', 11000.00, 30000.00, 'Active'),
(26, 'Tailoring', '2021-03-01', 12000.00, 38000.00, 'Active'),
(28, 'Tailoring', '2021-04-01', 11800.00, 36000.00, 'Active'),
(32, 'Tailoring', '2021-06-01', 12300.00, 39000.00, 'Active'),
(34, 'Tailoring', '2021-07-01', 15200.00, 52000.00, 'Active'),
(36, 'Tailoring', '2021-08-01', 11600.00, 34000.00, 'Active');

-- Poultry Activities
INSERT INTO Livelihood_Activity (member_id, activity_type, activity_start_date, monthly_income, investment_amount, status) VALUES
(7, 'Poultry', '2020-06-01', 12500.00, 45000.00, 'Active'),
(8, 'Poultry', '2020-07-01', 11500.00, 40000.00, 'Active'),
(9, 'Poultry', '2020-08-01', 16000.00, 60000.00, 'Active'),
(16, 'Poultry', '2020-09-01', 10500.00, 35000.00, 'Active'),
(17, 'Poultry', '2020-10-01', 13800.00, 50000.00, 'Active'),
(18, 'Poultry', '2020-11-01', 13000.00, 48000.00, 'Active'),
(22, 'Poultry', '2021-01-01', 12800.00, 46000.00, 'Active'),
(25, 'Poultry', '2021-02-01', 14200.00, 55000.00, 'Active'),
(27, 'Poultry', '2021-03-01', 13000.00, 47000.00, 'Active'),
(29, 'Poultry', '2021-04-01', 13500.00, 51000.00, 'Active'),
(31, 'Poultry', '2021-05-01', 13200.00, 49000.00, 'Active'),
(35, 'Poultry', '2021-06-01', 14000.00, 53000.00, 'Active'),
(37, 'Poultry', '2021-07-01', 14800.00, 57000.00, 'Active'),
(38, 'Poultry', '2021-08-01', 13000.00, 48000.00, 'Active');

-- Handicrafts Activities
INSERT INTO Livelihood_Activity (member_id, activity_type, activity_start_date, monthly_income, investment_amount, status) VALUES
(10, 'Handicrafts', '2020-09-01', 12200.00, 35000.00, 'Active'),
(19, 'Handicrafts', '2020-12-01', 12000.00, 34000.00, 'Active'),
(20, 'Handicrafts', '2021-01-01', 14500.00, 45000.00, 'Active'),
(30, 'Handicrafts', '2021-05-01', 14800.00, 46000.00, 'Active'),
(39, 'Handicrafts', '2021-07-01', 13200.00, 38000.00, 'Active'),
(40, 'Handicrafts', '2021-08-01', 15000.00, 48000.00, 'Active'),
(42, 'Handicrafts', '2021-08-01', 11000.00, 30000.00, 'Active'),
(43, 'Handicrafts', '2021-09-01', 11800.00, 36000.00, 'Active'),
(44, 'Handicrafts', '2021-09-01', 14800.00, 47000.00, 'Active'),
(46, 'Handicrafts', '2021-09-01', 16500.00, 55000.00, 'Active'),
(48, 'Handicrafts', '2021-10-01', 13000.00, 40000.00, 'Active'),
(49, 'Handicrafts', '2021-10-01', 15200.00, 50000.00, 'Active'),
(50, 'Handicrafts', '2021-10-01', 11600.00, 33000.00, 'Active');

-- Insert SHG Loans
-- Active Loans
INSERT INTO SHG_Loans (member_id, loan_amount, loan_date, interest_rate, tenure_months, monthly_emi, total_paid, remaining_amount, status) VALUES
(1, 50000.00, '2020-03-15', 12.00, 24, 2350.00, 42300.00, 7700.00, 'Active'),
(2, 30000.00, '2020-04-20', 12.00, 18, 1800.00, 28800.00, 1200.00, 'Active'),
(3, 75000.00, '2020-01-20', 12.00, 36, 2490.00, 67200.00, 7800.00, 'Active'),
(4, 40000.00, '2020-05-10', 12.00, 24, 1880.00, 33840.00, 6160.00, 'Active'),
(5, 100000.00, '2019-10-25', 12.00, 48, 2630.00, 92000.00, 8000.00, 'Active'),
(6, 25000.00, '2020-07-15', 12.00, 18, 1500.00, 21000.00, 4000.00, 'Active'),
(7, 45000.00, '2020-06-20', 12.00, 24, 2120.00, 38160.00, 6840.00, 'Active'),
(8, 40000.00, '2020-07-25', 12.00, 24, 1880.00, 33840.00, 6160.00, 'Active'),
(9, 60000.00, '2020-08-30', 12.00, 36, 1990.00, 53730.00, 6270.00, 'Active'),
(10, 35000.00, '2020-09-10', 12.00, 24, 1650.00, 29700.00, 5300.00, 'Active'),
(11, 32000.00, '2020-08-20', 12.00, 18, 1920.00, 30720.00, 1280.00, 'Active'),
(12, 50000.00, '2020-09-25', 12.00, 36, 1660.00, 49800.00, 200.00, 'Active'),
(13, 60000.00, '2020-07-15', 12.00, 36, 1990.00, 53730.00, 6270.00, 'Active'),
(14, 35000.00, '2020-10-10', 12.00, 24, 1650.00, 29700.00, 5300.00, 'Active'),
(15, 90000.00, '2020-05-20', 12.00, 48, 2370.00, 82800.00, 7200.00, 'Active'),
(16, 35000.00, '2020-09-25', 12.00, 18, 2100.00, 33600.00, 1400.00, 'Active'),
(17, 50000.00, '2020-10-30', 12.00, 36, 1660.00, 49800.00, 200.00, 'Active'),
(18, 48000.00, '2020-11-15', 12.00, 36, 1590.00, 47700.00, 300.00, 'Active'),
(19, 34000.00, '2020-12-20', 12.00, 24, 1600.00, 28800.00, 5200.00, 'Active'),
(20, 45000.00, '2021-01-25', 12.00, 36, 1490.00, 44700.00, 300.00, 'Active'),
(21, 33000.00, '2021-01-10', 12.00, 24, 1550.00, 27900.00, 5100.00, 'Active'),
(22, 46000.00, '2021-01-20', 12.00, 36, 1520.00, 45600.00, 400.00, 'Active'),
(23, 110000.00, '2020-11-25', 12.00, 48, 2900.00, 101200.00, 8800.00, 'Active'),
(24, 30000.00, '2021-01-30', 12.00, 18, 1800.00, 28800.00, 1200.00, 'Active'),
(25, 55000.00, '2021-02-15', 12.00, 36, 1820.00, 54600.00, 400.00, 'Active'),
(26, 38000.00, '2021-03-20', 12.00, 24, 1790.00, 32220.00, 5780.00, 'Active'),
(27, 47000.00, '2021-03-25', 12.00, 36, 1560.00, 46800.00, 200.00, 'Active'),
(28, 36000.00, '2021-04-10', 12.00, 24, 1700.00, 30600.00, 5400.00, 'Active'),
(29, 51000.00, '2021-04-20', 12.00, 36, 1690.00, 50700.00, 300.00, 'Active'),
(30, 46000.00, '2021-05-15', 12.00, 36, 1520.00, 45600.00, 400.00, 'Active'),
(31, 49000.00, '2021-05-25', 12.00, 36, 1620.00, 48600.00, 400.00, 'Active'),
(32, 39000.00, '2021-06-20', 12.00, 24, 1840.00, 33120.00, 5880.00, 'Active'),
(33, 95000.00, '2021-02-25', 12.00, 48, 2500.00, 87500.00, 7500.00, 'Active'),
(34, 52000.00, '2021-07-15', 12.00, 36, 1720.00, 51600.00, 400.00, 'Active'),
(35, 53000.00, '2021-06-30', 12.00, 36, 1750.00, 52500.00, 500.00, 'Active'),
(36, 57000.00, '2021-07-25', 12.00, 36, 1890.00, 56700.00, 300.00, 'Active'),
(37, 40000.00, '2021-08-10', 12.00, 24, 1880.00, 33840.00, 6160.00, 'Active'),
(38, 48000.00, '2021-08-20', 12.00, 36, 1590.00, 47700.00, 300.00, 'Active'),
(39, 38000.00, '2021-07-30', 12.00, 24, 1790.00, 32220.00, 5780.00, 'Active'),
(40, 48000.00, '2021-08-15', 12.00, 36, 1590.00, 47700.00, 300.00, 'Active'),
(41, 92000.00, '2021-06-25', 12.00, 48, 2420.00, 84720.00, 7280.00, 'Active'),
(42, 30000.00, '2021-08-25', 12.00, 18, 1800.00, 28800.00, 1200.00, 'Active'),
(43, 36000.00, '2021-09-10', 12.00, 24, 1700.00, 30600.00, 5400.00, 'Active'),
(44, 47000.00, '2021-09-20', 12.00, 36, 1560.00, 46800.00, 200.00, 'Active'),
(45, 85000.00, '2021-06-30', 12.00, 48, 2240.00, 78200.00, 6800.00, 'Active'),
(46, 55000.00, '2021-09-25', 12.00, 36, 1820.00, 54600.00, 400.00, 'Active'),
(47, 70000.00, '2021-07-20', 12.00, 36, 2320.00, 69600.00, 400.00, 'Active'),
(48, 40000.00, '2021-10-10', 12.00, 24, 1880.00, 33840.00, 6160.00, 'Active'),
(49, 50000.00, '2021-10-20', 12.00, 36, 1660.00, 49800.00, 200.00, 'Active'),
(50, 33000.00, '2021-10-30', 12.00, 24, 1550.00, 27900.00, 5100.00, 'Active');

-- Completed Loans (for repayment analysis)
INSERT INTO SHG_Loans (member_id, loan_amount, loan_date, interest_rate, tenure_months, monthly_emi, total_paid, remaining_amount, status) VALUES
(1, 20000.00, '2019-06-01', 12.00, 12, 1770.00, 21240.00, 0.00, 'Completed'),
(2, 15000.00, '2019-08-15', 12.00, 12, 1330.00, 15960.00, 0.00, 'Completed'),
(3, 30000.00, '2019-05-10', 12.00, 18, 1800.00, 32400.00, 0.00, 'Completed'),
(4, 18000.00, '2019-09-20', 12.00, 12, 1600.00, 19200.00, 0.00, 'Completed'),
(5, 40000.00, '2019-04-05', 12.00, 24, 1880.00, 45120.00, 0.00, 'Completed'),
(6, 12000.00, '2019-10-10', 12.00, 12, 1060.00, 12720.00, 0.00, 'Completed'),
(7, 25000.00, '2019-07-15', 12.00, 18, 1500.00, 27000.00, 0.00, 'Completed'),
(8, 20000.00, '2019-08-20', 12.00, 12, 1770.00, 21240.00, 0.00, 'Completed'),
(9, 35000.00, '2019-09-25', 12.00, 24, 1650.00, 39600.00, 0.00, 'Completed'),
(10, 15000.00, '2019-11-05', 12.00, 12, 1330.00, 15960.00, 0.00, 'Completed');

