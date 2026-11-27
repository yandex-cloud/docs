---
editable: false
alternate:
  - href: en/datalens/function-ref/CITYHASH64.md
    type: text/markdown
    title: Markdown version
---

# CITYHASH64



#### Syntax {#syntax}


```
CITYHASH64( value )
```

#### Description {#description}
Returns the CityHash64 hash of `value` as an integer.

**Argument types:**
- `value` — `String`


**Return type**: `Integer`

#### Example {#examples}

```
CITYHASH64("DataLens") = 1276466053635395874
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
