---
editable: false
---

# CITYHASH64



#### Синтаксис {#syntax}


```
CITYHASH64( value )
```

#### Описание {#description}
Возвращает хеш CityHash64 для `value` в виде целого числа.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
CITYHASH64("DataLens") = 1276466053635395874
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
