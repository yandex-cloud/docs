# Query language

This section describes the query language for log selection and filtering. The {{ monium-name }} interface and API use a unified query language to obtain data. This language allows applying filter expressions to every log line. Same as in SQL, you can use conditional expressions in the `WHERE` part.

## Data types {#types}

The data type is determined by the literal form of the expression. The query language supports primitive data types: 

* String: Any literal expression in single or double quotes will be represented as a string.

* Scalar: An [IEEE 754 standard](https://en.wikipedia.org/wiki/IEEE_754-2008_revision)-compliant real double-precision floating point number, not including the special `NaN` and infinity values.

    The number type supports scientific notation with the fraction and power of ten and the following suffixes:
    * `k`: 10^3^
    * `M`: 10^6^
    * `G`: 10^9^
    * `T`: 10^12^
    * `P`: 10^15^
    * `E`: 10^18^

    Here is an example:

    ```
    101
    75.3
    20G
    1E-3
    ```

## Log selection and filtering language {#selector}

The query language is used to describe log filters and is similar to the monitoring selector language. You can select multiple logs using a set of _selectors_ that filter label values. In this context, top-level fields, e.g., `message` and `level`, are treated as labels, same as in `labels` and `meta`.
_Selector_ consists of a label name, a statement, and an expression that describes a set of label values. Conditions inside a _selector_ are joined with `AND`.

Here is an example:

```js
{project="folder__{{ folder-id-example }}", service="fetcher", cluster="production", duration > 500}
```

### Operators:

|Selector type | Description | Examples|
|-|-|-|
| `label="<value>"`   | Returns all logs with labels matching the value in `value`. The value supports [glob expressions](https://en.wikipedia.org/wiki/Glob_(programming)) (the only allowed characters are `*`, `?`, and `\|`; `[` and `]` are not supported). | `host="vla"` returns all logs with the host label set to `vla`.<br/><br/>`host="*"` returns logs with the `host` label.<br/><br/>`host="sas-*"` returns logs with the `host` label value starting with the `sas-` prefix.<br/><br/>`host="sas-?00"` returns logs with the `host` label set to `sas-100`, `sas-200`, and so on.<br/><br/>`host="sas*\|vla*"` returns logs with the `host` label value starting with the `sas` or `vla` prefix. |
| `label="-"`         | Returns all logs that do not have the specified label.                                                                                                                                                                                                | `host="-"` returns logs that do not have the `host` label.<br/><br/>`host="-\|myhost"` returns logs that do not have the `host` label or whose `host` is set to `myhost`.                                                                                                                                                                                                                                                                                                       |
| `label!="<value>"`  | This selector is opposite to `label="<value>"`.                                                                                                                                                                                                             | `host!="myhost-*"` returns logs that do not have the `host` label or whose `host` value does not start with the `myhost-*` prefix.                                                                                                                                                                                                                                                                                                                                                   |
| `label=="<value>"`  | Returns logs whose `label` value exactly matches `<value>`, without `glob` support.                                                                                                                                            | `host=="myhost"` returns logs whose `host` label value matches the `myhost` string.<br/><br/>`host=="*"` returns logs whose `host` label value contains the literal `*` value.                                                                                                                                                                                                                                                                        |
| `label!=="<value>"` | This selector is opposite to `label=="<value>"`.                                                                                                                                                                                                            | `host!=="myhost"` returns logs that do not have the `host` label or whose `host` value does not match the `myhost` string.                                                                                                                                                                                                                                                                                                                                                      |
| `message=*"<substring>"` or `meta.key=*"<substring>"`| Returns all logs whose label value contains `<substring>`, case-insensitive (`<substring>` may be a glob expression). This operator works only with labels of the `message` and `meta` types.| `message=*"request"` returns logs with `message` set to `Failed search request`, `Request cancelled`, etc.<br/><br/> `meta.error=*"failed*request"` returns logs `meta.error` set to `Failed to make a request`, `Reader failed to retrieve data from a request`, etc. |
| `message!=*"<substring>"` or `meta.key!=*"<substring>"`| This operator is opposite to `=*`. ||
| `label=~"<regex>"`  | Returns logs whose `label` value satisfies the `<regex>` regular expression in [re2](https://github.com/google/re2/wiki/Syntax) syntax.                                                                                                 |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `label!~"<regex>"`  | This selector is opposite to `label=~"<regex>"`.                                                                                                                                                                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `label>300`         | Returns all logs whose `label` value (optionally cast to the type of the right-hand operand) is greater than the specified value.                                                                                                                              | `duration>500` returns logs whose `duration` (cast to a numeric value) is greater than 500.                                                                                                                                                                                                                                                                                                                                                                      |
| `label>=300`        | Returns all logs whose `label` value (optionally cast to the type of the right-hand operand) is greater than or equal to the specified value.                                                                                                                    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `label<300`         | Returns all logs whose `label` value (optionally cast to the type of the right-hand operand) is less than the specified value.                                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `label<=300`        | Returns all logs whose `label` value (optionally cast to the type of the right-hand operand) is less than or equal to the specified value.                                                                                                                    |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

For the `>`, `>=`, `<`, and `<=` operators, the right-hand operand is always expected to be a numeric literal (except for the `level` label), and the comparison is performed by casting the label value to a number. If the label value cannot be cast, the result of that part of the expression is considered false.

To search by labels stored in the `meta` metadata, you must specify a fully qualified name in `meta.label_name` format. You can use all the same operators as are used for top-level labels and `labels`.

Below are some examples of selectors based on the following data:

```js
....
project="folder__{{ folder-id-example }}"
service="fetcher"
cluser="production"
level=ERROR
labels={hook_type="LIVENESS", object_type="WORKLOAD", start_time=1708348144767787, fail_reason=2000, state="EHttpGetState_SUCCESS"}
meta={user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 YaBrowser/24.1.0.0 Safari/537.36"}
```
Selector that filters log lines with the INFO or DEBUG logging level:

```js
{project="folder__{{ folder-id-example }}", service="fetcher", cluser="production", level="INFO|DEBUG"}
```

Selector that filters log lines whose `fail_reason` label (one of the keys in the `labels` field) contains an integer larger than 1,000:

```js
{project="folder__{{ folder-id-example }}", service="fetcher", cluser="production", fail_reason>1000}
```

Searching for all errors that occurred when queried by a particular agent:

```js
{project="folder__{{ folder-id-example }}", service="fetcher", cluser="production", level>="ERROR", fail_reason=200, meta.user_agent=*"Chrome"}
```

Label names can contain the `.` characters; they are treated as part of a single label’s name. Such characters are not escaped in the selector:

```js
{exception.type="java.lang.RuntimeException"}
```

Or like this for `meta`:

```js
{meta.exception.message="cannot replace metrics*"}
```

## Minimum required selector {#required-selector}

For a selector, there is a minimum set of required labels that must be there in each query. This effectively represents the maximum search area for a single selector. The required labels are either `project` + `service` or `log_group_id`.

Minimum selector limitations:

| Label     | I/O                                                                                                                          | Example                                                                                           |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `project` | Must have a single value and an exact match; not a required label if the selector has the `trace.id` label.    | `{project=folder__{{ folder-id-example }}, service=coremon}` `{trace.id="fcdcbceff9cb39ef"}`                             |
| `service` | May have a multiple value and an exact match; not a required label if the selector has the `trace.id` label. | `{project=folder__{{ folder-id-example }}, service="coremon\|fetcher"}` `{project=folder__{{ folder-id-example }}, trace.id="fcdcbceff9cb39ef"}` |

## Label limitations {#labels-limitation}

Some labels are subject to limitations related to operators and their values:

| Label               | I/O                                                                                                                                                                                | Example                                                                               |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| `project`           | Must have a single value and an exact match                                                                                                                                      | `{project=folder__{{ folder-id-example }}, service=coremon}`                                                 |
| `cluster`/`service` | May have a multiple value and an exact match                                                                                                                                   | `{project=folder__{{ folder-id-example }}, service=coremon}` `{project=folder__{{ folder-id-example }}, service="coremon\|fetcher"}` |
| `host`/`message`    | The `<`, `<=`, `>`, and `>=` operators are not used                                                                                                                                                 |                                                                                      |
| `trace.id`          | May have a multiple value and an exact match                                                                                                                                   | `{project=folder__{{ folder-id-example }}, trace.id="36a91077c9806b4c\|cc26b62976badd0"}`                    |
| `span.id`           | May have a multiple value and an exact match                                                                                                                                   | `{project=folder__{{ folder-id-example }}, trace.id="cc26b62976badd0", span.id="0cc26b62976badd0"}`          |
| `level`             | The values must be from the `TRACE`&#124;`DEBUG`&#124;`INFO`&#124;`WARN`&#124;`ERROR`&#124;`FATAL` scope; for `level`, you can use the `<`, `<=`, `>`, and `>=` comparisons in the order as listed | `{level >= WARN}`                                                                    |

## Working with trace.id

The query language allows omitting any number of leading zeroes in the `trace.id` value.
Therefore, the following selectors are equivalent:

* `{trace.id="000000000000000036a91077c9806b4c"}`
* `{trace.id="000036a91077c9806b4c"}`
* `{trace.id="36a91077c9806b4c"}`

## Recommendations for optimizing selector performance {#selector-performance-tuning}

For sparse data ([learn more](https://at.yandex-team.ru/clubs/monitoring/4960)), optimizations make it possible to search only through a portion of the storage, so **the more accurately your query narrows down the selection, the faster it is**. Here is an example:

* `{project = "...", service = "...", meta.order.id = "*abc*123*"}`
The query does not specify exact attribute values, so the system will have to search everywhere.

* `{project, service, meta.order.id = "bf090941d4f44867"}`
With the exact value, we can search fast (as long as the ID is rare).

* `{project, service, meta.order.id = "*abc*123*", meta.request.id = "c7438471-fc0f46b9bc68"}`
Here, we cannot search fast by `order.id`, but we can by `request.id`!

* `{project, service, geo.city = "very_small_city"}`
This also works for `labels`.

* `{project, service, geo.city = "very_small_city", meta.purchase_token = "f97b68f2450e43e4"}`
This query is even faster than the previous one because first we screened out some results by `geo.city`, and then some more by `purchase_token`.

* `{project, service, trace.id="00008dsf7d8df7d"}`
It also works for `trace.id` and `span.id`.

It is recommended to write high-cardinality values (including IDs) into metadata.
