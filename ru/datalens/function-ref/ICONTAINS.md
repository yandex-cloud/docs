---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ICONTAINS.md
---

# ICONTAINS



#### Синтаксис {#syntax}


```
ICONTAINS( string, substring )
```

#### Описание {#description}
Регистронезависимый вариант [CONTAINS](CONTAINS.md). Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`.

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Дата и время (устаревший) | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
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

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
