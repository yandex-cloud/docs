---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ARG_MIN.md
---

# ARG_MIN



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ARG_MIN( value, comp )
  ```

- Расширенный

  ```
  ARG_MIN( value, comp
           [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
           [ BEFORE FILTER BY ... ]
         )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает значение `value`, соответствующее минимальному значению `comp`. Если есть несколько значений `value`, соответствующих минимальному значению `comp`, то возвращет первое попавшееся из них. Это делает функцию недетерминированной.

**Типы аргументов:**
- `value` — `Любой`
- `comp` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
ARG_MIN([Sales], [Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `YDB`.
