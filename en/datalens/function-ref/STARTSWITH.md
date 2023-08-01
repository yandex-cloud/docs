---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/STARTSWITH.md
---

# STARTSWITH (строковая)

_Функция `STARTSWITH` также доступна в следующих категориях: [Функции для работы с массивами](STARTSWITH_ARRAY.md)._

#### Синтаксис {#syntax}


```
STARTSWITH( string, substring )
```

#### Описание {#description}
Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`. Для регистронезависимой проверки см. [ISTARTSWITH](ISTARTSWITH.md).

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
STARTSWITH("Petrov Ivan", "Petrov") = TRUE
```

```
STARTSWITH("Lorem ipsum", "Lore") = TRUE
```

```
STARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
