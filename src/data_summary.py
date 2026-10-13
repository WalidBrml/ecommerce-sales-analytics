
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


    # BUSINESS INSIGHTS

    best_month = sales.loc[sales["total_revenue"].idxmax()]
    worst_month = sales.loc[sales["total_revenue"].idxmin()]
    best_order_month = sales.loc[sales["total_orders"].idxmax()]

    print("\nBUSINESS INSIGHTS")
    print("=" * 40)

    print(
        f"Highest revenue month: {best_month['month']} "
        f"({best_month['total_revenue']:,.2f})"
    )

    print(
        f"Lowest revenue month: {worst_month['month']} "
        f"({worst_month['total_revenue']:,.2f})"
    )

    print(
        f"Highest order volume: {best_order_month['month']} "
        f"({best_order_month['total_orders']:,} orders)"
    )


if __name__ == "__main__":
    main()
