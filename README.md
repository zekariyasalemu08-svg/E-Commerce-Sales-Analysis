# 📊 E-Commerce Sales Analysis (South Africa, 2024)
![Dashboard](/Images/SA%20Dashboard%202.PNG)
## 📌 Introduction
This project analyzes an e-commerce dataset from South Africa in 2024 to uncover business insights and support decision-making. The analysis focuses on profitability trends, customer behavior, product performance, discount strategies and city-level differences. By exploring these dimensions, the project highlights on what drives profit, which products bring the most value and examines what caused decline in profit.


### 🛠️ Tools & Technologies
- Excel → Handling missing values,Fixing inconsistance values, derived columns, outlier detection
- SQL (MySQL) → Data extraction, transformation, and in-depth analysis
- Power BI → Interactive dashboards & KPIs

**The GOAL** of the project was to provide insights that contribute to improve profitability and also to investigate the decline in profit during the last quarter of 2024.

## 📌 Skills Showcased
- **📂 Data Cleaning & Preparation:** Handling missing values & duplicates, Standardizing data types, Outlier detection, Derived columns creation, Data normalization & formatting
- **🗄️ SQL (MySQL) Analysis:** Joins (INNER, LEFT, SELF), Aggregations (GROUP BY, HAVING), Window functions (rank, running totals), Conditional logic (CASE WHEN), Subqueries & CTEs, KPI calculations (Revenue, Profit, AOV)
- **⚙️ General technical/process skills:** Problem solving, descriptive analysis, diagnostic analysis
- **📝 Power query:** Further cleaned and Standardized the data.
- **📈 Data Visualization & Reporting (Power BI):** Interactive dashboards, Line, stacked column & scatter plots, KPI cards, DAX calculations & measures, slicers & filters
- **💡 Business Insight Generation:** Profitability trends, Premium vs. non-premium performance, City-level profitability, Discount impact analysis, Product & brand segmentation
## 📌 Project Overview
### 📂 Data Cleaning Steps
![Excel](/Images/SA%20Excel.PNG)
Using Excel I Removed duplicates & standardized column names. Handled missing values (ie. instead of empty space make Unknown Customer) and also filled up products based on product detail. Fixed inconsistent values (like mobile and mobile phone). Converted data types (dates, decimals for sales & profit). Added **"is_premium"** column to classify premium products. 


### 🔎 SQL Analysis Performed
![alt text](Images/SA%20SQL.PNG)
- **Data Preparation:** Ensured correct data types for date, numeric, and categorical fields. Created calculated field such as profit_margin to enable advanced analysis.
- **Descriptive Analysis:** Aggregated sales, profit, and quantity across time periods. Summarized performance by product categories, brands, and cities. Calculated customer-level statistics such as total spend and average order value (AOV).
- **Comparative Analysis:** Compared profitability across product categories and brands. Evaluated city-level performance by total sales, profit, and margins. Analyzed discount brackets to assess their impact on profitability. Assessed the impact of different discount levels on sales and profit margins.
- **Diagnostic analysis:** investigated the decline in profit observed later in the year. Examined changes in premium product sales and city-level performance to identify contributing factors.
- **Advanced SQL Techniques:** Used window functions for ranking products, running totals, and cumulative contributions. also applied CASE statements. 
- **Trend & Time Series Analysis:** Monthly breakdowns of revenue, profit, and transactions. Identification of seasonal or temporal shifts in sales and profitability.
- **Customer & Contribution Analysis:** Segmented transactions into premium vs. non-premium to evaluate their relative contributions. Conducted Pareto-style analysis (e.g., % of customers contributing to % of profit).
### 📝 Power BI – Power query Editing
Made further clean up and standardization of the dataset. Further Fixed inconsistent values & capitalization (product names, brands, cities). And made the data ready for visualization.


### 📈 Dashboard Highlights (Power BI)
The Power BI dashboard highlights key KPIs including total quantity sold, total sales, and total profit, alongside their yearly trends. It emphasizes the impact of premium products by showing their share of transactions versus profit contribution and visualizes how discounts affect both sales and profitability. Product-level performance is highlighted through visuals that break down profit contributions across categories, while city slicers allow users to filter and analyze performance geographically, giving a clear and interactive view of business performance.
## 🔑 Key Insights
- Premium Products hold 73% of profit from only 28% of transactions
- Amount of premium products sold is directly proportional to profit (when amount of premium products sold decrease, the profit also decreases).
- There is noticeable decline of profit in Q4 and it is clearly due to weaker premium sales.
- Johannesburg & Cape Town cities drive most of the sales and profit
- Making discounts beyond 25% harm profitability significantly.
- Tablets consistently underperform, draining profit

