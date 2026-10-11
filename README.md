# Olist E-commerce Order & Customer Analysis (SQL)

## Overview
This project uses MySQL to analyze order and customer data from the Olist Brazilian e-commerce dataset. It looks at order trends over time, where customers are located, how long deliveries take, and how often customers come back.

## Business Questions Answered
- What share of orders are delivered, canceled, or in other statuses?
- How does order volume change month to month?
- Which Brazilian states and cities generate the most orders?
- How long does delivery take on average?
- Which weekdays and hours see the most purchases?
- How many customers order more than once, and who are the top repeat buyers?

## Key Finding
Of **93,342 customers** analyzed, **2,800 (3.00%)** placed more than one order. The low repeat rate suggests most customers buy only once, which points to customer retention as a major growth opportunity for the marketplace.

## Analysis Performed
- Order status distribution
- Monthly order trends
- Orders by Brazilian state
- Top 10 customer cities
- Average delivery time
- Orders by weekday
- Monthly order status analysis
- Orders by purchase hour
- Top repeat customers
- Customer order frequency
- Repeat customer percentage

## Tools Used
- MySQL 8.0
- MySQL Workbench
- SQL

## SQL Skills Demonstrated
- Joins across multiple tables
- Aggregate functions with `GROUP BY` and filtering
- Date and time functions
- Subqueries
- Customer behavior analysis

## Scope
This analysis covers orders, customers, and delivery data. Revenue and product analysis are outside its scope because the `order_items` table was not loaded. Results reflect the data currently in the database.

## Repository Structure
```
├── olist_ecommerce_analysis.sql   # All analysis queries
└── README.md
```
