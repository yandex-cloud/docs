---
editable: false
---

# REPLACE



#### Синтаксис {#syntax}


```
REPLACE( string, substring, replace_with )
```

#### Описание {#description}
Ищет подстроку `substring` в строке `string` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`
- `replace_with` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
REPLACE("350 RUB", "RUB", "USD") = "350 USD"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
