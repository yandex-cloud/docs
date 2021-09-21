{% cut "Пример запроса для БД {{ CH }}" %}

```sql
SELECT Category, Month, ROUND(SUM(Sales))
FROM samples.SampleLite
WHERE Category in {{category}} -- переменная, используемая в селекторе
GROUP BY Category, Month -- группировка по категории и месяцу
ORDER BY Category, Month -- сортировка по категории и месяцу
```

{% endcut %}