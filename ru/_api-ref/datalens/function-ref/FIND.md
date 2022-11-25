---
editable: false
---

# FIND



#### Синтаксис {#syntax}


```
FIND( string, substring [ , start_index ] )
```

#### Описание {#description}
Возвращает индекс позиции первого символа подстроки `substring` в строке `string`.

Если указан опциональный параметр `start_index`, то поиск начнется с указанной позиции.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`
- `start_index` — `Целое число`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
FIND("Lorem ipsum dolor sit amet", "abc") = 0
```

```
FIND("Lorem ipsum dolor sit amet", "or") = 2
```

```
FIND("Lorem ipsum dolor sit amet", "or", 7) = 16
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
