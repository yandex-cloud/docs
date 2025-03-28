# Analyzing data with {{ jlab }}

{{ yq-full-name }} supports integration with [{{ jlab }}](https://jupyter.org) and [VSCode](https://code.visualstudio.com/docs/datascience/jupyter-notebooks) through the `cell` (`%%yq`) and `line` (`%yq`) Python magic commands. The integration allows you to streamline data collection and analysis for a more efficient and straightforward workflow.

![jupyter-screenshot](../../_assets/query/jupyter-screenshot.png)

To analyze {{ yq-name }} data with {{ jlab }}:

1. [Install and configure the `yandex_query_magic` package](#setup-plugin).
1. [Try creating query templates](#templating).
1. [Process the execution results](#capture-command-result).

## Getting started {#before-you-begin}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

1. [Get access](https://jupyter.org/install) to the {{ jlab }}Lab or {{ jlab }} Notebook environment.

## Installing and configuring the yandex_query_magic package {#setup-plugin}

{% list tabs %}

- {{ jlab }}

  Install the [`yandex_query_magic`](https://pypi.org/project/yandex-query-magic/) package by running this command in the notebook cell:

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

     If you get the `"No module named 'notebook.base'"` error, try upgrading to {{ jlab }} Notebook 6.4.12:

     ```shell
     pip install --upgrade notebook==6.4.12
     ```

{% endlist %}

### Configuring the package {#global-settings}

To configure the `yandex_query_magic` package, you can use the `yq_settings` line command with the following arguments specified:

```shell
%yq_settings --folder-id <folder_ID> ...
```

Available parameters:

* `--folder-id <folder_id>`: ID of the folder used to run {{ yq-name }} queries. The folder hosting a VM instance with {{ jlab }} is used by default.
* `--vm-auth`: Authentication with the VM account key. For more information, see [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).
* `--env-auth <environment_variable>`: Authentication with the authorized key kept in the environment variable. Use this mode when you cannot access the file system of the computer running {{ jlab }}. For example, in [{{ ml-platform-full-name }}](../../datasphere/concepts/index.md). In which case create a [{{ ml-platform-name }} secret](../../datasphere/operations/data/secrets.md) and specify its name in the `--env-auth` parameter.
* `--sa-file-auth <authorized_key>`: Authentication with authorized keys. For more information, see [{#T}](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key).

### Testing the package {#check-installation}

You can use the `%yq line magic` command with a single-line SQL query. In this case, the `%yq` keyword is used to execute the query.

If {{ jlab }} is running on a VM with an [attached service account](../../compute/operations/vm-connect/auth-inside-vm), upload the extension to {{ jlab }}:

```sql
%load_ext yandex_query_magic
%yq SELECT "Hello, world!"
```

Where:

* `%yq`: {{ jlab }} magic name.
* `SELECT "Hello, world!"`: Text of query to {{ yq-name }}.

If the VM does not have any attached service accounts:

1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `yq.viewer` role to it.

1. [Create an authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the service account.

1. Run the following commands specifying the path to the authorized key file:

    ```sql
    %load_ext yandex_query_magic
    %yq_settings --sa-file-auth '<path_to_key_file>'
    %yq SELECT "Hello, world!"
    ```

    Here is an example:

    ```sql
    %load_ext yandex_query_magic
    %yq_settings --sa-file-auth '/home/test/authorized_key.json'
    %yq SELECT "Hello, world!"
    ```

    The path to the `authorized_key.json` file is specified relative to the directory the current {{ jlab }} Notebook file is saved in.

To send multi-line SQL queries, you need to use `%%yq cell magic`. The query text must begin with the `%%yq` keyword:

```sql
%%yq --folder-id <folder_ID> --name "My query" --description "Test query" --raw-results

SELECT
    col1,
    COUNT(*)
FROM table
GROUP BY col1
```

Where:

* `--folder-id`: ID of the folder used to run {{ yq-name }} queries. The default folder is the one specified earlier through `%yq_settings`. If not specified, it defaults to the folder in which the VM is running.
* `--name`: Query name.
* `--description`: Query description.
* `--raw-results`: Returns the unprocessed results of a query run in {{ yq-name }}. For the format specification, refer to [{#T}](../../query/api/yql-json-conversion-rules.md).

{% include [working_with_yq](../../_includes/query/magics.md)%}
