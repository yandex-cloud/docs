---
editable: false
alternate:
  - href: en/datalens/function-ref/SIPHASH64.md
    type: text/markdown
    title: Markdown version
---

# SIPHASH64



#### Syntax {#syntax}


```
SIPHASH64( value )
```

#### Description {#description}
Returns the SipHash64 hash of `value` as an integer.

**Argument types:**
- `value` — `String`


**Return type**: `Integer`

#### Example {#examples}

```
SIPHASH64("DataLens") = 6283456972272785891
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
