{% cut "Example of a {{ CH }} database query" %}

```sql
SELECT Category, Month, ROUND(SUM(Sales))
FROM samples.SampleLite
WHERE Category in not_var{{category}} -- Variable used in the selector
GROUP BY Category, Month -- Grouping by category and month
ORDER BY Category, Month -- Sorting by category and month
```

{% endcut %}