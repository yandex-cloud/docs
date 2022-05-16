---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-cli/commands/_includes/explain-plan/intro.md
---
# Getting a query plan

Get a query plan:

```bash
{{ ydb-cli }} table query explain \
  -q "SELECT season_id, episode_id, title
  FROM episodes
  WHERE series_id = 1
  AND season_id > 1
  ORDER BY season_id, episode_id
  LIMIT 3"
```

