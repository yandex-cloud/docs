---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_POWER.md
---

# Степень (^)



#### Синтаксис {#syntax}


```
base ^ power
```

#### Описание {#description}
Возводит число `base` в степень `power`.

**Типы аргументов:**
- `base` — `Дробное число | Целое число`
- `power` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
2 ^ 3 = 8.0
```

```
2.1 ^ -0.3 = 0.80045
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
