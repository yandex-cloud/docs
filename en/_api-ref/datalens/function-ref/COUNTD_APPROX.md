---
editable: false
---

# COUNTD_APPROX



#### Syntax {#syntax}


```
COUNTD_APPROX( value )
```

#### Description {#description}
Returns the approximate number of unique values in the group. Faster than [COUNTD](COUNTD.md), but doesn't guarantee accuracy.

**Argument types:**
- `value` — `Any`


**Return type**: `Number (whole)`

#### Examples {#examples}

```
COUNTD_APPROX([ClienID])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Oracle Database 12c (12.1)`.
