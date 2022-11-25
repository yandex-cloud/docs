---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/URL.md
---

# URL



#### Синтаксис {#syntax}


```
URL( address, text )
```

#### Описание {#description}
Оборачивает `text` в ссылку на URL `address`.

**Типы аргументов:**
- `address` — `Строка`
- `text` — `Разметка | Строка`


**Возвращаемый тип**: `Разметка`

#### Пример {#examples}

```
URL('https://example.com/?value=' + [value], [value])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
