{% cut "Пример запроса для {{ prometheus-name }}" %}

```sql
sum by (name) (rate(container_cpu_user_seconds_total{container_label_org_label_schema_group="monitoring"}[1m]) * 100  / scalar(count(node_cpu_seconds_total{mode="user"})))
```

{% endcut %}