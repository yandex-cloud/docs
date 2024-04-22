---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/SPLIT.md
---

# SPLIT



#### Syntax {#syntax}


```
SPLIT( orig_string [ , delimiter [ , part_index ] ] )
```

#### Description {#description}
It splits `orig_string` into a sequence of substrings using the `delimiter` character as separator and returns the substring whose number is equal to the `part_index` parameter. By default, the delimiting character is comma. If `part_index` is negative, the substring to return is counted from the end of `orig_string`. If the number of substrings is less than the `part_index` [absolute value](https://en.wikipedia.org/wiki/Absolute_value), the function returns an empty string. If `part_index` was not provided, the function returns an array of the substrings (only for `ClickHouse`, `PostgreSQL` sources).

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
SPLIT("192.168.0.1", ".", 1) = "192"
```

```
SPLIT("192.168.0.1", ".", -1) = "1"
```

```
SPLIT("192.168.0.1", ".", 5) = ""
```

```
SPLIT("192.168.0.1", ".") = "['192 ','168 ','0 ','1']"
```

```
SPLIT("192.168.0.1") = "192.168.0.1"
```

```
SPLIT("a,b,c,d") = "['a','b','c','d']"
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `MySQL 5.7`, `PostgreSQL 9.3`, `YDB`.
