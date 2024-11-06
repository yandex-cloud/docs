---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DIV.md
---

# DIV



#### Синтаксис {#syntax}


```
DIV( number_1, number_2 )
```

#### Описание {#description}
Возвращает результат деления `number_1` на `number_2`.
Результат будет округлен до целого числа.

**Типы аргументов:**
- `number_1` — `Дробное число | Целое число`
- `number_2` — `Дробное число | Целое число`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}



| **[numerator]**   | **[denominator]**   | **DIV([numerator], [denominator])**   |
|:------------------|:--------------------|:--------------------------------------|
| `4.00`            | `2.00`              | `2`                                   |
| `5.00`            | `3.00`              | `1`                                   |
| `5.00`            | `2.00`              | `2`                                   |
| `2.50`            | `1.20`              | `2`                                   |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
