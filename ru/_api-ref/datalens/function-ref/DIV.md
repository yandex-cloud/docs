---
editable: false
---

# DIV



#### Синтаксис {#syntax}


```
DIV( number_1, number_2 )
```

#### Описание {#description}
Возвращает результат деления `number_1` на `number_2`.
Результат будет округлен до целого числа.

**Типы аргументов:**
- `number_1` — `Дробное число | Целое число`
- `number_2` — `Дробное число | Целое число`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
DIV(4, 2) = 2
```

```
DIV(5, 3) = 1
```

```
DIV(5.0, 2) = 2
```

```
DIV(2.5, 1.2) = 2
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
