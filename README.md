# Project 1 – Relational vs Graph Database Performance Comparison

This repository contains the source code and queries for **CS 6010 – Data Science Programming, Project 1**.  
The project evaluates and compares the performance of **relational (MySQL)** and **graph (Neo4j)** databases on two datasets: **Northwind** and **Recommendation**.

---

## 📂 Repository Structure

Each dataset has its own folder with SQL and Neo4j queries:

### `northwind/`
- **`sql_queries.sql`** – SQL queries (10 total) implemented on the Northwind relational schema, organized into 6 categories (simple lookups, one-hop relationships, two-hop relationships, aggregation, time-based, and recommendation queries).  
- **`neo4j_queries.csv`** – Equivalent Cypher queries for Neo4j, stored in CSV format for easy loading/execution.  
- **`sql_schema_creation.sql`** – Full schema creation script for the relational version. It creates the database and defines all tables (orders, order-details, customers, products, suppliers, categories) along with their primary and foreign key constraints to enforce relational integrity.
- **`data`** - contains the final CSV data for the tables ready to be imported to the SQL schema after creation.

### `recommendation/`
- **`sql_queries.sql`** – SQL queries for the Recommendation dataset, organized into 6 categories (simple lookups, one-hop relationships, two-hop relationships, aggregation, time-based, and recommendation queries).  
- **`neo4j_queries.csv`** – Equivalent Cypher queries for graph database evaluation.  
- **`sql_schema_creation.sql`** – Full schema creation script for the relational version. It creates the database and defines all tables (actedIn, directed, genre, inGenere, movies, persons, ratings, users) along with their primary and foreign key constraints to enforce relational integrity.  
- **`graph_data_to_SQL_friendly_csv_export_queries.csv`** – Queries that export the graph data into CSV format for importing into SQL.
- **`data`** - contains the final CSV data for the tables ready to be imported to the SQL schema after creation.

---

## 🚀 How to Run

### Relational DB (MySQL)
1. Create the SQL schema by running the corresponding sql_schema_creation.sql file for each dataset.
2. Import the CSV files from the dataset’s "data" folder into the corresponding SQL tables using the MySQL Workbench user interface.  
3. Execute **`sql_queries.sql`** to reproduce results and measure execution time.  

### Graph DB (Neo4j)
1. Follow the Neo4j dataset guides, download the dumps from the dataset repositories, and load them into Neo4j Desktop:  
   - [Recommendations Dataset](https://github.com/neo4j-graph-examples/recommendations/tree/main)  
   - [Northwind Dataset](https://github.com/neo4j-graph-examples/northwind)
2. Load queries from **`neo4j_queries.csv`**.  
3. Run the queries to measure execution time and compare against relational queries.  

---
