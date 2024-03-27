---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COLOR.md
---

# COLOR



#### Синтаксис {#syntax}


```
COLOR( text, color )
```

#### Описание {#description}
Позволяет указать цвет для переданного текста.

**Типы аргументов:**
- `text` — `Разметка | Строка`
- `color` — `Строка`


**Возвращаемый тип**: `Разметка`

{% note info %}

Цвет можно указать в любом формате представления веб-цвета: HEX, ключевым словом (например, `green`), RGB и т. д.

{% endnote %}


#### Примеры {#examples}

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


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
