---
editable: false
---

# ANY



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ANY( value )
  ```

- Расширенный

  ```
  ANY( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает произвольное значение `value` из группы. Это недетерминированная агрегация — результат может различаться от запроса к запросу на одних и тех же входных данных.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
ANY([Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `MySQL 5.7`, `YDB`.
