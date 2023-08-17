---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MIN.md
---

# MIN

_Функция `MIN` также доступна в следующих категориях: [Оконные функции](MIN_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MIN( value )
  ```

- Расширенный

  ```
  MIN( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает минимальное значение.

Если `value`:
- число — возвращает наименьшее число;
- дата — возвращает самую раннюю дату;
- строка — возвращает первое значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
MIN([Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
