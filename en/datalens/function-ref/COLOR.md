---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COLOR.md
---

# COLOR



#### Syntax {#syntax}


```
COLOR( text, color )
```

#### Description {#description}
Enables specifying the color for the provided text.

**Argument types:**
- `text` — `Markup | String`
- `color` — `String`


**Return type**: `Markup`

{% note info %}

You can specify the color in any web format, such as HEX, keyword (e.g., `green`), RGB, etc.

{% endnote %}


#### Examples {#examples}

```
COLOR([text], '#5282ff')
```

```
COLOR([text], 'blue')
```

```
COLOR([text], 'rgb(82, 130, 255)')
```

```
COLOR([text], 'rgba(82, 130, 255, 0.5)')
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
