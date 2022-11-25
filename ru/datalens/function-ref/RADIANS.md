---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RADIANS.md
---

# RADIANS



#### Синтаксис {#syntax}


```
RADIANS( degrees )
```

#### Описание {#description}
Преобразует градусы `degrees` в радианы.

**Типы аргументов:**
- `degrees` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
RADIANS(0) = 0.0
```

```
RADIANS(180) = 3.14159
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
