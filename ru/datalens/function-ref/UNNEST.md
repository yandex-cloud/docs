---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/UNNEST.md
---

# UNNEST



#### Синтаксис {#syntax}


```
UNNEST( array )
```

#### Описание {#description}
Дублирует исходную строку для каждого элемента массива `array`.

**Типы аргументов:**
- `array` — `Массив дробных чисел | Массив целых числел | Массив строк`


**Возвращаемый тип**: Зависит от типов аргументов

{% note info %}

`PostgreSQL` запрещает фильтрацию по полям, содержащим функцию `UNNEST`. Не используйте такие поля для создания селектора, если источник данных — `PostgreSQL`.

{% endnote %}


#### Пример {#examples}




Исходные данные

| **City**   | **Category**                       |
|:-----------|:-----------------------------------|
| `'Moscow'` | `['Office Supplies', 'Furniture']` |
| `'London'` | `['Office Supplies']`              |

Результат

| **[City]**   | **UNNEST([Category])**   |
|:-------------|:-------------------------|
| `'Moscow'`   | `'Office Supplies'`      |
| `'Moscow'`   | `'Furniture'`            |
| `'London'`   | `'Office Supplies'`      |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `PostgreSQL 9.3`.
