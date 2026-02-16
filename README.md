# E-commerce Sales Analytics Project

![Dashboard Preview](screenshots/Dashboard.png)

## Project Overview
This project presents a comprehensive analysis of an e-commerce store's sales data. The goal was to extract key business insights, segment customers, analyze product performance, and create a dashboard for decision-making.

**Business questions answered:**
- What are the key business metrics (revenue, AOV, orders)?
- Who are our most valuable customers?
- Which products and categories drive the most revenue?
- How do different regions perform?
- What is customer retention rate?

## Tools & Skills
- **SQL (PostgreSQL):** Complex queries, CTEs, window functions, cohort analysis
- **Excel:** Pivot tables, data visualization, conditional formatting, dashboard design
- **Analytics:** RFM segmentation, cohort analysis, AOV analysis, retention rate calculation

## 📁 Project Structure

├── 📁 sql_queries/          # All SQL analysis scripts (10 files)

├── 📁 excel/                 # Excel dashboard file

├── 📁 screenshots/           # Dashboard preview image

└── README.md                 # Project documentation

*Note: Click on the folders above to browse the files.*

## Key Insights

### 1. Customer Segments
| Customer Type | Customers | Revenue | % of Total | AOV |
|--------------|-----------|---------|------------|-----|
| Business | 10 | 75,141 ₽ | 34.68% | 467 ₽ |
| Private | 20 | 141,551 ₽ | 65.32% | 418 ₽ |

**Insight:** Business customers have **5.8% higher AOV** than private customers, despite being half in number.

---

### 2. Top Product Categories
| Category | Revenue | % of Total |
|----------|---------|------------|
| Furniture | 39,262 ₽ | 18.12% |
| Electronics | 36,846 ₽ | 17.00% |
| Office Supplies | 32,068 ₽ | 14.80% |
| Home Appliances | 30,190 ₽ | 13.93% |
| Books | 28,905 ₽ | 13.34% |
| Clothing | 20,809 ₽ | 9.60% |
| Cosmetics | 15,600 ₽ | 7.20% |
| Sports Equipment | 13,013 ₽ | 6.01% |

**Insight:** Furniture and Electronics together account for **35% of total revenue**, making them the core product categories.

---

### 3. Regional Performance
| City | Revenue | Avg Check |
|------|---------|-----------|
| Novosibirsk | 27,292 ₽ | 455 ₽ |
| Voronezh | 25,988 ₽ | 464 ₽ |
| Rostov-on-Don | 25,805 ₽ | 453 ₽ |
| Kazan | 25,289 ₽ | 562 ₽ |
| Krasnodar | 23,278 ₽ | 408 ₽ |
| Yekaterinburg | 21,364 ₽ | 455 ₽ |
| Saint Petersburg | 19,244 ₽ | 437 ₽ |
| Samara | 17,663 ₽ | 340 ₽ |
| Moscow | 15,479 ₽ | 418 ₽ |
| Ufa | 15,291 ₽ | 340 ₽ |

**Insight:** Kazan has the **highest average check (562 ₽)** , while Ufa shows lower revenue compared to other cities.

---

### 4. Retention Analysis
This data is synthetic, which is why all customers show 100% retention. In a real project with actual customer data, this metric would look different and reveal real churn patterns.

## Business Recommendations

### 1. Focus on B2B Growth
Business customers spend 5.8% more per order and represent 34.7% of revenue with only 10 clients.
**Action:** Launch a loyalty program for corporate clients (volume discounts, dedicated account manager) to increase purchase frequency and retention.

### 2. Regional Strategy
- **Key regions** (Novosibirsk, Voronezh, Rostov-on-Don) generate significant revenue.
  **Action:** Increase marketing presence and optimize logistics in these regions.
- **Kazan** shows premium potential with the highest average check (562 ₽).
  **Action:** Test premium product lines and targeted promotions in Kazan.

### 3. Product Assortment
Furniture and Electronics categories lead in revenue.
**Action:** Expand assortment in these categories and introduce complementary products to increase cross-selling opportunities.

### 4. Customer Retention
**Action:** Implement regular retention monitoring with real data to detect churn early and launch reactivation campaigns.

### 5. Pricing Strategy
Private customers have lower AOV than business clients.
**Action:** Introduce "free shipping over 1000 ₽" or bundle offers to increase average order value in the private segment.

## SQL Examples

### Example: Customer AOV Analysis with Window Function
```sql
-- Calculating Average Order Value by customer type
-- and comparing with overall average using window function

WITH customer_aov AS (
    SELECT 
        c.customer_id,
        c.customer_type,
        AVG(s.quantity * s.unit_price) as aov
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.customer_type
)
SELECT 
    customer_type,
    COUNT(*) as customers_count,
    ROUND(AVG(aov), 2) as avg_aov,
    ROUND(AVG(aov) - AVG(AVG(aov)) OVER(), 2) as diff_from_overall_avg,
    ROUND((AVG(aov) - AVG(AVG(aov)) OVER()) / AVG(AVG(aov)) OVER() * 100, 2) as diff_percentage
FROM customer_aov
GROUP BY customer_type
ORDER BY avg_aov DESC

