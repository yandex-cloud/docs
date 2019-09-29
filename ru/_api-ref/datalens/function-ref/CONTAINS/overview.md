# CONTAINS

_Строковые функции_

#### Синтаксис


```
CONTAINS( string, substring )
```

#### Описание
Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`. Для регистронезависимой проверки см. [ICONTAINS](../ICONTAINS/overview.md)

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
CONTAINS("RU0891923", "RU") = TRUE
```

```
CONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
