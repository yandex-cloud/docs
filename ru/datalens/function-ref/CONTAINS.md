---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CONTAINS.md
---

# CONTAINS (строковая)

_Функция `CONTAINS` также доступна в следующих категориях: [Функции для работы с массивами](CONTAINS_ARRAY.md)._

#### Синтаксис {#syntax}


```
CONTAINS( string, substring )
```

#### Описание {#description}
Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`. Для регистронезависимой проверки см. [ICONTAINS](ICONTAINS.md).

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
CONTAINS("RU0891923", "RU") = TRUE
```

```
CONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
