---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IN.md
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
- `item` — `Массив дробных чисел | Массив целых чисел | Массив строк | Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `list` — `Массив дробных чисел | Массив целых чисел | Массив строк | Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
3 IN (23, 5, 3, 67) = TRUE
```

```
3 NOT IN (23, 5, 3, 67) = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
