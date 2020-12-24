---
editable: false
---

# ICONTAINS



#### Синтаксис {#syntax}


```
ICONTAINS( string, substring )
```

#### Описание {#description}
Регистронезависимый вариант [CONTAINS](CONTAINS.md). Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`.

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Геоточка | Геополигон | Число | Строка | UUID`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
ICONTAINS("RU0891923", "ru") = TRUE
```

```
ICONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
