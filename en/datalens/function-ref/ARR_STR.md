---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_STR.md
---

# ARR_STR



#### Syntax {#syntax}


```
ARR_STR( array [ , delimiter [ , null_str ] ] )
```

#### Description {#description}
Concatenates elements of the array `array` using `delimiter` as a delimiter (comma by default) and `null_str` as a `NULL` string (`NULL` items are skipped by default).

See also [STR](STR.md)

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `delimiter` — `String`
- `null_str` — `String`


**Return type**: `String`

{% note info %}

Only constant values are accepted for the arguments (`delimiter`, `null_str`).

{% endnote %}


#### Examples {#examples}

```
ARR_STR(ARRAY(1, 2, NULL, 4)) = 1,2,4
```

```
ARR_STR(ARRAY(1, 2, NULL, 4), ';') = 1;2;4
```

```
ARR_STR(ARRAY(1, 2, NULL, 4), ';', '*') = 1;2;*;4
```

```
ARR_STR(ARRAY('a', 'b', '', NULL), ';', '*') = a;b;;*
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
