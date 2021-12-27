---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_COMPARISON.md
---


# Сравнение



#### Синтаксис {#syntax}

Вариант 1:
```
value_1 = value_2
```
Вариант 2:
```
value_1 != value_2
```
Вариант 3:
```
value_1 < value_2
```
Вариант 4:
```
value_1 <= value_2
```
Вариант 5:
```
value_1 > value_2
```
Вариант 6:
```
value_1 => value_2
```

#### Описание {#description}
Сравнивают значение `value_1` со значением `value_2`.

**Типы аргументов:**
- `value_1` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `value_2` — `Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

```
1 = 1 = TRUE
```

```
7 > 2 > 1 = TRUE
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
