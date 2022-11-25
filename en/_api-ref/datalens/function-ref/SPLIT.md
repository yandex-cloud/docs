---
editable: false
---

# SPLIT



#### Syntax {#syntax}


```
SPLIT( orig_string [ , delimiter [ , part_index ] ] )
```

#### Description {#description}
Returns a substring from `orig_string` using the `delimiter` delimiter character to divide the string into a sequence of `part_index` parts. Delimiter is a comma by default. If `part_index` is not passed, an array is returned (only for `ClickHouse`, `PostgreSQL` sources)

**Argument types:**
- `orig_string` — `String`
- `delimiter` — `String`
- `part_index` — `Integer`


**Return type**: Depends on argument types

{% note info %}

Only constant values are accepted for the arguments (`delimiter`).

{% endnote %}


#### Examples {#examples}

```
SPLIT("RU-MOW-SVO", "-", 1) = "RU"
```

```
SPLIT("RU-MOW-SVO", "-", -1) = "SVO"
```


#### Data source support {#data-source-support}

`ClickHouse 19.13`, `MySQL 5.6`, `PostgreSQL 9.3`, `YDB`.
