---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/GET_ITEM.md
---

# GET_ITEM



#### Syntax {#syntax}


```
GET_ITEM( array, index )
```

#### Description {#description}
Returns the element with the index `index` from the array `array`. Index must be any integer. Indexes in an array begin with one. Returns the last item from the array if `index` is `-1`.

**Argument types:**
- `array` — `Array of fractional numbers | Array of integers | Array of strings`
- `index` — `Integer`


**Return type**: Depends on argument types

#### Example {#examples}

```
GET_ITEM([array_field], 2)
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
