---
editable: false
---

# AND



#### Syntax {#syntax}


```
value_1 AND value_2
```

#### Description {#description}
Performs a Boolean join of two expressions with the `AND` condition.

**Argument types:**
- `value_1` — `Boolean`
- `value_2` — `Boolean`


**Return type**: Same type as (`value_1`, `value_2`)

{% note info %}

Arguments (`value_1`, `value_2`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
[Profit] > 30 AND [Weekday] IN ("Saturday", "Sunday")
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
