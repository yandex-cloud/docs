---
editable: false
---

# BETWEEN

_Операторы_

#### Синтаксис


```
value [ NOT ] BETWEEEN low AND high
```

#### Описание
Возвращает `TRUE`, если `value` принадлежит диапазону значений с `low` по `high`.

Вариант `value NOT BETWEEEN low AND high` возвращает противоположное значение

**Типы аргументов:**
- `value` — `Любой`
- `low` — `Любой`
- `high` — `Любой`


**Возвращаемый тип**: `Логический`

#### Примеры

```
3 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
