---
editable: false
---

# UTF8



#### Синтаксис {#syntax}


```
UTF8( string, old_encoding )
```

#### Описание {#description}
Переводит кодировку строки `string` в `UTF8`.

**Типы аргументов:**
- `string` — `Строка`
- `old_encoding` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
UTF8([Name], "CP-1251")
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`.
