---
editable: false
---

# ANY

_Aggregate functions_

#### Syntax {#syntax}


```
ANY( value )
```

#### Description {#description}
Returns any value of `value` from the group. The result is not guaranteed to be the same over multiple queries.

**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
ANY([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `MySQL 5.7`.
