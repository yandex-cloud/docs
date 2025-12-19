---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MD5.md
---

# MD5



#### Синтаксис {#syntax}


```
MD5( value )
```

#### Описание {#description}
Возвращает хеш MD5 для `value` в виде шестнадцатеричной строки.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
MD5("DataLens") = "C1FD5D9E4189FB89C1021A72F7E06C00"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
