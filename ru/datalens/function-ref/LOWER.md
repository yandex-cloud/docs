---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LOWER.md
---

# LOWER



#### Синтаксис {#syntax}


```
LOWER( string )
```

#### Описание {#description}
Возвращает строку `string` в нижнем регистре.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
LOWER("Lorem ipsum") = "lorem ipsum"
```

```
LOWER("Карл у Клары") = "карл у клары"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
