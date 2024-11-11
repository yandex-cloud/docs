---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SIZE.md
---

# SIZE



#### Syntax {#syntax}


```
SIZE( text, size )
```

#### Description {#description}
Enables specifying the size (in pixels) for the provided text.

**Argument types:**
- `text` — `Markup | String`
- `size` — `String`


**Return type**: `Markup`

#### Example {#examples}

```
SIZE([text], '26px')
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
