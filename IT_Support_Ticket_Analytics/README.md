# IT Support Ticket Analytics Dashboard

## Project Overview

An end-to-end Data Analytics portfolio project using Python, Pandas,
MySQL, SQL, and Power BI to analyze IT support tickets.

The project uses **3,500 synthetic support-ticket records** covering
**January 2025 to August 2026**.

> The dataset is synthetic and created for learning/portfolio
> demonstration. It does not contain confidential company or customer
> data.

## Business Problem

The project answers practical support-management questions:

-   How many tickets are received?
-   Which teams and categories have the highest volume?
-   How long do tickets take to resolve?
-   What is the SLA breach rate?
-   Which categories have higher SLA breach rates?
-   How many tickets are reopened?
-   What is customer satisfaction?
-   How does ticket volume change over time?

## End-to-End Workflow

**Data Generation → Data Exploration → Data Cleaning → Data Validation →
MySQL → SQL Analysis → Power BI → DAX → Dashboard → Business Insights**

## Tools

-   Python
-   Pandas
-   Jupyter Notebook
-   MySQL
-   SQL
-   Power BI
-   DAX
-   GitHub

## Project Structure

``` text
IT_Support_Ticket_Analytics/
├── 01_Raw_Data/
│   └── IT_Support_Tickets_Raw.csv
├── 02_Python/
│   └── 01_Explore_and_Generate_Data.ipynb
├── 03_Cleaned_Data/
│   └── IT_Support_Tickets_Cleaned.csv
├── 04_SQL/
│   └── IT_Support_Ticket_Analysis.sql
├── 05_PowerBI/
│   └── IT Support Ticket Analytics.pbix
├── 06_Documentation/
    ├── README.md
    ├── INTERVIEW_GUIDE.md

```

## 1. Data Preparation

A synthetic dataset of 3,500 support tickets was generated with Python.
The data contains fields such as Ticket_ID, Created_Date, Team,
Category, Priority, Status, Request_Type, Assigned_Agent,
SLA_Target_Hours, Resolution_Hours, Resolved_Date, SLA_Status, Reopened,
and Customer_Satisfaction.

The date range is January 1, 2025 to August 31, 2026.

A fixed random seed was used so the generated dataset could be
reproduced.

## 2. Data Quality Problems

Real-world data is rarely perfect, so realistic issues were introduced
for the cleaning exercise:

-   Missing Category values
-   Inconsistent category values
-   Duplicate ticket records
-   Missing or invalid Resolved_Date values
-   Missing Customer_Satisfaction values

The raw file was saved in `01_Raw_Data`.

## 3. Data Cleaning with Python/Pandas

The data was explored and cleaned in Jupyter Notebook.

Main cleaning activities:

-   Checked rows, columns, data types, and missing values
-   Replaced missing Category values with `Unknown`
-   Standardized category names
-   Checked and removed duplicate Ticket_ID values
-   Validated Created_Date and Resolved_Date
-   Reconstructed appropriate missing resolved dates for resolved
    tickets using Created_Date and Resolution_Hours
-   Checked for negative resolution times
-   Kept missing customer satisfaction as missing instead of inventing
    ratings

The cleaned file was saved in `03_Cleaned_Data`.

## 4. Data Validation

Final validation confirmed:

-   3,500 rows
-   14 columns
-   0 duplicate Ticket_ID values
-   0 missing Category values
-   0 invalid dates
-   0 negative Resolution_Hours
-   0 unresolved tickets with Resolution_Hours
-   0 resolved tickets without Resolution_Hours
-   0 resolved tickets without Resolved_Date

## 5. MySQL

The cleaned data was loaded into MySQL database:

`it_support_analytics`

Main table:

`tickets`

A staging table was used during CSV import so blank values could be
handled safely before conversion to final numeric and date data types.

## 6. SQL Analysis

The SQL analysis covers:

1.  Total tickets
2.  Tickets by status
3.  Tickets by priority
4.  Tickets by category
5.  Average resolution time
6.  SLA met vs breached
7.  SLA breach rate
8.  Team performance
9.  Recurring issues
10. Monthly ticket trend
11. SLA breach by category
12. SLA breach rate by category
13. Average resolution by priority
14. Team SLA performance
15. Reopened tickets
16. Customer satisfaction
17. High-resolution-time categories
18. Team/category counts
19. Ranking and top categories
20. Monthly volume and month-over-month analysis using `LAG`

The SQL file is in `04_SQL`.

## 7. Power BI Dashboard

The report has three pages.

### Page 1 --- Support Overview

KPIs:

-   Total Tickets
-   Resolved Tickets
-   Open Tickets
-   In Progress Tickets
-   Average Resolution Hours
-   SLA Breach Rate
-   Average Customer Satisfaction
-   Reopened Tickets

Visuals include monthly ticket trend, status, priority, and team
analysis.

### Page 2 --- SLA & Resolution

KPIs:

-   SLA Met
-   SLA Breached
-   Average Resolution Hours
-   Reopened Rate
-   Average Customer Satisfaction

Visuals include SLA status, team SLA breach rate, team resolution time,
and resolution trends.

### Page 3 --- Issue & Customer Analysis

KPIs:

-   Issue Categories
-   Reopened Tickets
-   Average Customer Satisfaction
-   Category with Most Tickets
-   Highest SLA Breach Category

Visuals include tickets by category, customer satisfaction by category,
reopened tickets by category, and key insights.

## 8. Important DAX Measures

Example:

``` dax
Total Tickets =
COUNTROWS('it_support_analytics tickets')
```

``` dax
Avg Resolution Hours =
AVERAGE('it_support_analytics tickets'[Resolution_Hours])
```

``` dax
Reopened Tickets =
CALCULATE(
    COUNTROWS('it_support_analytics tickets'),
    'it_support_analytics tickets'[Reopened] = "Yes"
)
```

``` dax
Avg Customer Satisfaction =
AVERAGE('it_support_analytics tickets'[Customer_Satisfaction])
```

## 9. Key Findings

-   3,500 tickets were analyzed.
-   Service Desk handled the highest volume with 1,225 tickets.
-   March had the highest monthly volume with 375 tickets.
-   Medium priority recorded the highest volume with 1,641 tickets.
-   Critical priority recorded 319 tickets.
-   Average resolution time was 11.98 hours.
-   SLA breach rate was 12.17%.
-   Average customer satisfaction was 3.67 / 5.
-   213 tickets were reopened.
-   Password Reset was the highest-volume category with 565 tickets.

## 10. Business Value

The dashboard helps a support manager quickly understand ticket demand,
recurring issues, team workload, SLA performance, resolution time,
reopened tickets, and customer satisfaction.

Instead of manually reviewing thousands of records, users can interact
with the Power BI dashboard and filter results by date, team, priority,
status, and category.

## 11. How to Run

1.  Open the Jupyter notebook in `02_Python`.
2.  Review the data-generation and cleaning workflow.
3.  Review the cleaned CSV in `03_Cleaned_Data`.
4.  Create/load the MySQL database and `tickets` table.
5.  Run the SQL file in `04_SQL`.
6.  Open the PBIX file in `05_PowerBI`.
7.  Refresh the Power BI connection if required.

## Portfolio Note

This project demonstrates an end-to-end Data Analyst workflow:

**Python → SQL → Power BI → Business Insights**

It is a portfolio project using synthetic data.
