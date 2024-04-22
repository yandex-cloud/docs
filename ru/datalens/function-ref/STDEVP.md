---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/STDEVP.md
---

# STDEVP



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  STDEVP( value )
  ```

- Расширенный

  ```
  STDEVP( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает статистическое [стандартное отклонение](https://ru.wikipedia.org/wiki/Среднеквадратическое_отклонение) всех значений в выражении на основе смещенной совокупности. Функция показывает, насколько разбросаны точки данных относительно их среднего значения. Другими словами, стандартное отклонение показывает, как сильно значения в наборе данных отклоняются от среднего значения.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}

```
STDEVP([Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
