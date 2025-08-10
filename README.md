🎬 Movie Recommendation & Analysis (SQL Project)

A practical SQL implementation of a movie recommendation system with analytical insights.
This project builds a relational database to store movies, genres, ratings, and tags, and runs SQL queries to analyze user preferences and recommend movies based on collaborative filtering.

---

📌 Features

* Movie Storage: Stores movie titles, release years, and associated genres.
* Ratings: Records user ratings with timestamps and rating constraints.
* Tags: Allows users to assign descriptive tags to movies.

Analysis Queries:

  * Top 5 movies by average rating (with minimum rating count)
  * Most active users
  * Average rating by genre
  * Ratings count per month
  * Simple recommendations for a target user using collaborative filtering
  * Data Integrity : Enforces primary keys, foreign keys, and rating constraints (0–5 range).

---

🏗️ Database Architecture

Tables:

  * `movies`: Movie details (ID, title, release year)
  * `movie_genres`: Genre mappings for each movie
  * `ratings`: User ratings with constraints and timestamps
  * `tags`: User-assigned tags with timestamps
  
Constraints:

  * Foreign keys to maintain relational integrity
  * Composite primary keys for many-to-many relationships
  * Rating validation via `CHECK` constraints

---

🛠 Tech Stack

Database: PostgreSQL (compatible with most SQL databases)

SQL Concepts Used:

* Joins
* Aggregations
* Common Table Expressions (CTEs)
* Date functions
* Filtering with `HAVING` and `ORDER BY`

---

📬 Connect

📧 Email: priyadarshinidebamita@gmail.com
🔗 LinkedIn:  https://www.linkedin.com/in/debamita-priyadarshini-1b7841296/?originalSubdomain=in

---


