Данные в YQL могут как гарантированно иметь значение, так и быть пустыми. Пустые значения обозначаются как `NULL`. Типы данных, которые могут содержать значения `NULL`, называются _опциональными_ или, в терминах SQL, — _nullable_.

Опциональные типы данных в {% if audience != "external" %}[текстовом виде](https://yql.yandex-team.ru/docs/ydb/misc/type_string/){% else %}[текстовом виде](../yql/reference/misc/type_string.md){% endif %} обозначаются вопросительным знаком в конце (например, `String?`) или как `Optional<...>`.

Наиболее часто на опциональных типах данных выполняются следующие операции:

* [UNWRAP]{% if audience == "external" %}(../yql/reference/builtins/basic.md#unwrap){% else %}(https://yql.yandex-team.ru/docs/ydb/builtins/basic#unwrap){% endif %}
 — извлечь значение оригинального типа из опционального, `T?` преобразуется в `T`.

  Пример записи:

  ```sql
  UNWRAP(x)
  ```

  {% note warning %}

  Операция `UNWRAP` вернет ошибку времени выполнения, если значение `x` есть `NULL`.

  {% endnote %}

* [COALESCE]{% if audience == "external" %}(../yql/reference/builtins/basic.md#coalesce){% else %}(https://yql.yandex-team.ru/docs/ydb/builtins/basic#coalesce){% endif %}
 — проверить значение на `NULL`, если да, то заменить `NULL` значением `value`.

  Примеры записи:
  
  ```sql
  COALESCE(x, "value")
  ```

  ```sql
  x ?? "value"
  ```

  ```sql
  IF(x is not null,UNWRAP(x),"value")
  ```

  Приведенные примеры записи эквивалентны.

* [IF]{% if audience == "external" %}(../yql/reference/builtins/basic.md#if){% else %}(https://yql.yandex-team.ru/docs/ydb/builtins/basic#if){% endif %}
 — вычислить выражение, если значение `x` не является `NULL`.

  Пример записи:
  
  ```sql
  IF(x is not null,f(UNWRAP(x)))
  ```
  
  В этом примере можно вызвать функцию `f` на оригинальном значении, так как в предикате `IF` уже проверено, что `x` не `NULL`.

* [JUST]{% if audience == "external" %}(../yql/reference/builtins/basic.md#just){% else %}(https://yql.yandex-team.ru/docs/ydb/builtins/basic#just){% endif %}
 — изменить тип данных на опциональный текущего, `T` преобразуется в `T?`.

  Пример записи:

  ```sql
  JUST(x)
  ```

* [NOTHING]{% if audience == "external" %}(../yql/reference/builtins/basic.md#nothing){% else %}(https://yql.yandex-team.ru/docs/ydb/builtins/basic#nothing){% endif %}
 — создать пустое значение с указанным типом.

  Пример записи:

  ```sql
  NOTHING(String?)
  ```
