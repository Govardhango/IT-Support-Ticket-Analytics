
CREATE DATABASE it_support_analytics;
USE it_support_analytics;

CREATE TABLE tickets (
    Ticket_ID VARCHAR(20),
    Created_Date DATETIME,
    Team VARCHAR(50),
    Category VARCHAR(50),
    Priority VARCHAR(20),
    Status VARCHAR(20),
    Request_Type VARCHAR(30),
    Assigned_Agent VARCHAR(30),
    SLA_Target_Hours INT,
    Resolution_Hours DECIMAL(10,2),
    Resolved_Date DATETIME,
    SLA_Status VARCHAR(20),
    Reopened VARCHAR(10),
    Customer_Satisfaction DECIMAL(3,1)
);
CREATE TABLE tickets_staging (
    Ticket_ID VARCHAR(100),
    Created_Date VARCHAR(100),
    Team VARCHAR(100),
    Category VARCHAR(100),
    Priority VARCHAR(100),
    Status VARCHAR(100),
    Request_Type VARCHAR(100),
    Assigned_Agent VARCHAR(100),
    SLA_Target_Hours VARCHAR(100),
    Resolution_Hours VARCHAR(100),
    Resolved_Date VARCHAR(100),
    SLA_Status VARCHAR(100),
    Reopened VARCHAR(100),
    Customer_Satisfaction VARCHAR(100)
);

TRUNCATE TABLE tickets;

-- if empty sting in csv unable to load in to database use below process
INSERT INTO tickets (
    Ticket_ID,
    Created_Date,
    Team,
    Category,
    Priority,
    Status,
    Request_Type,
    Assigned_Agent,
    SLA_Target_Hours,
    Resolution_Hours,
    Resolved_Date,
    SLA_Status,
    Reopened,
    Customer_Satisfaction
)
SELECT
    NULLIF(TRIM(Ticket_ID), ''),

    STR_TO_DATE(
        NULLIF(TRIM(Created_Date), ''),
        '%Y-%m-%d %H:%i:%s'
    ),

    NULLIF(TRIM(Team), ''),
    NULLIF(TRIM(Category), ''),
    NULLIF(TRIM(Priority), ''),
    NULLIF(TRIM(Status), ''),
    NULLIF(TRIM(Request_Type), ''),
    NULLIF(TRIM(Assigned_Agent), ''),

    CAST(
        NULLIF(TRIM(SLA_Target_Hours), '')
        AS UNSIGNED
    ),

    CAST(
        NULLIF(TRIM(Resolution_Hours), '')
        AS DECIMAL(10,2)
    ),

    STR_TO_DATE(
        NULLIF(TRIM(Resolved_Date), ''),
        '%Y-%m-%d %H:%i:%s'
    ),

    NULLIF(TRIM(SLA_Status), ''),
    NULLIF(TRIM(Reopened), ''),

    CAST(
        NULLIF(TRIM(Customer_Satisfaction), '')
        AS DECIMAL(3,1)
    )

FROM tickets_staging;


-- Total number of tickets : This tells us the total number of tickets in our dataset.
SELECT COUNT(*) AS Total_Tickets FROM tickets;

-- Tickets by Status : This tells us how many tickets are: Resolved,In Progress,Open,Pending
SELECT Status, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Status
ORDER BY Ticket_Count DESC;

-- Tickets by Priority : This helps us understand the workload based on ticket priority.
SELECT Priority, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Priority
ORDER BY Ticket_Count DESC;

-- Tickets by Category : This is an important analysis because it shows which types of IT issues occur most frequently.
SELECT Category, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Category
ORDER BY Ticket_Count DESC;

-- Average Resolution Time : 
SELECT ROUND(AVG(Resolution_Hours), 2) AS Avg_Resolution_Hours
FROM tickets
WHERE Status = 'Resolved';

-- SLA Met vs Breached
SELECT SLA_Status, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY SLA_Status
ORDER BY Ticket_Count DESC;

-- SLA Breach Rate : it calculate the percentage of resolved tickets that breached SLA.
SELECT
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END)
        /
        SUM(CASE
            WHEN SLA_Status IN ('Met', 'Breached') THEN 1
            ELSE 0
        END),
        2
    ) AS SLA_Breach_Rate_Percent
FROM tickets;


-- Team Performance : This is useful for identifying workload and resolution-time patterns by team.
SELECT Team, COUNT(*) AS Total_Tickets, ROUND(AVG(Resolution_Hours), 2) AS Avg_Resolution_Hours
FROM tickets
GROUP BY Team
ORDER BY Total_Tickets DESC;

-- Top Recurring Issues :  This gives us the 5 most common issue categories.
SELECT Category, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Category
ORDER BY Ticket_Count DESC
LIMIT 5;

-- Monthly Ticket Trend : This shows how ticket volume changed month by month.
SELECT DATE_FORMAT(Created_Date, '%Y-%m') AS Ticket_Month, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY DATE_FORMAT(Created_Date, '%Y-%m')
ORDER BY Ticket_Month;

-- SLA Breach by Category : We want to know which issue categories have the most SLA breaches.
SELECT Category,COUNT(*) AS Total_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches
FROM tickets
GROUP BY Category
ORDER BY SLA_Breaches DESC;

-- SLA Breach Rate by Category
SELECT Category, COUNT(*) AS Total_Resolved_Tickets,
    SUM(CASE
        WHEN SLA_Status = 'Breached' THEN 1
        ELSE 0
    END) AS SLA_Breaches,
    ROUND(
        100.0 * SUM(CASE
            WHEN SLA_Status = 'Breached' THEN 1
            ELSE 0
        END)
        /
        COUNT(*),
        2
    ) AS SLA_Breach_Rate
FROM tickets
WHERE SLA_Status IN ('Met', 'Breached')
GROUP BY Category
ORDER BY SLA_Breach_Rate DESC;

-- Reopened Tickets : how many tickets were reopened.
SELECT Reopened, COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Reopened;
-- Then calculate the reopening percentage:
SELECT
    ROUND(
        100.0 * SUM(CASE
            WHEN Reopened = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS Reopened_Rate
FROM tickets;


-- Customer Satisfaction : Let's check the average satisfaction score.
SELECT
    ROUND(AVG(Customer_Satisfaction), 2) AS Avg_Satisfaction
FROM tickets
WHERE Customer_Satisfaction IS NOT NULL;
-- satisfaction by category:
SELECT Category, ROUND(AVG(Customer_Satisfaction), 2) AS Avg_Satisfaction, COUNT(Customer_Satisfaction) AS Responses
FROM tickets
WHERE Customer_Satisfaction IS NOT NULL
GROUP BY Category
ORDER BY Avg_Satisfaction DESC;


-- Identify High-Resolution-Time Issues : Let's find categories where the average resolution time is high.
SELECT Category, COUNT(*) AS Resolved_Tickets, ROUND(AVG(Resolution_Hours), 2) AS Avg_Resolution_Hours
FROM tickets
WHERE Status = 'Resolved'
GROUP BY Category
HAVING COUNT(*) >= 20
ORDER BY Avg_Resolution_Hours DESC;

-- Find the Most Common Issue for Each Team : This gives us the team/category combinations.
SELECT Team, Category,COUNT(*) AS Ticket_Count
FROM tickets
GROUP BY Team, Category
ORDER BY Team, Ticket_Count DESC;

-- Rank issue categories within each team : We want to find which categories have the highest number of tickets within each team.
SELECT Team, Category, COUNT(*) AS Ticket_Count,
    RANK() OVER (
        PARTITION BY Team
        ORDER BY COUNT(*) DESC
    ) AS Category_Rank
FROM tickets
GROUP BY Team, Category
ORDER BY Team, Category_Rank;

-- Get only the top category for each team : I used a CTE with the RANK window function to identify the highest-volume ticket category within each support team
WITH category_ranking AS (
    SELECT
        Team,
        Category,
        COUNT(*) AS Ticket_Count,
        RANK() OVER (
            PARTITION BY Team
            ORDER BY COUNT(*) DESC
        ) AS Category_Rank
    FROM tickets
    GROUP BY Team, Category
)

SELECT
    Team,
    Category,
    Ticket_Count
FROM category_ranking
WHERE Category_Rank = 1
ORDER BY Team;

-- Top 3 categories for each team : This gives the top 3 issue categories for every team.
WITH category_ranking AS (
    SELECT
        Team,
        Category,
        COUNT(*) AS Ticket_Count,
        RANK() OVER (
            PARTITION BY Team
            ORDER BY COUNT(*) DESC
        ) AS Category_Rank
    FROM tickets
    GROUP BY Team, Category
)

SELECT
    Team,
    Category,
    Ticket_Count,
    Category_Rank
FROM category_ranking
WHERE Category_Rank <= 3
ORDER BY Team, Category_Rank;

-- Top 3 categories overall : 
WITH category_counts AS (
    SELECT
        Category,
        COUNT(*) AS Ticket_Count
    FROM tickets
    GROUP BY Category
),

ranked_categories AS (
    SELECT
        Category,
        Ticket_Count,
        DENSE_RANK() OVER (
            ORDER BY Ticket_Count DESC
        ) AS Category_Rank
    FROM category_counts
)

SELECT
    Category,
    Ticket_Count,
    Category_Rank
FROM ranked_categories
WHERE Category_Rank <= 3
ORDER BY Category_Rank;

-- Team resolution performance ranking : Now let's rank teams based on average resolution time.
WITH team_performance AS (
    SELECT
        Team,
        COUNT(*) AS Resolved_Tickets,
        ROUND(AVG(Resolution_Hours), 2) AS Avg_Resolution_Hours
    FROM tickets
    WHERE Status = 'Resolved'
    GROUP BY Team
)

SELECT
    Team,
    Resolved_Tickets,
    Avg_Resolution_Hours,
    RANK() OVER (
        ORDER BY Avg_Resolution_Hours
    ) AS Resolution_Rank
FROM team_performance
ORDER BY Resolution_Rank;

-- Monthly ticket volume + month-over-month change : 
WITH monthly_tickets AS (
    SELECT
        DATE_FORMAT(Created_Date, '%Y-%m') AS Ticket_Month,
        COUNT(*) AS Ticket_Count
    FROM tickets
    GROUP BY DATE_FORMAT(Created_Date, '%Y-%m')
)

SELECT
    Ticket_Month,
    Ticket_Count,
    LAG(Ticket_Count) OVER (
        ORDER BY Ticket_Month
    ) AS Previous_Month_Tickets
FROM monthly_tickets
ORDER BY Ticket_Month;

-- Calculate month-over-month growth % : Now let's calculate the percentage change.
WITH monthly_tickets AS (
    SELECT
        DATE_FORMAT(Created_Date, '%Y-%m') AS Ticket_Month,
        COUNT(*) AS Ticket_Count
    FROM tickets
    GROUP BY DATE_FORMAT(Created_Date, '%Y-%m')
),

monthly_comparison AS (
    SELECT
        Ticket_Month,
        Ticket_Count,
        LAG(Ticket_Count) OVER (
            ORDER BY Ticket_Month
        ) AS Previous_Month_Tickets
    FROM monthly_tickets
)

SELECT
    Ticket_Month,
    Ticket_Count,
    Previous_Month_Tickets,
    ROUND(
        100.0 * (Ticket_Count - Previous_Month_Tickets)
        / NULLIF(Previous_Month_Tickets, 0),
        2
    ) AS MoM_Growth_Percent
FROM monthly_comparison
ORDER BY Ticket_Month;

/*
| Area             | SQL concepts                    |
| ---------------- | ------------------------------- |
| Ticket volume    | `COUNT`, `GROUP BY`             |
| Categories       | `GROUP BY`, `ORDER BY`          |
| SLA              | `CASE`, conditional aggregation |
| Resolution time  | `AVG`                           |
| Filtering groups | `HAVING`                        |
| Team analysis    | `GROUP BY`                      |
| Top issues       | `RANK()`                        |
| Top 3 per team   | `RANK() + CTE`                  |
| Monthly trends   | `DATE_FORMAT()`                 |
| MoM analysis     | `LAG()`                         |
| Growth %         | arithmetic + `NULLIF()`         |
*/

SELECT @@hostname AS Host_Name,
       @@port AS MySQL_Port,
       VERSION() AS MySQL_Version;
       
SELECT CURRENT_USER();