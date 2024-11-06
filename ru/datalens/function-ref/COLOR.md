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

Рекомендуем использовать для указания цветов [переменные](https://preview.gravity-ui.com/uikit/iframe.html?args=&id=colors--texts&viewMode=story) из палитры дизайн-системы [Gravity UI](https://gravity-ui.com/). Эти цвета будут хорошо различимы как в светлой, так и в темной теме.

Также цвет можно указать в любом формате представления веб-цвета: HEX, ключевым словом (например, `green`), RGB и т. д. Но в этом случае мы не гарантируем различимость цветов.

**Типы аргументов:**
- `text` — `Разметка | Строка`
- `color` — `Строка`


**Возвращаемый тип**: `Разметка`

#### Примеры {#examples}

```
COLOR([text], 'var(--g-color-text-danger)')
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


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
