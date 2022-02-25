---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MEDIAN.md
---


# MEDIAN



#### Синтаксис {#syntax}


```
MEDIAN( value )
```

#### Описание {#description}
Вовзращает медианное значение.

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
MEDIAN([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
