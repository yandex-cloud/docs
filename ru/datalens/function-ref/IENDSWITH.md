---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IENDSWITH.md
---

# IENDSWITH



#### Синтаксис {#syntax}


```
IENDSWITH( string, substring )
```

#### Описание {#description}
Регистронезависимый вариант [ENDSWITH](ENDSWITH.md). Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
IENDSWITH("PETROV IVAN", "Ivan") = TRUE
```

```
IENDSWITH("Lorem ipsum", "SUM") = TRUE
```

```
IENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
