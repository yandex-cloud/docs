---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MURMURHASH2_64.md
---

# MURMURHASH2_64



#### Синтаксис {#syntax}


```
MURMURHASH2_64( value )
```

#### Описание {#description}
Возвращает хеш MurmurHash2 64-битный для `value` в виде целого числа.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
MURMURHASH2_64("DataLens") = 12204402796868507663
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
