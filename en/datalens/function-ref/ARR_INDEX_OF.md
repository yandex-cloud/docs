---
editable: false
---

# ARR_INDEX_OF



#### Syntax {#syntax}


```
ARR_INDEX_OF( array, value )
```

#### Description {#description}
Returns the position (index) of the first occurrence of the value `value` in the array `array`. The indexing starts from 1. If the value `value` is not found in the array, the function returns 0.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `value` — `Fractional number | Integer | String`


**Return type**: `Integer`

#### Examples {#examples}

```
ARR_INDEX_OF(ARRAY('a', 'b', 'c', 'b'), 'b') = 2
```

```
ARR_INDEX_OF(ARRAY(1.1, 2.2, 3.3, 3.3), 3) = 3
```

```
ARR_INDEX_OF(ARRAY(1, 2, 3, 2), 2) = 2
```

```
ARR_INDEX_OF(ARRAY('a', 'b', 'c', 'b'), 'd') = 0
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Trino`, `Yandex Documents`.
