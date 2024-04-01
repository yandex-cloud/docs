## Creating query templates using the mustache syntax {#templating}

You can use the templates of the computations exchanged between {{ jlab }} and {{ yq-name }} to work with queries or perform standard operations without writing code. To allow this, {{ yq-name }} has a built-in support for the [mustache syntax](https://mustache.github.io) to write queries, where all keywords and template directives are placed inside the `{{}}` key symbols. You can use the mustache syntax with [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/) or in a built-in mustache interpreter.

The {{ `yq-name` }} built-in mustache templates allow you to insert variables from the {{ jlab }} runtime environment directly into SQL queries. Such variables will also be automatically converted into the required {{ yq-name }} data structures. For example:

```python
myQuery = "select * from Departments"
%yq not_var{{myQuery}}
```

The `not_var{{myQuery}}` mustache string will indicate the name of the source variable for the text. Also, the `select * from Departments` text will be sent to {{ yq-name }} for execution.

Using mustache templates streamlines the integration between {{ jlab }} and {{ yq-name }}. Let's assume you have the `lst=["Academy", "Physics"]` Python list containing the names of departments whose data you want to process. Without the mustache syntax support in {{ yq-name }}, first, you would need to convert the Python list into a string and then input it into the SQL query. Query example:

```python
var lstStr = ",".join(lst)
sqlQuery = f'select "Academy" in ListCreate({lstStr});
%yq not_var{{sqlQuery}}
```

I.e., working with complex data types requires a detailed knowledge of the {{ yq-name }} SQL syntax. With the mustache syntax, you can write a much simpler query:

```sql
%yq select "Academy" in not_var{{lst}}
```

Here, `lst` will be identified as a Python list and automatically converted into its SQL equivalent. This is the final query that will be sent to {{ yq-name }}:

```sql
%yq select "Academy" in ListCreate("Academy", "Physics") as lst
```

### Jinja2 {#jinja2}

To perform standard tasks in {{ jlab }} and {{ yq-name }}, we recommend using the built-in mustache syntax. For more advanced templating, you can use Jinja2.

To install Jinja2, run this command:

```python
%pip install Jinja2
```

Example of using a Jinja template with the `for` cycle:

```python
{% for user in users %}
    command = "select * from users where name='not_var{{ user }}'"
{% endfor %}
```

You can also use Jinja templates to perform various data processing operations. This example illustrates operations performed on department names based on whether the student belongs to the department:

```python
{% if student.department == "Academy" %}
    not_var{{ student.department|upper }}
{% elif upper(student.department) != "MATHS DEPARTMENT" %}
    not_var{{ student.department|capitalize }}
{% endif %}
```

To make sure Jinja conversions comply with the {{ yq-name }} rules, use the `to_yq` filter. Here is what the `lst=["Academy", "Physics"]` Python list from the above example looks like in a Jinja template:

```sql
%%yq --jinja2
select "Academy" in not_var{{lst|to_yq}}
```

If you need to disable templating, use the `--no-var-expansion` argument:

```sql
%%yq --no-var-expansion
...
```

### Built-in mustache templates {#embedded_mustache}

In {{ yq-full-name }}, the built-in mustache templates are enabled by default and help to streamline basic operations with {{ jlab }} variables:

```python
lst=["Academy", "Physics"]
```

```sql
%yq select "Academy" in not_var{{lst}}
```

#### Using Pandas DataFrame variables {#capture-dataframe}

Example of using `yandex_query_magic` and the mustache syntax with [Pandas DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html):

1. Declare the variable in {{ jlab }}:

   ```python
   df = pandas.DataFrame({'_float': [1.0],
                       '_int': [1],
                       '_datetime': [pd.Timestamp('20180310')],
                       '_string': ['foo']})
   ```

You can use `df` as a variable in queries to {{ yq-full-name }}. During query execution, the `df` value is used to create a `df` temporary table. The table can be used within the {{ yq-full-name }} query that is currently running.

1. Get the data:

   ```sql
   %%yq
   SELECT
       *
   FROM mytable
   INNER JOIN not_var{{df}}
       ON mytable.id=df._int
   ```

Table of Pandas types mapping to {{ yq-name }} types:

| Pandas type | YQL type | Comment |
|-----|-----|-----|
| int64 | Int64 | Exceeding the `int64` limit will result in a query execution error. |
| float64 | Double |
| datetime64[ns] | Timestamp | Precision to the microsecond. Specifying nanoseconds ([in the `nanosecond` field](https://pandas.pydata.org/docs/user_guide/timeseries.html#time-date-components)) will return an exception. |
| str | String |

#### Using Python dict variables {#capture-dict}

Example of using `yandex_query_magic` and the mustache syntax with a Python dict:

1. Declare the variable in {{ jlab }}:

   ```python
   dct = {"a": "1", "b": "2", "c": "test", "d": "4"}
   ```

   Now you can use the `dct` variable in {{ yq-name }} queries. When executing a query, `dct` will convert into a mapping [YQL Dict](https://ydb.tech/docs/ru/yql/reference/builtins/dict) object:

   | Key | Value |
   |---|---|
   | a | "1" |
   | b | "2" |
   | c | "test" |
   | d | "4" |

1. Get the data:

   ```sql
   %%yq
   SELECT "a" in not_var{{dct}}
   ```

Table of Python dict types mapping to {{ yq-name }} types:

| Python type | YQL type | Comment |
|-----|-----|-----|
| int | Int64 | Exceeding the int64 limit will result in a query execution error. |
| float | Double |
| datetime | Timestamp |
| str | String |

You can also convert a dictionary into a [Pandas DataFrame](#capture-dataframe) table using a constructor:

```python
df = pandas.DataFrame(dct)
```

#### Using Python list variables {#capture-list}

Example of using `yandex_query_magic` and the mustache syntax with a Python list:

1. Declare the variable in {{ jlab }}:

   ```python
   lst = [1,2,3]
   ```

   Then, you can use the `lst` variable in {{ yq-name }} queries. When executing a query, `lst` will convert into a mapping [YQL Dict](https://ydb.tech/docs/ru/yql/reference/types/containers) object:

1. Get the data:

   ```sql
   %%yq
   SELECT 1 IN not_var{{lst}}
   ```

Table of Python list types mapping to {{ yq-name }} types:

| Python type | YQL type | Comment |
|-----|-----|-----|
| int | Int64 | Exceeding the int64 limit will result in a query execution error. |
| float | Double |
| datetime | Timestamp |
| str | String |

You can also convert a list into a [Pandas DataFrame](#capture-dataframe) table using a constructor:

```python
df = pandas.DataFrame(lst,
                      columns =['column1', 'column2', 'column3'])
```

### Jinja templates {#jinja}

Jinja templates provide a convenient way to generate SQL queries. They allow you to automatically insert various data, e.g, search conditions, so that you do not need to write each query manually. This streamlines work, prevents errors, and results in more readable code.

With Jinja templates, you can also automate generating queries that contain repeated elements. For example, you can use loops in your template to add a list of values to check in a query. This provides you with additional flexibility and enables you to write complex queries faster when you need to handle large amounts of data.

The steps below explain how to filter data in {{ yq-full-name }} using a Python variable.

1. Declare the variable in {{ jlab }}:

   ```python
   name = "John"
   ```

1. When running the following code in the {{ jlab }} cell, make sure to specify the `jinja2` flag before executing an SQL query for it to be interpreted as a [Jinja2 template](https://jinja.palletsprojects.com/en/):

   ```sql
   %%yq <other_parameters> --jinja2

   SELECT "not_var{{name}}"
   ```

   Parameters:

   * `--jinja2`: Enables query text rendering with [Jinja](https://jinja.palletsprojects.com/) templates. To use this parameter, you need to install the [Jinja2](https://pypi.org/project/Jinja2/) package (`%pip install Jinja2`).

#### `to_yq` filter {#to_yq}

Jinja2 is a general-purpose templating engine. When processing variable values, it uses a standard string representation of data types.

For example, you have a defined `lst=["Academy", "Physics"]` Python list. This is how you can use it in a Jinja template:

```sql
%%yq --jinja2
select "Academy" in not_var{{lst}}
```

This will result in the `Unexpected token '['` error. Jinja converts the `lst` variable to a `["Academy", "Physics"]` string according to Python rules but disregards the {{ yq-full-name }}-specific features of SQL queries, which causes the error.

To specify that Jinja conversions must comply with the {{ yq-full-name }} rules, use the `to_yq` filter. Then, the same query in the Jinja syntax will look like this:

```sql
%%yq --jinja2
select "Academy" in not_var{{lst|to_yq}}
```

The `to_yq` Jinja filter converts data to the {{ yq-full-name }} syntax in exactly the same manner as [built-in mustache templates](#embedded_mustache).

## Capture command results {#capture-command-result}

To capture a line magic command result, you can use the assignment command:

```
varname = %yq <query>
```

To capture a cell magic command result, you can specify the variable name and the `<<` operator at the beginning of the query text:

```
%%yq
varname << <query>
```

Then, you can use the result as a standard {{ jlab }} variable.

For example, this is how you capture a command result to `output` variables using cell magic:

```sql
output = %yq SELECT 1 as column1
```

And this is how you can capture a command result to a `output2` variable using line magic:

```sql
%%yq
output2 << SELECT 'Two' as column2, 3 as column3
```

Then, you can use these variables as standard IPython variables. For example, you can print them:

```python
output
```

By default, the `%yq` and `%%yq` commands output a [Pandas DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html) object with columns matching the column names from the SQL query and rows containing query results. To disable `Pandas DataFrame` conversion, you can use the [--raw-results argument](#usage).

The `output` variable in the above example will have the following structure:

|  | **column1** |
|---|----|
| **0** | 1 |

The `output2` variable will look like this:

|  | **column2** | **column3** |
|---|----|-----|
| **0** | Two | 3 |

If a query cannot return a result by its nature (e.g., `insert into table select * from another_table`), it will return the `None` value. If a query returns multiple sets of results, they will be displayed as a `list` of individual results.

When executing a query, `yandex_query_magic` outputs additional data, e.g., query ID, start time, and execution duration:

![jupyter_query_info](../../_assets/query/jupyter-query-info-progress-output.png)

To hide the execution progress information for a cell, you can use the additional `%%capture` command.

```
%%capture
%%yq
<query>
```

In this case, the execution progress will not be output to the console.
