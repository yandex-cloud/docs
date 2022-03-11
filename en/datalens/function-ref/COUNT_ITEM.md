---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COUNT_ITEM.md
---


# COUNT_ITEM



#### Syntax {#syntax}


```
COUNT_ITEM( array, value )
```

#### Description {#description}
Returns the number of elements in the array `array` equal to `value`. Type of `value` must match type of `array` elements.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `value` — `Fractional number | Integer | String`


**Return type**: `Integer`

#### Examples {#examples}

```
COUNT_ITEM(ARRAY(1, 2, 2, 3), 2) = 2
```

```
COUNT_ITEM(ARRAY(1, 2, 2, 3), 4) = 0
```

```
COUNT_ITEM(ARRAY(1, NULL, 2, NULL), NULL) = 2
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
