---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# URL



#### Syntax {#syntax}


```
URL( address, text )
```

#### Description {#description}
Wraps `text` into a hyperlink to URL `address`.

**Argument types:**
- `address` — `String`
- `text` — `Markup | String`


**Return type**: `Markup`

#### Examples {#examples}

```
URL('https://example.com/?value=' + [value], [value])
```


#### Data source support {#data-source-support}

`Materialized Dataset`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
