{{ yq-full-name }} is an interactive service for serverless data analysis. It allows you to process data from various storages using SQL queries without creating a dedicated data processing cluster. {{ yq-full-name}} works with [{{ objstorage-full-name }}](../../storage/), [{{ mpg-name }}](../../managed-postgresql/), and [{{ mch-name }}](../../managed-clickhouse/).

To analyze {{ ml-platform-name }} data using {{ yq-name }}:

1. [Install and configure the `yandex_query_magic` package](#setup-plugin).
1. [Create a query template](#templating).
1. [Process the execution results](#capture-command-result).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

Configure the infrastructure to work with {{ yq-full-name }}:
1. Go to the [management console]({{ link-console-main }}) and [link](../../billing/operations/pin-cloud.md) the billing account to the cloud.
1. [Create a folder](../../resource-manager/operations/folder/create.md) where {{ yq-full-name }} will run.

### Required paid resources {#paid-resources}

The cost of analyzing data using {{ yq-full-name }} includes:

* Fee for [{{ ml-platform-name }}](../../datasphere/pricing.md) computing resource usage.
* Fee for data read by [{{ yq-full-name }} when executing queries](../../query/pricing.md).

## Install and configure the yandex_query_magic package {#setup-plugin}

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Install the [`yandex_query_magic`](https://pypi.org/project/yandex-query-magic/) package by running this command in the notebook cell:

  ```python
  %pip install yandex_query_magic --upgrade
  ```

1. Configure the `yandex_query_magic` package. Do it by specifying the parameters using the `yq_settings` line command:

  ```python
  %yq_settings --folder-id <folder_ID> ...
  ```

  Available parameters:

  * `--folder-id <folder_id>`: ID of the folder used to run {{ yq-name }} queries.
  * `--env-auth <environment_variable>`: Sets authentication with the authorized key kept in the [{{ ml-platform-full-name }} secret](../../datasphere/concepts/secrets.md). [Create](../../datasphere/operations/data/secrets.md) a {{ ml-platform-name }} secret and specify its name in the `--env-auth` parameter.

### Test the package {#check-installation}

You can use the `%yq line magic` command with a single-line SQL query. In this case, the `%yq` keyword is used to execute the query.

Run the following commands in the notebook:

```python
%load_ext yandex_query_magic
%yq_settings --env-auth <{{ ml-platform-full-name }}_secret_name> --folder-id <folder_ID>
%yq SELECT "Hello, world!"
```

Where:

* `%yq`: "Magic" command name.
* `SELECT "Hello, world!"`: Text of query to {{ yq-name }}.

To send multi-line SQL queries, you need to use `%%yq cell magic`. The query text must begin with the `%%yq` keyword:

```sql
%%yq --folder-id <folder_ID> --name "My query"  --raw-results

SELECT
    col1,
    COUNT(*)
FROM table
GROUP BY col1
```

Where:

* `--folder-id`: ID of the folder used to run {{ yq-name }} queries. The default folder is the one specified earlier through `%yq_settings`. If not specified, it defaults to the folder in which the VM is running.
* `--name`: (Optional) Query name.
* `--description`: (Optional) Query description.
* `--raw-results`: (Optional) Returns raw results of {{ yq-name }} query processing. For the format specification, refer to [{#T}](../../query/api/yql-json-conversion-rules.md).

{% include [working_with_yq](../../_includes/query/magics.md)%}
