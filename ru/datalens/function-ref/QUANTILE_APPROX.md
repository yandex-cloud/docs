---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/QUANTILE_APPROX.md
---


# QUANTILE_APPROX



#### Синтаксис {#syntax}


```
QUANTILE_APPROX( value, quant )
```

#### Описание {#description}
Возвращает примерный квантиль уровня `quant` (значение от 0 до 1).

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`
- `quant` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`.
