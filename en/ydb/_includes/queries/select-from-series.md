```sql
SELECT season_id, episode_id, title
FROM episodes
WHERE series_id = 1 AND season_id > 1
ORDER BY season_id, episode_id LIMIT 3
```