---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/URL.md
---

# URL



#### Syntax {#syntax}


```
URL( address, text )
```

#### Description {#description}
Wraps `text` into a hyperlink to URL `address`. When you click on the link, the page opens in a new browser tab.

**Argument types:**
- `address` — `String`
- `text` — `Markup | String`


**Return type**: `Markup`

#### Example {#examples}

```
URL('https://example.com/?value=' + [value], [value])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
