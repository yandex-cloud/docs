---
editable: false
---

# ARG_MAX



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ARG_MAX( value, comp )
  ```

- Расширенный

  ```
  ARG_MAX( value, comp
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает значение `value`, соответствующее максимальному значению `comp`. Если есть несколько значений `value`, соответствующих максимальному значению `comp`, то возвращет первое попавшееся из них. Это делает функцию недетерминированной.

**Типы аргументов:**
- `value` — `Любой`
- `comp` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
ARG_MAX([Sales], [Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `YDB`.
