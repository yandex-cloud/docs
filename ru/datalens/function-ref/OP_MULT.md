---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/OP_MULT.md
---

# Умножение (*)



#### Синтаксис {#syntax}


```
value_1 * value_2
```

#### Описание {#description}
Если оба аргумента — числа, то возвращает результат умножения числа `value_1` на число `value_2`.

Если один из аргументов — `Строка`, а другой — `Целое число`, возвращает строку, повторенную заданное количество раз.

**Типы аргументов:**
- `value_1` — `Дробное число | Целое число | Строка`
- `value_2` — `Дробное число | Целое число | Строка`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
2 * 3 = 6
```

```
2.1 * 3 = 6.3
```

```
"Lorem" * 3 = 'LoremLoremLorem'
```

```
3 * "Lorem" = 'LoremLoremLorem'
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Yandex.Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
