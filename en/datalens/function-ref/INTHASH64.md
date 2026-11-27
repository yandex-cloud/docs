---
editable: false
alternate:
  - href: en/datalens/function-ref/INTHASH64.md
    type: text/markdown
    title: Markdown version
---

# INTHASH64



#### Syntax {#syntax}


```
INTHASH64( value )
```

#### Description {#description}
Returns the 64-bit hash of the integer `value`.

**Argument types:**
- `value` — `Integer`


**Return type**: `Integer`

#### Example {#examples}

```
INTHASH64(12345) = 16722121143744093920
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `YDB`.
