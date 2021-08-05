---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# LEFT



#### Синтаксис {#syntax}


```
LEFT( string, number )
```

#### Описание {#description}
Возвращает строку, которая содержит указанное количество символов `number` с начала строки `string`.

**Типы аргументов:**
- `string` — `Строка`
- `number` — `Целое число`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
LEFT("Computer", 4) = "Comp"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
