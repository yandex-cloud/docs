---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/VAR.md
---

# VAR



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  VAR( value )
  ```

- Расширенный

  ```
  VAR( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

{% endlist %}

#### Описание {#description}
Возвращает статистическую дисперсию всех значений в выражении на основе выборки из совокупности.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}

```
VAR([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
