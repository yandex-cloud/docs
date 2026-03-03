* Strings `string`

  * `=` and `!=`: Equality and inequality. The value supports [glob expressions](https://en.wikipedia.org/wiki/Glob_(programming)) with `* ? |`. `[ ]` characters are not supported.

  * `=~` and `!~`: Regular expression in [re2](https://github.com/google/re2/wiki/Syntax) format.

  * `==` and `!==`: Strict equality and strict inequality. Glob expressions and regular expressions will be interpreted as plain characters.

* `duration`: Applies to the values of `trace.duration` and `span.duration`.
  * Comparison operations `> < >= <=` are supported. 
  * Follow `1s`, `10ms`, `150us`, `2m`, and `6h` format, without quotes.
