---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/ARR_DISTINCT.md
---

# ARR_DISTINCT



#### Syntax {#syntax}


```
ARR_DISTINCT( array )
```

#### Description {#description}
Removes duplicate elements from an array `array`, returning a new array with only unique elements. The order of elements in the returned array is not guaranteed to be the same as the input array.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`


**Return type**: Same type as (`array`)

#### Examples {#examples}

```
ARR_DISTINCT(ARRAY(1, 2, 2, 3, 3, 3, 4)) = [1, 2, 3, 4]
```

```
ARR_DISTINCT(ARRAY(1.1, 2.2, 2.2, 3.3, 3.3, 3.3, 4.4)) = [1.1, 2.2, 3.3, 4.4]
```

```
ARR_DISTINCT(ARRAY('apple', 'banana', 'apple', 'orange', 'banana')) = ['apple', 'banana', 'orange']
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Trino`, `Yandex Documents`.
