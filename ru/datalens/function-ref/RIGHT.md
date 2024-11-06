---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RIGHT.md
---

# RIGHT



#### Синтаксис {#syntax}


```
RIGHT( string, number )
```

#### Описание {#description}
Возвращает строку, которая содержит указанное количество символов `number` с конца строки `string`.

**Типы аргументов:**
- `string` — `Строка`
- `number` — `Целое число`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
RIGHT("Computer", 3) = "ter"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
