---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SUM_IF_WINDOW.md
---

# SUM_IF (оконная)

_Функция `SUM_IF` также доступна в следующих категориях: [Агрегатные функции](SUM_IF.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  SUM_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  SUM_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает сумму всех значений выражения, которые удовлетворяют условию `condition`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
SUM_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
SUM_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
