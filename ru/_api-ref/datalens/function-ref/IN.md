---
editable: false
---

# IN



#### Синтаксис {#syntax}


```
item [ NOT ] IN (<list>)
```

#### Описание {#description}
Проверяет условие соответствия значения хотя бы одному из значений, перечисленных в `IN(...)`.

Вариант `item NOT IN (<`list`>)` возвращает противоположное значение

**Типы аргументов:**
- `item` — `Любой`
- `list` — `Любой`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
3 IN (23, 5, 3, 67) = TRUE
```

```
3 NOT IN (23, 5, 3, 67) = FALSE
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
