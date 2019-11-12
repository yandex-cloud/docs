**Syntax:**`INT( expression )`

Converts the `expression` expression to integer format according to the following rules:

| Type                              | Value                                                                                                                                                                                                            |
|:----------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Number (whole)`                  | Original value                                                                                                                                                                                                   |
| `Number (decimal)`                | Integer part of the number (rounded down)                                                                                                                                                                        |
| <code>Date &#124; Datetime</code> | [Unix time](https://en.wikipedia.org/wiki/Unix_time) corresponding to the date and time. If the value contains time zone data, it's used in the calculation. If the time zone is unknown, the time is set in UTC |
| `String`                          | A number from a decimal string                                                                                                                                                                                   |
| `Boolean`                         | `TRUE` — 1, `FALSE` — 0                                                                                                                                                                                          |