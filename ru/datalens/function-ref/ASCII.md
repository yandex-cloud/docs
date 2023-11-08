---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ASCII.md
---

# ASCII



#### Синтаксис {#syntax}


```
ASCII( string )
```

#### Описание {#description}
Возвращает числовое представление первого символа строки.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
ASCII("N") = 78
```

```
ASCII("¹") = 185
```

```
ASCII("¹") = 194
```

```
ASCII("…") = 8230
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
