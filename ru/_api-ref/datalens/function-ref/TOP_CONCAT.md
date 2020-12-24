---
editable: false
---

# TOP_CONCAT



#### Синтаксис {#syntax}


```
TOP_CONCAT( expression, amount [ , separator ] )
```

#### Описание {#description}
Возвращает строку, которая содержит `amount` наиболее часто встречающихся значений из каждой группы `expression` с разделителем `separator` (по умолчанию разделитель — запятая).

**Типы аргументов:**
- `expression` — `Логический | Дата | Дата и время | Геоточка | Геополигон | Число | Строка | UUID`
- `amount` — `Целое число`
- `separator` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`amount`, `separator`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
TOP_CONCAT([Profit], 3)
```

```
TOP_CONCAT([Profit], 3, '; ')
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`.
