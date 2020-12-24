---
editable: false
---

# COUNTD_APPROX



#### Синтаксис {#syntax}


```
COUNTD_APPROX( value )
```

#### Описание {#description}
Вовзращает приблизительное количество уникальных значений в группе. Работает быстрее функции [COUNTD](COUNTD.md), но не гарантирует точность.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNTD_APPROX([ClienID])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Oracle Database 12c (12.1)`.
