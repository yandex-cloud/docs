# IS FALSE

_Операторы_

#### Синтаксис


```
value IS [ NOT ] FALSE
```

#### Описание
Проверяет, является ли значение `value` ложным (`FALSE`).

Вариант `value IS NOT FALSE` возвращает противоположное значение.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Логический`

#### Примеры

```
"" IS FALSE = TRUE
```

```
0 IS FALSE = TRUE
```

```
FALSE IS FALSE = TRUE
```

```
TRUE IS FALSE = FALSE
```

```
TRUE IS NOT FALSE = TRUE
```

```
#2019-03-05# IS FALSE = FALSE
```

```
#2019-03-05 01:02:03# IS FALSE = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
