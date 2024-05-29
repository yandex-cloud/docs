# {{ AF }}

To operate under the [{{ AF }}](https://airflow.apache.org) management, {{ yq-full-name }} provides the [apache-airflow-providers-yandex](https://pypi.org/project/apache-airflow-providers-yandex/) package. [{{ AF }} jobs](https://airflow.apache.org/docs/apache-airflow/stable/index.html) are Python applications consisting of [{{ AF }} operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html) and their [dependencies](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html), which decide the order of execution. To make queries to {{ yq-full-name }}, the package contains the [`YQExecuteQueryOperator`](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/_api/airflow/providers/yandex/operators/yq/index.html) {{ AF }} operator.

To make queries to {{ yq-full-name }}, you need to initialize the `YQExecuteQueryOperator` operator using the arguments shown below.

Required arguments:
* `name`: {{ AF }} job name.
* `sql`: Text of the [SQL query](../concepts/glossary#query) to run in {{ yq-full-name }}.

Optional arguments:
* `folder_id`: Folder to execute the query in. If omitted, it is the same as the {{ maf-name }} folder.
* `yandex_conn_id`: ID of the `yandexcloud`-type connection containing the {{ yandex-cloud }} connection parameters. If not specified, the connection named `yandexcloud_default` is used. The `yandexcloud_default` connection is pre-installed as part of {{ maf-short-name }}, so you do not need to create it.

Example:

```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, world!'")
```

In this example, we are creating an {{ AF }} job with the `yq_operator` ID, which runs the `SELECT 'Hello, world!'` query. For the full example of a query to {{ yq-full-name }} from {{ maf-short-name }}, see [{#T}](../tutorials/airflow.md).

## Returned values {#ret_values}

Successful `YQExecuteQueryOperator` execution outputs data in the form of a dictionary (`dict`) containing an array of column descriptions and an array of rows with the results.

Query:
```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, world!'")
```

Result:
```json
{
  'rows': [['Hello, world!']],
  'columns': [{'name': 'column0', 'type': 'String'}]
}
```

| Field | Description |
| ----- | ----- |
| `columns` | Array of returned value columns |
| `columns[].name` | Column name |
| `columns[].type` | Column data type |
| `rows` | Array of result rows with the returned value. The number of array elements of each row is the same as the number of columns from the `columns` parameter. |

## YQL and Python type mapping

Below are the rules for converting YQL types to Python results.

### Scalar types {#scalars-types}

| YQL type | Python type | Example in Python |
| --- | --- | --- |
| `Int8`, `Int16`, `Int32`, `Uint8`, `Uint16`, `Uint32`, `Int64`, `Uint64` | `int` | `647713` |
| `Bool` | `bool` | True |
| `Float`, `Double` | `double`<br/>NaN and Inf are represented as `None` | `7.88731023`<br/>`None` |
| `Decimal` | `Decimal` | `45.23410083` |
| `Utf8` | `str` | `String text` |
| `String` | `str` <br/> `bytes` | `String text` |

### Complex types {#complex-types}

| YQL type | Python type | Example in Python |
| --- | --- | --- |
| `Json`, `JsonDocument` | `str` (the entire node is inserted as a string) | `{"a":[1,2,3]}` |
| `Date`, `Datetime`, and `Timestamp` | `datetime` | `2022-02-09` |

### Optional types {#optional-types}

| YQL type | Python type | Example in Python |
| --- | --- | --- |
| `Optional` | Original type or None | ```1``` |

### Containers {#containers}

| YQL type | Python type | Example in Python |
| --- | --- | --- |
| `List<Type>` | `list` | `[1,2,3,4]` |
| `Dict<KeyType, ValueType>` | `dict` | ```{key1: value1, key2: value2}``` |
| `Set<KeyType>` | `set` | ```set(key_value1, key_value2)``` |
| `Tuple<Type1, Type2>` | `tuple` | ```(element1, element2, ..)``` |
| `Struct<Name:Utf8,Age:Int32>` | `dict` | `{ "Name": "John", "Age": 128 }` |
| `Variant<Type1, Type2>` with a tuple | `list` | ```list[64563, 1]``` |
| `Variant<value:Int32,error:String>` with a structure | `dict` | ```{key1: value1, key2: value2}``` |

### Special types {#special-types}

| YQL type | Python type |
| --- | --- |
| `Void`, `Null` | `None` |
| `EmptyList` | `[]` |
| `EmptyDict` | `{}` |


## See also {#see-also}

* [{#T}](../tutorials/airflow.md).
