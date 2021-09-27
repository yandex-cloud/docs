---
editable: false
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

#### Примеры {#examples}

```
URL('https://example.com/?value=' + [value], [value])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
