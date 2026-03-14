# Revenue Leakage Prediction & Analysis System

## Project Overview

Revenue leakage is a major issue for businesses where revenue is lost due to pricing errors, unauthorized discounts, or incorrect invoicing.

This project simulates a **Revenue Leakage Monitoring System** that helps organizations identify potential revenue losses by analyzing sales transactions, discount policies, and pricing rules.

The solution combines **Python, SQL, Excel, and Power BI** to perform data generation, analysis, and visualization.

---

## Business Problem

Companies often lose revenue because of:

* Unauthorized discounts
* Incorrect invoice pricing
* Sales representatives bypassing discount policies
* Manual pricing errors

This project analyzes sales transactions to **detect potential revenue leakage patterns and risky sales behavior**.

---

## Tools & Technologies

* Python – Synthetic dataset generation
* SQL – Data querying and leakage analysis
* Excel – Data cleaning and validation
* Power BI – Data modeling and dashboard visualization

---

## Dataset Description

The project uses **five datasets** representing a simulated sales system.

| Dataset                 | Description                          |
| ----------------------- | ------------------------------------ |
| Discount Policy         | Defines the allowed discount limits  |
| Invoice Price           | Final invoice price for orders       |
| Sales Order             | Customer order details               |
| Sales Person            | Sales employee information           |
| Sales Analysis Overview | Aggregated sales performance metrics |

---

## Data Pipeline

Python → Generate synthetic datasets
SQL → Load and analyze transactional data
Excel → Data cleaning and validation
Power BI → Data modeling and dashboard visualization

---

## Data Modeling

Five tables were connected using relational data modeling inside Power BI to enable cross-table analysis between:

* Sales Orders
* Discount Policy
* Invoice Price
* Sales Person
* Sales Analysis Overview

---

## SQL Analysis

Key SQL concepts used:

* Joins
* Aggregations
* CASE statements
* Revenue variance calculations
* Discount rule validation
* Sales performance metrics
* Revenue leakage detection queries

10 analytical SQL queries were created to detect abnormal pricing and discount behavior.

---

## Power BI Dashboard

The Power BI dashboard contains **three analytical pages**:

### 1. Executive Leakage Overview

High-level KPIs showing revenue performance and potential leakage indicators.

### 2. Salesperson Risk Analysis

Identifies sales representatives who frequently exceed discount limits or generate risky transactions.

### 3. Order-Level Leakage Investigation

Detailed view of individual transactions where pricing or discount policies may have been violated.

---

## Key Insights

* Identification of high-risk salespersons
* Detection of discount policy violations
* Revenue variance between expected vs actual invoice prices
* Transaction-level leakage investigation

---

## Project Outcomes

This project demonstrates how data analytics can help businesses:

* Monitor revenue integrity
* Detect pricing anomalies
* Identify risky sales behavior
* Improve financial controls

---

## Power BI Dashboard

Power BI interactive dashboard:

[Add your Power BI link here]

---

## Author

Karthikeyan
Aspiring Data Analyst
