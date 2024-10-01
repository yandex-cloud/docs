```sql
SELECT dbname, fq_name, rank, status, expansion_started, expansion_finished
FROM gpexpand.status_detail
ORDER BY rank;
```
