---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LEN.md
---

# LEN

_Функция `LEN` также доступна в следующих категориях: [Функции для работы с массивами](LEN_ARRAY.md)._

#### Синтаксис {#syntax}


```
LEN( value )
```

#### Описание {#description}
Возвращает количество символов в строке или элементов в массиве `value`.

**Типы аргументов:**
- `value` — `Массив дробных чисел | Массив целых числел | Массив строк | Строка`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
LEN("Computer") = 8
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
