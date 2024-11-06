---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/BETWEEN.md
---

# BETWEEN



#### Синтаксис {#syntax}


```
value [ NOT ] BETWEEN low AND high
```

#### Описание {#description}
Возвращает `TRUE`, если `value` принадлежит диапазону значений с `low` по `high` включительно.

Вариант `value NOT BETWEEN low AND high` возвращает противоположное значение

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число | Строка`
- `low` — `Дата | Дата и время | Дробное число | Целое число | Строка`
- `high` — `Дата | Дата и время | Дробное число | Целое число | Строка`


**Возвращаемый тип**: `Логический`

{% note info %}

Тип аргументов `value`, `low`, `high` должен совпадать.

{% endnote %}


#### Примеры {#examples}

```
3 BETWEEN 1 AND 100 = TRUE
```

```
100 BETWEEN 1 AND 100 = TRUE
```

```
3 NOT BETWEEN 1 AND 100 = FALSE
```

```
#2018-01-12# BETWEEN #2018-01-10# AND #2018-01-15# = TRUE
```

```
#2018-01-12 01:02:10# BETWEEN #2018-01-12 01:02:00# AND #2018-01-12 01:02:30# = TRUE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
