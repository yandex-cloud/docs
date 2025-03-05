---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/TOOLTIP.md
---

# TOOLTIP



#### Синтаксис {#syntax}


```
TOOLTIP( text, tooltip [ , placement ] )
```

#### Описание {#description}
Добавляет небольшую всплывающую подсказку к тексту или результату выполнения других функций разметки. Аргумент `placement` отвечает за расположение подсказки (`top`, `right`, `bottom` или `left`). Значение по умолчанию — `right`.

**Типы аргументов:**
- `text` — `Разметка | Строка`
- `tooltip` — `Разметка | Строка`
- `placement` — `Строка`


**Возвращаемый тип**: `Разметка`

#### Примеры {#examples}

```
TOOLTIP(SIZE('Hello', '12px'), URL('https://ya.ru', 'Yandex'), 'top')
```

```
TOOLTIP([main_text], [tooltip_text])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
