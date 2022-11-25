---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_NEGATION.md
---

# Отрицание (-)



#### Синтаксис {#syntax}


```
-value
```

#### Описание {#description}
Возвращает число `value` с противоположным знаком.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
- (5) = -5
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
