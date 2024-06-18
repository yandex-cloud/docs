---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ARG_MAX.md
---

# ARG_MAX



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ARG_MAX( value, expression_to_maximize )
  ```

- Расширенный

  ```
  ARG_MAX( value, expression_to_maximize
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает значение `value`, соответствующее максимальному значению `expression_to_maximize`. Если есть несколько значений `value`, соответствующих максимальному значению `expression_to_maximize`, то возвращает первое попавшееся из них. Это делает функцию недетерминированной.

**Типы аргументов:**
- `value` — `Любой`
- `expression_to_maximize` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}




Исходные данные

| **Month**     | **Temperature**   |
|:--------------|:------------------|
| `'January'`   | `-8.00`           |
| `'February'`  | `-4.00`           |
| `'March'`     | `-1.00`           |
| `'April'`     | `7.00`            |
| `'May'`       | `14.00`           |
| `'June'`      | `18.00`           |
| `'July'`      | `22.00`           |
| `'August'`    | `19.00`           |
| `'September'` | `13.00`           |
| `'October'`   | `5.00`            |
| `'November'`  | `1.00`            |
| `'December'`  | `-4.00`           |

Формулы:

- **Warmest Month**: `ARG_MAX([Month],[Temperature])` .


Результат

| **Warmest Month**   |
|:--------------------|
| `'July'`            |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
