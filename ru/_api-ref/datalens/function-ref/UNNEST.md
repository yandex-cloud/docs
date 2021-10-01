---
editable: false
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

`Материализованный датасет`, `ClickHouse 19.13`, `PostgreSQL 9.3`.
