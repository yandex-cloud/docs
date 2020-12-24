---
editable: false
---

# CONTAINS



#### Синтаксис {#syntax}


```
CONTAINS( string, substring )
```

#### Описание {#description}
Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`. Для регистронезависимой проверки см. [ICONTAINS](ICONTAINS.md).

**Типы аргументов:**
- `string` — `Логический | Дата | Дата и время | Геоточка | Геополигон | Число | Строка | UUID`
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

`Материализованный датасет`, `ClickHouse 1.1`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
