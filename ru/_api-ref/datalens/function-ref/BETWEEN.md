---
editable: false
---

# BETWEEN



#### Синтаксис {#syntax}


```
value [ NOT ] BETWEEEN low AND high
```

#### Описание {#description}
Возвращает `TRUE`, если `value` принадлежит диапазону значений с `low` по `high`.

Вариант `value NOT BETWEEEN low AND high` возвращает противоположное значение

**Типы аргументов:**
- `value` — `Дата | Дата и время | Число | Строка`
- `low` — `Дата | Дата и время | Число | Строка`
- `high` — `Дата | Дата и время | Число | Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
3 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
