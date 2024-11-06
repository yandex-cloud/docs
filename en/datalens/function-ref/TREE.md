---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/TREE.md
---

# TREE



#### Syntax {#syntax}


```
TREE( array )
```

#### Description {#description}
Converts the `array` expression to `Tree of strings` format. Can be used to create [tree hierarchies](../dataset/data-types.md#tree-hierarchy).

**Argument types:**
- `array` — `Array of strings`


**Return type**: `Any`

#### Example {#examples}

```
TREE(ARRAY([Country], [Region], [City]))
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `PostgreSQL 9.3`, `Yandex Documents`.
