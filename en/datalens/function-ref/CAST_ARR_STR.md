---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CAST_ARR_STR.md
---

# CAST_ARR_STR



#### Syntax {#syntax}


```
CAST_ARR_STR( array )
```

#### Description {#description}
Converts `array` to an array of strings. The conversion rules are the same as for [STR](STR.md).

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: `Array of strings`

#### Example {#examples}



| **[int_array]**    | **[float_array]**   | **CAST_ARR_STR([int_array])**   | **CAST_ARR_STR([float_array])**   |
|:-------------------|:--------------------|:--------------------------------|:----------------------------------|
| `'[12,0,42]'`      | `'[12.3,0.43,42]'`  | `"['12','0','42']"`             | `"['12.3','0.43','42']"`          |
| `'[-3,NULL,0]'`    | `'[0,NULL,12]'`     | `"['-3',NULL,'0']"`             | `"['0',NULL,'12']"`               |
| `'[132,637,NULL]'` | `'[3.2,2.3,3.5]'`   | `"['132','637',NULL]"`          | `"['3.2','2.3','3.5']"`           |




#### Data source support {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
