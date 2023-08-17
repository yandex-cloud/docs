---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COMPARE.md
---

# COMPARE



#### Синтаксис {#syntax}


```
COMPARE( left, right, epsilon )
```

#### Описание {#description}
Возвращает:
* 0, если `left` и `right` отличаются не более чем на `epsilon`.
* -1, если `left` меньше `right` более чем на `epsilon`.
* 1, если `left` больше `right` более чем на `epsilon`.

**Типы аргументов:**
- `left` — `Дробное число | Целое число`
- `right` — `Дробное число | Целое число`
- `epsilon` — `Дробное число | Целое число`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COMPARE(1.25, 1.26, 0.1) = 0
```

```
COMPARE(1.25, 1.26, 0.001) = -1
```

```
COMPARE(1.26, 1.25, 0.001) = 1
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`.
