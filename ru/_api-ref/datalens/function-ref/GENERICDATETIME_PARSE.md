---
editable: false
---

# GENERICDATETIME_PARSE



#### Синтаксис {#syntax}


```
GENERICDATETIME_PARSE( value )
```

#### Описание {#description}
Переводит выражение `value` в формат даты и времени. В отличие от [GENERICDATETIME](GENERICDATETIME.md), поддерживает множество форматов.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Дата и время`

#### Примеры {#examples}

```
GENERICDATETIME_PARSE("2019-01-02 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("20190102030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("20190102 030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019.01.02 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("02/01/2019 03:04:05") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019-01-02 03:04") = ##2019-01-02 03:04:00##
```

```
GENERICDATETIME_PARSE("2019-01-02 030405") = ##2019-01-02 03:04:05##
```

```
GENERICDATETIME_PARSE("2019 Jan 02 03:04:05") = ##2019-01-02 03:04:05##
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`.
