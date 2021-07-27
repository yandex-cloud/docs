---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# OR



#### Syntax {#syntax}


```
value_1 OR value_2
```

#### Description {#description}
Performs a Boolean join of two expressions with the `OR` condition.

**Argument types:**
- `value_1` — `Boolean`
- `value_2` — `Boolean`


**Return type**: Same type as (`value_1`, `value_2`)

{% note info %}

Arguments (`value_1`, `value_2`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
[Month] = "January" OR [Year] < 2019
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
