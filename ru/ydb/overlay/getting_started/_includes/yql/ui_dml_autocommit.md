{% note info %}

В веб-консоли {{ ydb-short-name }} включена PRAGMA AutoCommit. Это означает, что после каждого запроса автоматически будет выполняться `COMMIT`. Например, если вы в веб-консоли {{ ydb-short-name }} введете несколько выражений, например

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

и выполните это запрос, после этого запроса автоматически будет выполнен `COMMIT`.

{% endnote %}
