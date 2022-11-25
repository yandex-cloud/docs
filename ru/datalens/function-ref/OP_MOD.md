---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_MOD.md
---

# Остаток (%)



#### Синтаксис {#syntax}


```
number_1 % number_2
```

#### Описание {#description}
Возвращает остаток от деления первого числа `number_1` на число `number_2`.

**Типы аргументов:**
- `number_1` — `Дробное число | Целое число`
- `number_2` — `Дробное число | Целое число`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
2 % 3 = 2
```

```
2.1 % 3 = 2.1
```

```
3 % 2.1 = 0.9
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
