---
editable: false
---

# ARR_REMOVE



#### Syntax {#syntax}


```
ARR_REMOVE( array, value )
```

#### Description {#description}
Removes all `array` elements equal to `value`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `value` — `Fractional number | Integer | String`


**Return type**: Same type as (`array`)

#### Example {#examples}



| **[array]**               | **ARR_REMOVE([array], NULL)**   |
|:--------------------------|:--------------------------------|
| `'[100,300,200,100,300]'` | `'[100,300,200,100,300]'`       |
| `'[100,300,NULL,NULL]'`   | `'[100,300]'`                   |
| `'[150,NULL,130,192]'`    | `'[150,130,192]'`               |




#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
