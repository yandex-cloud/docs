---
editable: false
---

# REPLACE

_Строковые функции_

#### Синтаксис


```
REPLACE( string, substring, replace_with )
```

#### Описание
Ищет подстроку `substring` в строке `string` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`
- `replace_with` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры

```
REPLACE("350 RUB", "RUB", "USD") = "350 USD"
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
