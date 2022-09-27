---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ENDSWITH.md
---

# ENDSWITH



#### Синтаксис {#syntax}


```
ENDSWITH( string, substring )
```

#### Описание {#description}
Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.Для регистронезависимой проверки см. [IENDSWITH](IENDSWITH.md).

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Дата и время (устаревший) | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
ENDSWITH("Petrov Ivan", "Ivan") = TRUE
```

```
ENDSWITH("Lorem ipsum", "sum") = TRUE
```

```
ENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
