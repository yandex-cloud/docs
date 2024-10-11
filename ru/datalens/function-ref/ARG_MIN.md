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

| **Date**     | **Temperature**   |
|:-------------|:------------------|
| `2019-03-01` | `5.00`            |
| `2019-03-02` | `0.00`            |
| `2019-03-03` | `-3.00`           |
| `2019-03-04` | `1.00`            |
| `2019-03-05` | `4.00`            |
| `2019-03-06` | `5.00`            |
| `2019-03-07` | `1.00`            |
| `2019-03-08` | `-6.00`           |
| `2019-03-09` | `-6.00`           |
| `2019-03-10` | `-4.00`           |
| `2019-03-11` | `-2.00`           |
| `2019-03-12` | `0.00`            |

Формулы:

- **Coldest Day**: `ARG_MIN([Date],[Temperature])` .


Результат

| **Coldest Day**   |
|:------------------|
| `2019-03-08`      |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
