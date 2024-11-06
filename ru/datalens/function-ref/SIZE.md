---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SIZE.md
---

# SIZE



#### Синтаксис {#syntax}


```
SIZE( text, size )
```

#### Описание {#description}
Позволяет указать размер в пикселях для переданного текста.

**Типы аргументов:**
- `text` — `Разметка | Строка`
- `size` — `Строка`


**Возвращаемый тип**: `Разметка`

#### Пример {#examples}

```
SIZE([text], '26px')
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
