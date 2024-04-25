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

We recommend using the [color variables](https://preview.gravity-ui.com/uikit/iframe.html?args=&id=colors--texts&viewMode=story) from the [Gravity UI](https://gravity-ui.com/) palette to specify colors. Such colors are easily discernible with both the light and dark theme.

You can also specify the color in any web format, such as HEX, keyword (e.g., `green`), RGB, etc. In this case, however, we cannot guarantee that the colors will be discernible.

**Argument types:**
- `text` — `Markup | String`
- `color` — `String`


**Return type**: `Markup`

#### Examples {#examples}

```
COLOR([text], '--g-color-text-danger')
```

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
