---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/AND.md
---

# AND



#### Синтаксис {#syntax}


```
value_1 AND value_2
```

#### Описание {#description}
Выполняет логическое соединение двух выражений по условию `И`.

**Типы аргументов:**
- `value_1` — `Логический`
- `value_2` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`value_1`, `value_2`)

{% note info %}

Тип аргументов (`value_1`, `value_2`) должен совпадать.

{% endnote %}


#### Пример {#examples}

```
[Profit] > 30 AND [Weekday] IN ("Saturday", "Sunday")
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
