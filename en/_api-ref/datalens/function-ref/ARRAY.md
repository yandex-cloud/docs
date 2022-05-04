---
editable: false
---

# ARRAY



#### Syntax {#syntax}


```
ARRAY( value_1, value_2, value_3 [ , ... ] )
```

#### Description {#description}
Returns an array containing the passed values.

**Argument types:**
- `value_1` — `Fractional number | Integer | String`
- `value_2` — `Fractional number | Integer | String`
- `value_3` — `Fractional number | Integer | String`


**Return type**: Depends on argument types

{% note info %}

All passed values must be of the same type or `NULL`. At least one value must be non-`NULL`.

{% endnote %}


#### Examples {#examples}

```
ARRAY(1, 2, NULL, 3)
```

```
ARRAY('a', 'b', NULL, 'c')
```

```
ARRAY(0, 2.3, NULL, 0.18)
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
