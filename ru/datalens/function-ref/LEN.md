---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LEN.md
---

# LEN



#### Синтаксис {#syntax}


```
LEN( value )
```

#### Описание {#description}
Возвращает количество символов в строке или элементов в массиве `value`.

**Типы аргументов:**
- `value` — `Массив дробных чисел | Массив целых числел | Массив строк | Строка`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
LEN("Computer") = 8
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
