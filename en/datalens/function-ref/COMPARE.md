---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/COMPARE.md
---

# COMPARE



#### Syntax {#syntax}


```
COMPARE( left, right, epsilon )
```

#### Description {#description}
Returns:
* 0 if `left` and `right` differs by not more than `epsilon`.
* -1 if `left` is less than `right` by more than `epsilon`.
* 1 if `left` is greater than `right` by more than `epsilon`.

**Argument types:**
- `left` — `Fractional number | Integer`
- `right` — `Fractional number | Integer`
- `epsilon` — `Fractional number | Integer`


**Return type**: `Integer`

#### Examples {#examples}

```
COMPARE(1.25, 1.26, 0.1) = 0
```

```
COMPARE(1.25, 1.26, 0.001) = -1
```

```
COMPARE(1.26, 1.25, 0.001) = 1
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Documents`.
