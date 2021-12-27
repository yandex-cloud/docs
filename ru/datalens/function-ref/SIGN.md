---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SIGN.md
---


# SIGN



#### Синтаксис {#syntax}


```
SIGN( number )
```

#### Описание {#description}
Возвращает знак числа `number`:
- `-1` если число отрицательное;
- `0` если число равно нулю;
- `1` если число положительное.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
SIGN(-115) = -1
```

```
SIGN(0) = 0
```

```
SIGN(78) = 1
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
