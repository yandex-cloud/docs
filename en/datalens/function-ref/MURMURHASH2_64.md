---
editable: false
alternate:
  - href: en/datalens/function-ref/MURMURHASH2_64.md
    type: text/markdown
    title: Markdown version
---

# MURMURHASH2_64



#### Syntax {#syntax}


```
MURMURHASH2_64( value )
```

#### Description {#description}
Returns the MurmurHash2 64-bit hash of `value` as an integer.

**Argument types:**
- `value` — `String`


**Return type**: `Integer`

#### Example {#examples}

```
MURMURHASH2_64("DataLens") = 12204402796868507663
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
