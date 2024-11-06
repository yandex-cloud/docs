---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LOG.md
---

# LOG



#### Синтаксис {#syntax}


```
LOG( value, base )
```

#### Описание {#description}
Возвращает логарифм числа `value` по основанию числа `base`. Возвращает `NULL`, если число `value` меньше или равно 0.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`
- `base` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
LOG(1, 2.6) = 0.0
```

```
LOG(1024, 2) = 10.0
```

```
LOG(100, 10) = 2.0
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
