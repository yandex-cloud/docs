---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/OP_PLUS.md
---

# Addition and concatenation (+)



#### Syntax {#syntax}


```
value_1 + value_2
```

#### Description {#description}

{% note warning %}

`Yandex Metrica` does not support string concatenation.

{% endnote %}

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`                                                                         | Type of `value_2`                                                                         | Return value                                                                                                                                                                     |
|:------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <code>Fractional number &#124; Integer</code>                                             | <code>Fractional number &#124; Integer</code>                                             | The sum of the numbers `value_1` and `value_2`.                                                                                                                                  |
| `Date`                                                                                    | <code>Fractional number &#124; Integer</code>                                             | The date that is `value_2` days greater than `value_1` (rounded down to an integer number of days).                                                                              |
| `Datetime`                                                                                | <code>Fractional number &#124; Integer</code>                                             | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`). |
| `String`                                                                                  | `String`                                                                                  | The merging (concatenation) of strings `value_1` and `value_2`.                                                                                                                  |
| <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | <code>Array of fractional numbers &#124; Array of integers &#124; Array of strings</code> | The merging (concatenation) of arrays `value_1` and `value_2`.                                                                                                                   |

Changing the order of arguments does not affect the result.

**Argument types:**
- `value_1` — `Array of fractional numbers | Array of integers | Array of strings | Date | Datetime | Fractional number | Integer | Markup | String`
- `value_2` — `Array of fractional numbers | Array of integers | Array of strings | Date | Datetime | Fractional number | Integer | Markup | String`


**Return type**: Depends on argument types

#### Examples {#examples}

```
2 + 3 = 5
```

```
"Lorem" + " ipsum" = "Lorem ipsum"
```

```
#2019-01-06# + 2 = #2019-01-08#
```

```
2.2 + #2019-01-06# = #2019-01-08#
```

```
2 + #2019-01-06 03# = #2019-01-08 03:00:00#
```

```
#2019-01-06 03# + 2.5 = #2019-01-08 15:00:00#
```


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Yandex Metrica`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
