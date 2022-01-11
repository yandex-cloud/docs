---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNTD_APPROX.md
---


# COUNTD_APPROX



#### Синтаксис {#syntax}


```
COUNTD_APPROX( value )
```

#### Описание {#description}
Возвращает приблизительное количество уникальных значений в группе. Работает быстрее функции [COUNTD](COUNTD.md), но не гарантирует точность.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
COUNTD_APPROX([ClienID])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Oracle Database 12c (12.1)`, `YDB`.
