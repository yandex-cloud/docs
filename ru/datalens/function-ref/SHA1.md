---
editable: false
---

# SHA1



#### Синтаксис {#syntax}


```
SHA1( value )
```

#### Описание {#description}
Возвращает хеш SHA-1 для `value` в виде шестнадцатеричной строки.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
SHA1("DataLens") = "F4EA6F8285E57FC18D8CA03672703B52C302231A"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
