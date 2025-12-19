---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/INTHASH64.md
---

# INTHASH64



#### Синтаксис {#syntax}


```
INTHASH64( value )
```

#### Описание {#description}
Возвращает 64-битный хеш для целого числа `value` в виде целого числа.

**Типы аргументов:**
- `value` — `Целое число`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
INTHASH64(12345) = 16722121143744093920
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.
