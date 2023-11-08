---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_DIV.md
---

# Деление (/)



#### Синтаксис {#syntax}


```
number_1 / number_2
```

#### Описание {#description}
Делит число `number_1` на число `number_2`.

**Типы аргументов:**
- `number_1` — `Дробное число | Целое число`
- `number_2` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
4 / 2 = 2.0
```

```
5 / 2 = 2.5
```

```
5.0 / 2 = 2.5
```

```
5 / 2.0 = 2.5
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
