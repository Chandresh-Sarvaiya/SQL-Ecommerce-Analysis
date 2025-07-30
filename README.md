# 🛒 E-commerce Sales & Customer Behavior Analysis using SQL

This project provides a comprehensive data analysis of the **Olist Brazilian E-commerce dataset** using **PostgreSQL**. The dataset spans from 2016 to 2018 and includes nearly 100,000 orders. The goal is to explore customer behavior, product performance, geographic trends, and business growth through advanced SQL queries.

---

## 📁 Project Structure

- `database Schema.sql` – Schema creation and data import from CSV files.
- `EDA.sql` – Exploratory Data Analysis queries.
- `RFM Analysis.sql` – Recency, Frequency, and Monetary segmentation queries.
- `Growth and Top Selling Product of Company.sql` – Monthly growth and product performance queries.
- `Top states and Payment Methods.sql` – Geographic and payment behavior analysis.
- `ERD.png` -Relational Diagram of Database

---

## 🧰 Tools & Technologies

- **Database**: PostgreSQL  
- **SQL Client**: *PgAdmin*  
- **Dataset**: [Olist Brazilian E-commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)  
- **Language**: SQL  

---

## 📊 Analysis Overview

This analysis answers several key business questions:

- **📦 Exploratory Data Analysis (EDA)**: Order status distribution, yearly/monthly order trends.
- **🔥 Product Performance**: Best-selling and highest revenue product categories.
- **👥 Customer Segmentation**: RFM analysis using window functions for identifying valuable vs. at-risk customers.
- **📈 Sales Growth**: Month-over-month (MoM) revenue trends using `LAG()` function.
- **🗺️ Geographic Insights**: Top customer states by order volume.
- **💳 Payment Behavior**: Popular payment types, revenue contribution, and average installments.

---

## 🔑 Key Findings

- **Champions Identified**: Customers with the highest RFM scores (555) represent loyal, high-value clients.
- **Growth Trends**: Seasonal peaks identified using MoM revenue growth metrics.
- **Top Products**: Clear identification of the 10 most profitable product categories.
- **Core Markets**: São Paulo(SP) and other key states are top-performing regions.
- **Preferred Payment Methods**: Credit card payments dominate, with detailed insights into average installment behavior.

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/Chandresh-Sarvaiya/SQL-Ecommerce-Analysis.git
cd SQL-Ecommerce-Analysis
