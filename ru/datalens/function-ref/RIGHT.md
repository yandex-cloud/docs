---
editable: false
---

# RIGHT



#### Синтаксис {#syntax}


```
RIGHT( string, number )
```

#### Описание {#description}
Возвращает строку, которая содержит указанное количество символов `number` с конца строки `string`.

**Типы аргументов:**
- `string` — `Строка`
- `number` — `Целое число`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
RIGHT("Computer", 3) = "ter"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
