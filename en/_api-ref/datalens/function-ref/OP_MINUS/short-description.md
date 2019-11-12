**Syntax:**`value_1 - value_2`

Behaves differently depending on the argument types. Possible options are listed in the table:

| Type of `value_1`   | Type of `value_2`   | Return value                                                                                                                                                                                                      |
|:--------------------|:--------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number`            | `Number`            | The difference between the numbers `value_1` and `value_2`                                                                                                                                                        |
| `Date`              | `Number`            | The date that is `value_2` days smaller than `value_1` (rounded down to an integer number of days)                                                                                                                |
| `Datetime`          | `Number`            | The date with time, `value_2` days smaller than `value_1`. If `value_2` contains a fractional part, it is converted to hours (`1/24`), minutes (`1/1440`), and seconds (`1/86400`)                                |
| `Date`              | `Date`              | The difference between two dates in days                                                                                                                                                                          |
| `Datetime`          | `Datetime`          | The difference between two dates in days: the integer part — the number of whole days, the fractional part — the number of hours, minutes and seconds expressed as a fraction of the whole day (1 hour is '1/24') |