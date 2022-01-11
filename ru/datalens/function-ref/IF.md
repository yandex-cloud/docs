---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IF.md
---


# IF



#### Синтаксис {#syntax}

Вариант 1:
```
IF condition_1
    THEN result_1
[ ELSEIF condition_2
    THEN result_2
  ... ]
ELSE
    default_result
END
```
Вариант 2:
```
IF(
    condition_1, result_1,
  [ condition_2, result_2,
    ... ]
    default_result
)
```

#### Описание {#description}
Проверяет последовательно логические выражения `condition_1`, `condition_2`, ... и возвращает соответсвующий результат для первого выполнения.
Если все `condition_1`, `condition_2`, ... возвращают `FALSE`, то блок возвращает `default_result`.

**Типы аргументов:**
- `condition_1` — `Любой`
- `result_1` — `Любой`
- `condition_2` — `Любой`
- `result_2` — `Любой`
- `default_result` — `Любой`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
IF("Hello world" LIKE "%el%", "is like", "is not like") = "is like"
```

```
IF
    [Profit] > 100
        THEN "High"
    ELSEIF [Profit] > 25
        THEN "Medium"
    ELSE "Low"
END
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
