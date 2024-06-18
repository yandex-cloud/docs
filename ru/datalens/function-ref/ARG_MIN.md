---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ARG_MIN.md
---

# ARG_MIN



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ARG_MIN( value, expression_to_minimize )
  ```

- Расширенный

  ```
  ARG_MIN( value, expression_to_minimize
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает значение `value`, соответствующее минимальному значению `expression_to_minimize`. Если есть несколько значений `value`, соответствующих минимальному значению `expression_to_minimize`, то возвращает первое попавшееся из них. Это делает функцию недетерминированной.

**Типы аргументов:**
- `value` — `Любой`
- `expression_to_minimize` — `Любой`


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

- **Coldest Month**: `ARG_MIN([Month],[Temperature])` .


Результат

| **Coldest Month**   |
|:--------------------|
| `'January'`         |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
