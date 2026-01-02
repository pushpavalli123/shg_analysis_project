# Quick Start Guide

## 🚀 Get Started in 3 Steps

### Step 1: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 2: Setup Database
```bash
python setup_database.py
```

This will create the SQLite database with:
- 5 Villages
- 50 SHG Members
- 50 Livelihood Activities
- 60 SHG Loans

### Step 3: Run Analysis
```bash
python shg_analysis.py
```

This will generate:
- 4 visualization PNG files
- Multiple CSV export files
- Comprehensive analysis reports

## 📊 What You'll Get

### Visualizations
1. **income_growth_by_activity.png** - Income growth analysis by activity type
2. **loan_repayment_analysis.png** - Loan repayment rates and analysis
3. **member_distribution_analysis.png** - Member demographics and distribution
4. **top_earners_analysis.png** - Top performing members

### Data Exports
- `export_members.csv` - All member data
- `export_activities.csv` - All livelihood activities
- `export_loans.csv` - All loan data
- `export_villages.csv` - Village information
- `export_members_villages.csv` - Merged member-village data
- `export_members_activities.csv` - Merged member-activity data
- `export_members_loans.csv` - Merged member-loan data

## 🔍 Run SQL Queries

### Using DB Browser for SQLite
1. Download and install [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Open `shg_database.db`
3. Go to "Execute SQL" tab
4. Copy queries from `analytical_queries.sql` and run them

### Using Command Line
```bash
sqlite3 shg_database.db
.read analytical_queries.sql
```

## 📈 Key Metrics You'll See

- **Average Income Growth**: ~146%
- **Top Activities**: Dairy and Tailoring show highest growth
- **Loan Repayment Rate**: Tracked by village
- **Member Distribution**: Age groups, education levels, villages

## 🎯 Next Steps

1. Explore the SQL queries in `analytical_queries.sql`
2. Customize the analysis in `shg_analysis.py`
3. Process the original XLS file: `python extract_xls_data.py`
4. Add your own queries and visualizations

## 💡 Tips

- The database is automatically created if it doesn't exist
- All generated files (PNG, CSV) are in the project root
- You can modify sample data in `insert_sample_data.sql`
- Add more villages/members by extending the SQL insert scripts

## 🐛 Troubleshooting

**Issue**: Module not found errors
**Solution**: Run `pip install -r requirements.txt`

**Issue**: Database locked error
**Solution**: Close any other programs using the database (DB Browser, etc.)

**Issue**: Charts not displaying
**Solution**: Check if matplotlib backend is properly configured

---

Happy Analyzing! 📊

