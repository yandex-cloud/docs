---
editable: false
---

# AVG_IF (оконная)

_Функция `AVG_IF` также доступна в следующих категориях: [Агрегатные функции](AVG_IF.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
        )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  AVG_IF( expression, condition
          TOTAL | WITHIN ... | AMONG ...
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает среднее для всех значений, которые удовлетворяют условию `condition`. Если значения отсутствуют, то возвращается `NULL`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Примеры {#examples}

```
AVG_IF([Profit], [Category] = 'Office Supplies' TOTAL)
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' WITHIN [Date])
```

```
AVG_IF([Profit], [Category] = 'Office Supplies' AMONG [Date])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
