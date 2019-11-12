**Syntax:**`value_1 + value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                    |
|:--------------------|:--------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The sum of the numbers `value_1` and `value_2`                                                                                                                                  |
| `Date`              | `Number`            | The date that is `value_2` days greater than `value_1` (rounded down to an integer number of days)                                                                              |
| `Datetime`          | `Number`            | The date with time, `value_2` days greater than `value_1`. If `value_2` contains a fractional part, it is converted hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`) |
| `String`            | `String`            | The merging (concatenation) of strings `value_1` and `value_2`                                                                                                                  |

Changing the order of arguments does not affect the result.