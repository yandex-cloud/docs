---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/AVG.md
---


# AVG

_Функция `AVG` также доступна в следующих категориях: [Оконные функции](AVG_WINDOW.md)._

#### Синтаксис {#syntax}


```
AVG( value )
```

#### Описание {#description}
Возвращает среднее для всех значений. Работает с числовыми типами данных и с типами `Дата | Дата и время`.

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`


**Возвращаемый тип**: Зависит от типов аргументов

#### Пример {#examples}

```
AVG([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
