---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# DEGREES



#### Синтаксис {#syntax}


```
DEGREES( radians )
```

#### Описание {#description}
Преобразует радианы в градусы.

**Типы аргументов:**
- `radians` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
DEGREES(0) = 0.0
```

```
DEGREES(PI()) = 180.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
