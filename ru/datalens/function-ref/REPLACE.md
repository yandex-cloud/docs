---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/REPLACE.md
---

# REPLACE (строковая)

_Функция `REPLACE` также доступна в следующих категориях: [Функции для работы с массивами](REPLACE_ARRAY.md)._

#### Синтаксис {#syntax}


```
REPLACE( string, substring, replace_with )
```

#### Описание {#description}
Ищет подстроку `substring` в строке `string` и заменяет ее строкой `replace_with`.

Если подстрока не найдена, то строка не будет изменена.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`
- `replace_with` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
REPLACE("350 RUB", "RUB", "USD") = "350 USD"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
