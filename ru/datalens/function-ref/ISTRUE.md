---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ISTRUE.md
---

# IS TRUE



#### Синтаксис {#syntax}


```
value IS [ NOT ] TRUE
```

#### Описание {#description}
Проверяет, является ли значение `value` истинным (`TRUE`).

Вариант `value IS NOT TRUE` возвращает противоположное значение.

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
"qwerty" IS TRUE = TRUE
```

```
123 IS TRUE = TRUE
```

```
TRUE IS TRUE = TRUE
```

```
FALSE IS TRUE = FALSE
```

```
FALSE IS NOT TRUE = TRUE
```

```
#2019-03-05# IS TRUE = TRUE
```

```
#2019-03-05 01:02:03# IS TRUE = TRUE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
