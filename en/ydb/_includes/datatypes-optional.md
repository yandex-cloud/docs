Data in YQL can have guaranteed values or be empty. Empty values are shown as `NULL`. Data types that can include `NULL` values are called _optional_ or, in SQL terms, _nullable_.

Optional data types in {% if audience != "external" %}[text format](https://yql.yandex-team.ru/docs/ydb/misc/type_string/){% else %}[text format](../yql/reference/misc/type_string.md){% endif %} have a question mark at the end (for example, `String?`) or `Optional<...>`.

The following operations are most often performed on optional data types:

* [UNWRAP](../yql/reference/builtins/basic.md#unwrap): Extract the value of the original type from the optional data type, `T?` is converted to `T`.

  Sample statement:

  ```sql
  UNWRAP(x)
  ```

  {% note warning %}

  The `UNWRAP` operation returns a runtime error if the value of `x` is `NULL`.

  {% endnote %}

* [COALESCE](../yql/reference/builtins/basic.md#coalesce): Check if the value is `NULL`, if yes, replace `NULL` with `value`.

  Sample statements:

  ```sql
  COALESCE(x, "value")
  ```

  ```sql
  x ?? "value"
  ```

  ```sql
  IF(x is not null,UNWRAP(x),"value")
  ```

  The above sample statements are the same.

* [IF](../yql/reference/builtins/basic.md#if): Calculate the expression if the value of `x` is not `NULL`.

  Sample statement:

  ```sql
  IF(x is not null,f(UNWRAP(x)))
  ```

  In this sample, you can call the `f` function on the original value, because the `IF` predicate has already verified that `x` is not `NULL`.

* [JUST](../yql/reference/builtins/basic.md#just): Change the data type to the optional type of the current one, `T` converts to `T?`.

  Sample statement:

  ```sql
  JUST(x)
  ```

* [NOTHING](../yql/reference/builtins/basic.md#nothing): Create an empty value with the specified type.

  Sample statement:

  ```sql
  NOTHING(String?)
  ```

