
from pathlib import Path
import pandas as pd

# Project root directory
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# Location of the SQL analysis exports
DATA_FILE = (
    PROJECT_ROOT
    / "data"
    / "processed"
    / "sql_exports"
    / "monthly_sales.csv"
)


def main():
    if not DATA_FILE.exists():
        print(f"File not found: {DATA_FILE}")
        return

    sales = pd.read_csv(DATA_FILE)

    print("MONTHLY SALES SUMMARY")
    print("-" * 40)
    print(f"Months analyzed: {len(sales)}")
    print(f"Total orders: {sales['total_orders'].sum():,}")
    print(f"Total items sold: {sales['total_items'].sum():,}")
    print(f"Total revenue: R$ {sales['total_revenue'].sum():,.2f}")


if __name__ == "__main__":
    main()
