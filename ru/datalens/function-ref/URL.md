---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/URL.md
---

# URL



#### Синтаксис {#syntax}


```
URL( address, text )
```

#### Описание {#description}
Оборачивает `text` в ссылку на URL `address`. При переходе по ссылке страница открывается в новой вкладке браузера.

**Типы аргументов:**
- `address` — `Строка`
- `text` — `Разметка | Строка`


**Возвращаемый тип**: `Разметка`

#### Пример {#examples}

```
URL('https://yandex.ru/search/?text=buy+a+' + [Product Name], [Product Name])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
