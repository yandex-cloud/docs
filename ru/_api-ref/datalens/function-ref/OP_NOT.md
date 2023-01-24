---
editable: false
---

# NOT



#### Синтаксис {#syntax}


```
NOT value
```

#### Описание {#description}
Инвертирует логическое значение.

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
NOT FALSE = TRUE
```

```
NOT TRUE = FALSE
```

```
NOT "" = TRUE
```

```
NOT "text" = FALSE
```

```
NOT 0 = TRUE
```

```
NOT 1 = FALSE
```

```
NOT #2019-01-01# = FALSE
```

```
NOT #2019-01-01 03:00:00# = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
