{% note info %}

In the {{ ydb-short-name }} web console, you can use PRAGMA AutoCommit. This means that a `COMMIT` is automatically executed after each query. For example, if you enter multiple statements in the {{ ydb-short-name }} web console, such as

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

and run your query, a `COMMIT` is made automatically after the query.

{% endnote %}
