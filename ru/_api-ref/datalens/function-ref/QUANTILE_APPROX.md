---
editable: false
---

# QUANTILE_APPROX



#### Синтаксис {#syntax}


```
QUANTILE_APPROX( value, quant )
```

#### Описание {#description}
Возвращает примерный квантиль уровня `quant` (значение от 0 до 1).

**Типы аргументов:**
- `value` — `Число`
- `quant` — `Число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`.
