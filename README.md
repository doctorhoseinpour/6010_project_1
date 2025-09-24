Project 1 – Relational vs Graph Database Performance Comparison

This repository contains the source code and queries for CS 6010 – Data Science Programming, Project 1.
The project evaluates and compares the performance of relational (MySQL) and graph (Neo4j) databases on two datasets: Northwind and Recommendation.

Repository Structure

Each dataset has its own folder with SQL and Neo4j queries:

northwind/

sql_queries.sql – SQL queries (10 total) implemented on the Northwind relational schema.

neo4j_queries.csv – Equivalent Cypher queries for Neo4j, stored in CSV format for easy loading/execution.

sql_relational_conditions.sql – Schema constraints for the relational version. This script adds primary keys and foreign keys after importing the raw CSV data into SQL tables, ensuring relational integrity between tables (e.g., orders, customers, products, suppliers, categories).

recommendation/

sql_queries.sql – SQL queries for the Recommendation dataset, organized into 6 categories (simple lookups, one-hop relationships, two-hop relationships, aggregation, time-based, and recommendation queries).

neo4j_queries.csv – Equivalent Cypher queries for graph database evaluation.

sql_relational_conditions.sql – Schema constraints that establish relationships (primary keys, foreign keys, and cascading behavior) between entities such as persons, movies, users, ratings, and linking tables like actedIn and inGenere.

