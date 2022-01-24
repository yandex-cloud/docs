{% cut "Query example for a {{ CH }} database" %}

```sql
SELECT Category, Month, ROUND(SUM(Sales))
FROM samples.SampleLite
WHERE Category in not_var{{category}} -- a variable used in the selector
GROUP BY Category, Month -- grouping by category and month
ORDER BY Category, Month -- sorting by category and month
```

{% endcut %}