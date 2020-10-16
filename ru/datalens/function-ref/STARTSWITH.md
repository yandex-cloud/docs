---
editable: false
---

# STARTSWITH

_Строковые функции_

#### Синтаксис {#syntax}


```
STARTSWITH( string, substring )
```

#### Описание {#description}
Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`. Для регистронезависимой проверки см. [ISTARTSWITH](ISTARTSWITH.md).

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Геоточка | Геополигон | Число | Строка | UUID`
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

`Материализованный датасет`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
