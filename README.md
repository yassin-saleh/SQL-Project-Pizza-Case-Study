# 🍕 SQL Pizza Sales Analysis Project

## 📘 Project Overview

This SQL project is centered around a **relational database** designed for managing and analyzing data of a pizza store. The schema comprises four main tables:

- `order_details`
- `pizzas`
- `orders`
- `pizza_types`

Each table plays a critical role in representing the business workflow — from handling orders to tracking pizza ingredients and pricing.

---

## 🧱 Database Schema

### 1. 🧾 `order_details`
| Column Name       | Description                                                   |
|------------------|---------------------------------------------------------------|
| `order_details_id` | Unique ID for each order detail entry                         |
| `order_id`         | Foreign key linking to the `orders` table                     |
| `pizza_id`         | Foreign key linking to the `pizzas` table                     |
| `quantity`         | Number of pizzas ordered                                      |

---

### 2. 🍕 `pizzas`
| Column Name     | Description                                      |
|----------------|--------------------------------------------------|
| `pizza_id`       | Unique identifier for each pizza                |
| `pizza_type_id`  | Links to the `pizza_types` table                |
| `size`           | Size of the pizza (e.g., Small, Medium, Large) |
| `price`          | Price of the pizza                             |

---

### 3. 📦 `orders`
| Column Name | Description                  |
|-------------|------------------------------|
| `order_id`    | Unique identifier for orders |
| `date`        | Date the order was placed   |
| `time`        | Time the order was placed   |

---

### 4. 🧀 `pizza_types`
| Column Name   | Description                                  |
|---------------|----------------------------------------------|
| `pizza_type_id` | Unique ID for pizza type                    |
| `name`          | Name of the pizza (e.g., Margherita)        |
| `category`      | Category (e.g., Vegetarian, Non-Vegetarian) |
| `ingredients`   | List of ingredients                         |

---

## 📊 Why This Project Matters

This database isn't just about storing data — it’s a **powerful tool for data-driven decision-making** in a pizza business. Here’s how a store manager can leverage it:

### 🔍 Sales Analysis
- Identify best-selling pizzas and top-performing categories.
- Track revenue by pizza size or type.
- Refine pricing strategies based on demand trends.

### 🧾 Inventory Management
- Understand ingredient usage across different pizza types.
- Forecast ingredient needs to prevent shortages or waste.

### 💡 Customer Insights
- Track most ordered pizza types over time.
- Discover changing customer preferences to adapt the menu.

### ⏰ Operational Efficiency
- Use time/date data to identify peak hours and optimize staffing.
- Reduce wait times and improve customer service.

### 🎯 Marketing Optimization
- Plan discounts or promotions for slow-moving items.
- Focus campaigns around top-selling or seasonal pizzas.

---

## ✅ Conclusion

This SQL project is more than a data warehouse — it’s a **business intelligence engine**. By organizing and querying this data effectively, store managers can:

- Increase profitability 💰
- Reduce waste 🍅
- Improve service quality 🙌
- Make data-informed decisions 📈

For aspiring data analysts or business owners, this project demonstrates the **real-world power of SQL** and how structured data can transform operations.

---

