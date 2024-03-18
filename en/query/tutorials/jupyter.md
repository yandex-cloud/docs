# Analyzing data with {{ jlab }}

{{ yq-full-name }} supports integration with [{{ jlab }}](https://jupyter.org) and [VSCode](https://code.visualstudio.com/docs/datascience/jupyter-notebooks) through the `cell` (`%%yq`) and `line` (`%yq`) Python magic commands. The integration allows you to streamline data collection and analysis, making the processes more efficient and straightforward.

![jupyter-screenshot](../../_assets/query/jupyter-screenshot.png)

To analyze {{ yq-name }} data with {{ jlab }}:

1. [Install and configure the {{ yq-name }} magic package](#setup-plugin).
1. [Create query templates](#templating).
1. [Capture command results](#capture-command-result).

## Getting started {#before-you-begin}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

1. [Get access](https://jupyter.org/install) to the {{ jlab }}Lab or {{ jlab }} Notebook environment.

## Install and configure the {{ yq-name }} magic package {#setup-plugin}

{% list tabs %}

- {{ jlab }}

   Install the [yandex_query_magic](https://pypi.org/project/yandex-query-magic/) package by running this command in the notebook cell:

   ```python
   %pip install yandex_query_magic --upgrade
   ```

- Shell

   1. Install the [yandex_query_magic](https://pypi.org/project/yandex-query-magic/) package using pip:

      ```shell
      pip install yandex_query_magic --upgrade
      ```

   1. Enable the {{ jlab }} extension for the {{ jlab }} Notebook UI controls:

      ```shell
      %jupyter contrib nbextension install --user
      ```

      If you get the `No module named 'notebook.base'` error, try upgrading to {{ jlab }} Notebook 6.4.12:

      ```shell
      pip install --upgrade notebook==6.4.12
      ```

{% endlist %}

### Configure the package {#global-settings}

To configure the `yandex_query_magic` package, you can use the `yq_settings` line command, where you need to specify the following arguments:

```shell
%yq_settings --folder-id <folder_ID> ...
```

Available parameters:

* `--folder-id <folder_ID>`: ID of the folder to execute {{ yq-name }} queries. The folder hosting a VM instance with {{ jlab }} is used by default.
* `--vm-auth`: Enables authentication with the VM account key. For more information, see [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).
* `--env-auth <environment_variable>`: Enables authentication with the authorized key contained in the environment variable. Use this mode when you cannot access the file system of the computer running {{ jlab }}. For example, when working in [{{ ml-platform-full-name }}](../../datasphere/concepts/index.md). In this case, create a [{{ ml-platform-name }} secret](../../datasphere/operations/data/secrets.md) and specify its name in the `--env-auth` parameter.
* `--sa-file-auth <authorized_key>`: Enables authentication with authorized keys. For more information, see [{#T}](../../iam/operations/authorized-key/create.md).

### Test the package {#check-installation}

You can use the `%yq line magic` command with single-line SQL queries. In this case, the `%yq` keyword is used to execute a query.

If {{ jlab }} is running on a VM with an [attached service account](../../compute/operations/vm-connect/auth-inside-vm), upload the extension to {{ jlab }}:

```sql
%load_ext yandex_query_magic
%yq SELECT "Hello, world!"
```

Where:

* `%yq`: {{ jlab }} magic name
* `SELECT "Hello, world!"`: {{ yq-name }} query text

If the VM does not have any attached service accounts:

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `yq.viewer` role.

1. [Create an authorized key](../../iam/operations/authorized-key/create.md) for the service account.

1. Run the following commands specifying the path to the authorized key file:

   ```sql
   %load_ext yandex_query_magic
   %yq_settings --sa-file-auth '<key_file_path>'
   %yq SELECT "Hello, world!"
   ```

   For example:

   ```sql
   %load_ext yandex_query_magic
   %yq_settings --sa-file-auth '/home/test/authorized_key.json'
   %yq SELECT "Hello, world!"
   ```

   The path to the `authorized_key.json` file is specified relative to the directory where the current {{ jlab }} Notebook file is saved.

To execute multi-line SQL queries, you need to use `%%yq cell magic`. The query text must begin with the `%%yq` keyword:

```sql
%%yq --folder-id <folder_ID> --name "My query" --description "Test query" --raw-results

SELECT
    col1,
    COUNT(*)
FROM table
GROUP BY col1
```

Where:

* `--folder-id`: ID of the folder to execute {{ yq-name }} queries. The default folder is the one specified earlier through `%yq_settings`. If not specified, it defaults to the folder in which the VM is running.
* `--name`: Query name.
* `--description`: Query description.
* `--raw-results`: Returns the unprocessed results of a {{ yq-name }} query. For format specifications, see [{#T}](../api/yql-json-conversion-rules.md).

## Create query templates using the mustache syntax {#templating}

You can use the templates of the computations exchanged between {{ jlab }} and {{ yq-name }} to work with queries or perform standard operations without writing code. To allow this, {{ yq-name }} has a built-in support for the [mustache syntax](https://mustache.github.io) to write queries, where all keywords and template directives are placed inside the `{{}}` symbols. You can use the mustache syntax with [Jinja2](https://jinja.palletsprojects.com/en/3.1.x/) or various types of tables.

The {{ yq-name }} built-in mustache templates allow you to insert variables from the {{ jlab }} runtime environment directly in SQL queries without converting them into SQL types. Such variables will also be automatically converted into the required {{ yq-name }} data structures. For example:

```python
myQuery = "select * from Departments"
%yq not_var{{myQuery}}
```

The `not_var{{myQuery}}` mustache string will indicate the name of the source variable for the text. Also, the `select * from Departments` text will be sent to {{ yq-name }} for execution.

Using mustache templates streamlines the integration between {{ jlab }} and {{ yq-name }}. Let's assume you have the `lst=["Academy", "Physics"]` Python list containing the names of departments whose data you want to process. Without the mustache syntax support in {{ yq-name }}, first, you would need to convert the Python list into a string and then input it into the SQL query. Sample query:

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
{% elif  upper(student.department) != "MATHS DEPARTMENT" %}
    not_var{{ student.department|capitalize }}
{% endif %}
```

For a robust Jinja2 integration, you need to cue it to {{ yq-name }}. To make sure Jinja conversions comply with the {{ yq-name }} rules, use the `to_yq` filter. Here is what the `lst=["Academy", "Physics"]` Python list from the above example looks like in a Jinja template:

```sql
%%yq --jinja2
select "Academy" in not_var{{lst|to_yq}}
```

If you need to disable templating, use the `--no-var-expansion` argument:

```sql
%%yq --no-var-expansion
...
```

### Using the mustache syntax with tables {#tables}

The mustache syntax allows you to streamline fetching data from tables. When executing a query, a variable takes the value of a temporary table. The table can be used within the {{ yq-name }} query that is currently running.

#### Using Pandas DataFrame variables {#capture-dataframe}

Example of using `yandex_query_magic` and the mustache syntax with [Pandas DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html):

1. Declare the variable in {{ jlab }}:

   ```python
   df = pandas.DataFrame({'_float': [1.0],
                       '_int': [1],
                       '_datetime': [pd.Timestamp('20180310')],
                       '_string': ['foo']})
   ```

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

## Capture command results {#capture-command-result}

To capture a command result to a variable, you can use the assignment command or the `<<` operator. Then, you can use the result as a standard {{ jlab }} variable.

* Using the assignment command:

   ```
   varname = %yq <query>
   ```

   For example:

   ```sql
   output = %yq SELECT 1 as column1
   output
   ```

   Result:

   | | **column1** |
   |---|---|
   | **0** | 1 |

* Using the `<<` operator:

   ```
   %%yq
   varname << <query>
   ```

   For example:

   ```sql
   %%yq
   output << SELECT 'Two' as column2, 3 as column3
   output
   ```

   Result:

   |  | **column2** | **column3** |
   |---|----|-----|
   | **0** | Two | 3 |

By default, the capture commands output a Pandas DataFrame object with columns matching the column names from the SQL query and rows containing query results. To disable Pandas DataFrame conversion, you can use the `--raw-results` argument.

If a query cannot return a result by its nature (e.g., `insert into table select * from another_table`), it will return the `None` value. If a query returns multiple sets of results, they will be displayed as a `list` of individual results.

When executing a query, `yandex_query_magic` outputs additional data, e.g., query ID, start time, and execution duration.

![](../../_assets/query/jupyter-query-info-progress-output.png)

To hide the execution progress information for a cell, you can use the additional `%%capture` command.
