# {{ AF }}

To operate under the [{{ AF }}](https://airflow.apache.org) management, {{ yq-full-name }} provides the [apache-airflow-providers-yandex](https://pypi.org/project/apache-airflow-providers-yandex/) package. [{{ AF }} jobs](https://airflow.apache.org/docs/apache-airflow/stable/index.html) are Python applications consisting of [{{ AF }} operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html) and their [dependencies](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html), which decide the order of execution. To make queries to {{ yq-full-name }}, the package contains the [`YQExecuteQueryOperator`](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/_api/airflow/providers/yandex/operators/yq/index.html) {{ AF }} operator.

To run queries against {{ yq-full-name }}, you need to initialize `YQExecuteQueryOperator` using the arguments listed below.

Required arguments:
* `name`: {{ AF }} task name.
* `sql`: [SQL query](../concepts/glossary.md#query) to run against {{ yq-full-name }}.

Optional arguments:
* `folder_id`: Target folder for the query. If not specified, it defaults to the {{ maf-name }} folder.
* `yandex_conn_id`: Connection ID of type `yandexcloud`, containing the parameters for connecting to {{ yandex-cloud }}. If not specified, defaults to the `yandexcloud_default` connection. The `yandexcloud_default` connection comes preconfigured with {{ maf-short-name }}, so you do not need to create it manually.

Here is an example:

```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, world!'")
```

This example creates an {{ AF }} task with ID `yq_operator` that runs `SELECT 'Hello, world!'`. For a complete example of running a query in {{ yq-full-name }} from {{ maf-short-name }}, refer to [{#T}](../tutorials/airflow-auto-tasks.md).

## Return values {#ret_values}

A successful `YQExecuteQueryOperator` returns data as a `dict` that contains an array of column descriptions and an array of result rows.

Query:
```python
yq_operator = YQExecuteQueryOperator(task_id="yq_operator", sql="SELECT 'Hello, World!'")
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
| `columns` | Result column array |
| `columns[].name` | Column name |
| `columns[].type` | Column data type |
| `rows` | Result row array Each row array’s element count matches the number of columns in the `columns` field |

## YQL to Python type mapping

The following rules apply when converting YQL types to Python types.

### Scalar types {#scalars-types}

| YQL type | Python type | Python example |
| --- | --- | --- |
| `Int8`, `Int16`, `Int32`, `Uint8`, `Uint16`, `Uint32`, `Int64`, `Uint64` | `int` | `647713` |
| `Bool` | `bool` | True |
| `Float`, `Double` | `double`<br/>NaN and Inf become `None` | `7.88731023`<br/>`None` |
| `Decimal` | `Decimal` | `45.23410083` |
| `Utf8` | `str` | `String text` |
| `String` | `str` <br/> `bytes` | `String text` |

### Complex types {#complex-types}

| YQL type | Python type | Python example |
| --- | --- | --- |
| `Json`, `JsonDocument` | `str` (whole node serialized to a string) | `{"a":[1,2,3]}` |
| `Date`, `Datetime`, `Timestamp` | `datetime` | `2022-02-09` |

### Optional types {#optional-types}

| YQL type | Python type | Python example |
| --- | --- | --- |
| `Optional` | Original type or None | ```1``` |

### Containers {#containers}

| YQL type | Python type | Python example |
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


#### See also {#see-also}

* [{#T}](../tutorials/airflow-auto-tasks.md)
