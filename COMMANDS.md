# Complete Command Reference

## 📦 Initial Setup Commands

### Install Python Dependencies
```bash
pip install -r requirements.txt
```

### Install Specific Packages (if needed)
```bash
pip install pandas numpy matplotlib seaborn xlrd openpyxl
```

---

## 🗄️ Database Setup Commands

### Option 1: Using Setup Script (Recommended)
```bash
python setup_database.py
```

### Option 2: Manual Database Creation
```bash
# Create database schema
sqlite3 shg_database.db < database_schema.sql

# Insert sample data
sqlite3 shg_database.db < insert_sample_data.sql
```

### Option 3: Using SQLite Command Line (Interactive)
```bash
sqlite3 shg_database.db
```
Then inside SQLite:
```sql
.read database_schema.sql
.read insert_sample_data.sql
.quit
```

---

## 📊 Analysis Commands

### Run Complete Analysis
```bash
python shg_analysis.py
```

### Extract XLS Data
```bash
python extract_xls_data.py
```

---

## 🔍 SQL Query Commands

### Run All Analytical Queries
```bash
sqlite3 shg_database.db < analytical_queries.sql
```

### Run Individual Query (Interactive SQLite)
```bash
sqlite3 shg_database.db
```
Then paste your query and run it.

### Export Query Results to CSV
```bash
sqlite3 -header -csv shg_database.db "SELECT * FROM SHG_Members;" > members_export.csv
```

### View Database Schema
```bash
sqlite3 shg_database.db ".schema"
```

### View All Tables
```bash
sqlite3 shg_database.db ".tables"
```

### View Table Structure
```bash
sqlite3 shg_database.db "PRAGMA table_info(SHG_Members);"
```

---

## 📈 Quick Analysis Commands

### Count Records in Each Table
```bash
sqlite3 shg_database.db "SELECT 'Villages' as Table, COUNT(*) as Count FROM Villages UNION ALL SELECT 'Members', COUNT(*) FROM SHG_Members UNION ALL SELECT 'Activities', COUNT(*) FROM Livelihood_Activity UNION ALL SELECT 'Loans', COUNT(*) FROM SHG_Loans;"
```

### View Top 10 Earners
```bash
sqlite3 -header -csv shg_database.db "SELECT m.member_name, v.village_name, m.current_income FROM SHG_Members m JOIN Villages v ON m.village_id = v.village_id ORDER BY m.current_income DESC LIMIT 10;"
```

### Calculate Average Income Growth
```bash
sqlite3 shg_database.db "SELECT AVG((current_income - initial_income) * 100.0 / initial_income) as avg_growth_percent FROM SHG_Members;"
```

---

## 🧹 Cleanup Commands

### Delete Database (Start Fresh)
```bash
# Windows PowerShell
Remove-Item shg_database.db

# Windows CMD
del shg_database.db

# Linux/Mac
rm shg_database.db
```

### Delete All Generated Files
```bash
# Windows PowerShell
Remove-Item *.png, export_*.csv, extracted_*.csv

# Windows CMD
del *.png export_*.csv extracted_*.csv

# Linux/Mac
rm *.png export_*.csv extracted_*.csv
```

### Delete Only PNG Files
```bash
# Windows PowerShell
Remove-Item *.png

# Windows CMD
del *.png

# Linux/Mac
rm *.png
```

---

## 🔄 Complete Workflow Commands

### Full Setup and Analysis (Fresh Start)
```bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Remove old database (if exists)
Remove-Item shg_database.db -ErrorAction SilentlyContinue

# 3. Create database
python setup_database.py

# 4. Run analysis
python shg_analysis.py

# 5. Extract XLS data (optional)
python extract_xls_data.py
```

### Quick Re-run Analysis (Database Exists)
```bash
python shg_database.py
```

---

## 🐍 Python Interactive Commands

### Open Python with Database Access
```bash
python
```
Then in Python:
```python
import sqlite3
import pandas as pd

conn = sqlite3.connect('shg_database.db')
df = pd.read_sql_query("SELECT * FROM SHG_Members", conn)
print(df.head())
conn.close()
```

### Run Python Script with Output
```bash
python shg_analysis.py > analysis_output.txt
```

---

## 📤 Export Commands

### Export Entire Database to SQL
```bash
sqlite3 shg_database.db .dump > database_backup.sql
```

### Export Specific Table to CSV
```bash
sqlite3 -header -csv shg_database.db "SELECT * FROM Villages;" > villages.csv
sqlite3 -header -csv shg_database.db "SELECT * FROM SHG_Members;" > members.csv
sqlite3 -header -csv shg_database.db "SELECT * FROM Livelihood_Activity;" > activities.csv
sqlite3 -header -csv shg_database.db "SELECT * FROM SHG_Loans;" > loans.csv
```

### Export Query Results
```bash
sqlite3 -header -csv shg_database.db "SELECT village_name, COUNT(*) as members FROM Villages v JOIN SHG_Members m ON v.village_id = m.village_id GROUP BY village_name;" > village_members.csv
```

---

## 🔍 Verification Commands

### Check Database File Exists
```bash
# Windows PowerShell
Test-Path shg_database.db

# Windows CMD
if exist shg_database.db echo Database exists

# Linux/Mac
test -f shg_database.db && echo "Database exists"
```

### Check Python Packages
```bash
python -c "import pandas, numpy, matplotlib, seaborn; print('All packages installed')"
```

### Verify Database Integrity
```bash
sqlite3 shg_database.db "PRAGMA integrity_check;"
```

### Check Table Row Counts
```bash
sqlite3 shg_database.db "SELECT 'Villages' as table_name, COUNT(*) as count FROM Villages UNION ALL SELECT 'SHG_Members', COUNT(*) FROM SHG_Members UNION ALL SELECT 'Livelihood_Activity', COUNT(*) FROM Livelihood_Activity UNION ALL SELECT 'SHG_Loans', COUNT(*) FROM SHG_Loans;"
```

---

## 🛠️ Development Commands

### Run with Verbose Output
```bash
python -u shg_analysis.py
```

### Run Python Script with Error Traceback
```bash
python -v shg_analysis.py
```

### Check Python Version
```bash
python --version
```

### Check pip Version
```bash
pip --version
```

### Upgrade pip
```bash
python -m pip install --upgrade pip
```

---

## 📝 Git Commands (if using version control)

### Initialize Git Repository
```bash
git init
```

### Add Files
```bash
git add .
```

### Commit Changes
```bash
git commit -m "Initial SHG analysis project"
```

### Create .gitignore (already created)
```bash
# Already exists, but to recreate:
# See .gitignore file
```

---

## 🎯 Most Common Commands (Quick Reference)

```bash
# 1. Setup (first time only)
pip install -r requirements.txt
python setup_database.py

# 2. Run Analysis (every time you want results)
python shg_analysis.py

# 3. View Database (using DB Browser for SQLite - GUI tool)
# Download from: https://sqlitebrowser.org/
# Then open: shg_database.db

# 4. Run SQL Queries
sqlite3 shg_database.db
# Then paste queries from analytical_queries.sql
```

---

## 💡 Tips

1. **Always run setup first**: `python setup_database.py`
2. **Check if database exists** before running setup again
3. **Use DB Browser for SQLite** for visual database exploration
4. **Export queries to CSV** for further analysis in Excel
5. **Keep generated files** (PNG, CSV) for your portfolio

---

## 🆘 Troubleshooting Commands

### Check if SQLite is installed
```bash
sqlite3 --version
```

### Reinstall Python packages
```bash
pip uninstall -r requirements.txt -y
pip install -r requirements.txt
```

### Check file permissions (Linux/Mac)
```bash
ls -la shg_database.db
chmod 644 shg_database.db
```

### View Python path
```bash
python -c "import sys; print(sys.path)"
```

---

**Note**: Commands are shown for Windows PowerShell. For Linux/Mac, replace `Remove-Item` with `rm` and adjust paths as needed.

