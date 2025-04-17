---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/TOOLTIP.md
---

# TOOLTIP



#### Syntax {#syntax}


```
TOOLTIP( text, tooltip [ , placement ] )
```

#### Description {#description}
Adds a small tooltip to a text or other markup function results. The `placement` argument manages the text positioning: `top`, `right`, `bottom`, `left` or `auto`. The default value is `auto`.

**Argument types:**
- `text` — `Markup | String`
- `tooltip` — `Markup | String`
- `placement` — `String`


**Return type**: `Markup`

#### Examples {#examples}

```
TOOLTIP(SIZE('Hello', '12px'), URL('https://ya.ru', 'Yandex'), 'top')
```

```
TOOLTIP([main_text], [tooltip_text])
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
