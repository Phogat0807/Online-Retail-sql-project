Online Retail Management System (SQL Project)

📌 Overview

This project is a relational database system designed for an Online Retail Platform using MySQL. It simulates real-world e-commerce operations including user management, product catalog, cart functionality, order processing, and payments.


🚀 Features

* User roles (Admin & Customer)
* Product & Category management
* Shopping cart system
* Order processing & lifecycle tracking
* Payment management (UPI, Card, COD)
* Inventory management
* Sales analytics using SQL Views


🧱 Database Design

The system consists of the following tables:

* users – Stores customer/admin details
* categories – Product categories
* products – Product catalog
* cart – User cart
* cart_items – Items inside cart
* orders – Order details
* order_items – Products in each order
* payments – Payment transactions


🔗 Relationships

* One user → One cart
* One user → Many orders
* One order → Many order items
* One product → Many order items
* Categories linked to products


🛠️ Technologies Used

* MySQL
* SQL (DDL, DML)
* Joins, Subqueries, Aggregations
* Views
  
Learning Outcomes

* Designed normalized relational database schema
* Implemented real-world SQL operations
* Improved query performance using joins and views
* Gained hands-on experience in database design


📌 Future Improvements

* Add stored procedures & triggers
* Integrate with backend (Node.js / Java)
* Build frontend UI for complete application
