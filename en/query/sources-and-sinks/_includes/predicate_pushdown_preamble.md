{{ yq-full-name }} can push parts of query processing down to the source data system by sending filter expressions, e.g., `WHERE` conditions, directly to the database. This approach is known as `filter pushdown`.

Filter pushdown is possible when using: