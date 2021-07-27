---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# IFNULL



#### Syntax {#syntax}


```
IFNULL( check_value, alt_value )
```

#### Description {#description}
Returns `check_value` if it's not `NULL`. Otherwise returns `alt_value`.

**Argument types:**
- `check_value` — `Any`
- `alt_value` — `Any`


**Return type**: Same type as (`check_value`, `alt_value`)

{% note info %}

Arguments (`check_value`, `alt_value`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
IFNULL([Profit], 0)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
