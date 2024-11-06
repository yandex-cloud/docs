---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SLICE.md
---

# SLICE



#### Syntax {#syntax}


```
SLICE( array, offset, length )
```

#### Description {#description}
Returns the part of array `array` of length `length` starting from index `offset`. Indexes in an array begin with one.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `offset` — `Integer`
- `length` — `Integer`


**Return type**: Same type as (`array`)

{% note info %}

Only constant values are accepted for the arguments (`offset`, `length`).

{% endnote %}


#### Examples {#examples}

```
SLICE(ARRAY(1, 2, 3, 4, 5), 3, 2) = [3, 4]
```

```
SLICE(ARRAY(1, 2, 3, 4, 5), 3, 1) = [3]
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
