# IT Support Ticket Analytics --- Interview Guide

## 30-Second Introduction

> I built an IT Support Ticket Analytics Dashboard using Python, SQL,
> and Power BI. I worked with 3,500 synthetic support-ticket records
> covering January 2025 to August 2026. I first generated and cleaned
> the data using Python and Pandas, then loaded it into MySQL for SQL
> analysis. Finally, I connected MySQL to Power BI and created a
> three-page dashboard covering ticket volume, SLA performance,
> resolution time, recurring issues, reopened tickets, and customer
> satisfaction.

## 1-Minute Explanation

> The project was designed to analyze the performance of an IT support
> operation. I started by creating a synthetic dataset because real
> company support data can be confidential. I created 3,500 records with
> fields such as ticket ID, dates, team, category, priority, status,
> resolution time, SLA status, reopened status, and customer
> satisfaction.
>
> I introduced realistic data-quality problems such as missing values,
> duplicate records, inconsistent categories, and missing date values. I
> then used Python and Pandas to explore, clean, standardize, and
> validate the data.
>
> After cleaning, I loaded the data into MySQL and used SQL to analyze
> ticket volume, team performance, SLA performance, resolution time,
> recurring issues, reopened tickets, and monthly trends.
>
> Finally, I connected MySQL to Power BI and created three dashboard
> pages: Support Overview, SLA & Resolution, and Issue & Customer
> Analysis. I used DAX measures for KPIs such as total tickets, average
> resolution time, SLA breach rate, reopened tickets, and customer
> satisfaction.

## Explain the Workflow

``` text
Business Problem
      ↓
Data Generation
      ↓
Data Exploration
      ↓
Data Cleaning
      ↓
Data Validation
      ↓
MySQL
      ↓
SQL Analysis
      ↓
Power BI
      ↓
DAX
      ↓
Dashboard
      ↓
Insights
```

## Why Synthetic Data?

> Real IT support data can contain confidential company and customer
> information, so I used synthetic data for this portfolio project. I
> designed it to represent a realistic support environment and included
> common data-quality problems so I could demonstrate the complete
> analytics workflow.

## Why Python?

> I used Python and Pandas for data generation, exploration, cleaning,
> and validation. Pandas made it easy to identify missing values,
> duplicates, inconsistent categories, and invalid dates.

## What Cleaning Did You Perform?

> I handled missing category values, standardized category names,
> checked duplicate ticket IDs, validated dates, handled missing
> resolved dates for resolved tickets, and checked for invalid or
> negative resolution times. After cleaning, I validated the final
> dataset.

## Why MySQL?

> I used MySQL to store the cleaned data and perform structured SQL
> analysis. It also demonstrates database and SQL skills separately from
> Python.

## Why a Staging Table?

> During CSV import, blank values in numeric columns caused import
> errors. I first imported the CSV into a staging table where fields
> were stored as text. Then I converted the values while inserting them
> into the final table. This made the import more reliable.

## What SQL Analysis Did You Perform?

> I analyzed ticket volume, status, priority, categories, average
> resolution time, SLA performance, team performance, recurring issues,
> monthly trends, reopened tickets, customer satisfaction,
> category-level SLA performance, rankings, and month-over-month trends.

## What Is SLA?

> SLA stands for Service Level Agreement. It defines the expected
> service or resolution time for a ticket.

## What Is DAX?

> DAX stands for Data Analysis Expressions. It is the formula language
> used in Power BI to create measures and calculations.

## Why Measures?

> Measures calculate values dynamically based on filters and slicers.
> For example, when a user selects a team, the average resolution time
> can automatically recalculate for that team.

## Explain the Three Power BI Pages

### Page 1 --- Support Overview

> This page gives a high-level view of the support operation. It shows
> total tickets, resolved, open, in-progress tickets, average resolution
> time, SLA breach rate, customer satisfaction, reopened tickets, and
> trends by month, status, priority, and team.

### Page 2 --- SLA & Resolution

> This page focuses on operational performance. It shows SLA met and
> breached tickets, average resolution time, reopened rate, customer
> satisfaction, SLA status, team SLA breach rate, team resolution time,
> and resolution trends.

### Page 3 --- Issue & Customer Analysis

> This page focuses on recurring issues and customer-related measures.
> It shows issue categories, reopened tickets, customer satisfaction,
> the highest-volume category, the highest SLA breach category, ticket
> volume by category, customer satisfaction by category, and reopened
> tickets by category.

## Main Findings

> The project had 3,500 tickets. Service Desk handled the highest volume
> with 1,225 tickets. March had the highest monthly volume with 375
> tickets. Medium priority had the highest volume with 1,641 tickets.
> Average resolution time was 11.98 hours, SLA breach rate was 12.17%,
> average customer satisfaction was 3.67 out of 5, and 213 tickets were
> reopened. Password Reset was the highest-volume category with 565
> tickets.

## Most Difficult Part

> One challenging part was loading the CSV into MySQL because blank
> values in numeric columns caused import errors. I solved this by using
> a staging table with text columns and then converting values while
> inserting them into the final table.

## What Would You Improve?

> In a production environment, I would automate the ETL process, connect
> Power BI to a live support-ticket database, add scheduled refresh,
> create a proper date dimension, and add more detailed agent-level
> KPIs.

## Important Interview Rule

Say:

> This is a portfolio project using synthetic data designed to represent
> an IT support environment.

Do not say that it is real company data.

## Resume Version

**IT Support Ticket Analytics Dashboard \| Python, SQL, Power BI**

-   Cleaned and validated 3,500 IT support ticket records using Python
    and Pandas, handling missing values, duplicates, inconsistent
    categories, and date issues.
-   Used MySQL and SQL to analyze ticket volume, SLA performance,
    resolution time, recurring issues, reopened tickets, and monthly
    trends.
-   Built a 3-page interactive Power BI dashboard using DAX measures to
    monitor ticket volume, SLA breach rate, resolution time, customer
    satisfaction, and issue categories.
