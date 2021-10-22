---
editable: false
---

# ANY



#### Syntax {#syntax}


```
ANY( value )
```

#### Description {#description}
Returns one of the values of `value` from the group. This is a nondeterministic aggregation — the result may vary for the same data over multiple queries.

**Argument types:**
- `value` — `Any`


**Return type**: Same type as (`value`)

#### Examples {#examples}

```
ANY([Profit])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 19.13`, `MySQL 5.7`, `YDB`.
