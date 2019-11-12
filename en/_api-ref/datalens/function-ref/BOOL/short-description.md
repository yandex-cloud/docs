**Syntax:**`BOOL( expression )`

Converts the `expression` expression to Boolean type according to the following rules:

| Type                              | `FALSE`             | `TRUE`     |
|:----------------------------------|:--------------------|:-----------|
| `Number`                          | `0`, `0.0`          | All others |
| `String`                          | Empty string (`""`) | All others |
| `Boolean`                         | `FALSE`             | `TRUE`     |
| <code>Date &#124; Datetime</code> | -                   | `TRUE`     |