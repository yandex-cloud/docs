---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/VARP.md
---


# VARP



#### Синтаксис {#syntax}


```
VARP( value )
```

#### Описание {#description}
Возвращает статистическую дисперсию всех значений в выражении по всей совокупности.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}

```
VARP([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
