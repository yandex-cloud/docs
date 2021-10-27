# Working with the {{ ydb-short-name }} CLI

This section describes how to work with the database using the {{ ydb-short-name }} command-line interface (YDB CLI). You'll learn what you need to get started with the YDB CLI, how to install it, and how to use it to perform a number of basic queries.

## Before you start {#before-you-begin}

1. Prepare the endpoint and the full path of the [created database](../create-db.md).

    {% cut "How to find out the endpoint and path for your database" %}

    {% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

    {% endcut %}

1. Allow incoming traffic through port `2135`. Make sure that the assigned {% if deploy != "arc" %}[security group](../../../vpc/concepts/security-groups.md){%else%}security group{% endif %} contains the corresponding rule. If not, add it.

## Installing the {{ ydb-short-name }} CLI {#how-to-install}

{% list tabs %}

- Linux

    To install the {{ ydb-short-name }} CLI, run the command:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    The script will install the CLI and add the executable file path to the environment variable `PATH`.

    {% note info %}

    The script will update `PATH` only if you run it in the bash or zsh command shell. If you run the script in a different shell, add the CLI path to the `PATH` variable yourself.

    {% endnote %}

    Restart your terminal for the changes to take effect.

- macOS

    To install the {{ ydb-short-name }} CLI, run the command:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    The script will install the CLI and add the executable file path to the environment variable `PATH`.

    Restart your terminal for the changes to take effect.

- Windows

    For Windows, you can install the {{ ydb-short-name }} CLI using PowerShell or cmd:

    * To install using PowerShell:

        1. Run the command:

            ```powershell
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
            ```

        1. The installation script will ask whether to add the path to {{ ydb-cli }}`` to the PATH variable:

            ```text
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`. After this, you can use the {{ ydb-short-name }} CLI without restarting the command shell.

    * To install using cmd:

        1. Run the command:

            ```cmd
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
            ```

        1. The installation script will ask whether to add the path to {{ ydb-cli }}`` to the PATH variable:

            ```text
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`.

        1. Restart your terminal for the changes to take effect.

        {% note info %}

        The {{ ydb-short-name }} CLI uses Unicode characters in the output of some commands. If these characters aren't displayed correctly in the Windows console, switch the encoding to UTF-8 by running the command:

        ```cmd
        chcp 65001
        ```

        {% endnote %}

{% endlist %}

## Authentication in the {{ ydb-short-name }} CLI { #authentication }

To make queries to {{ ydb-full-name }} in {{ yandex-cloud }} using the {{ ydb-short-name }} CLI, you need to authenticate. Choose one of the authentication methods listed below.

{% list tabs %}

- OAuth token

    In the `--yc-token-file` parameter, specify the path to the file with your {% if deploy != "arc" %}[OAuth token](../../../iam/concepts/authorization/oauth-token.md){%else%}OAuth token{% endif %}.

    To avoid entering it every time you run {{ ydb-cli }} commands, save the OAuth token value to the `YC_TOKEN` environment variable.

- IAM token

    In the `--iam-token-file` parameter, specify the path to the file with your {% if deploy != "arc" %}[IAM token](../../../iam/concepts/authorization/iam-token.md){%else%}IAM token{% endif %}.

    To avoid entering it every time you run {{ ydb-cli }} commands, save the IAM token value to the `IAM_TOKEN` environment variable.

    {% note alert %}

    The validity period of an IAM token is 12 hours.

    {% endnote %}

- Metadata service

    Add the `--use-metadata-credentials` flag to the command and {{ ydb-cli }} will try to get your {% if deploy != "arc" %}[IAM token](../../../iam/concepts/authorization/iam-token.md){%else%}IAM token{% endif %} via the {% if deploy != "arc" %}[metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md){%else%}metadata service{% endif %} if you're working from a VM in {{ yandex-cloud }}.

    Also, instead of the flag, you can set `1` in the `USE_METADATA_CREDENTIALS` environment variable.

- Authorized access keys

    In the `--sa-key-file` parameter, specify the path to the file with {% if deploy != "arc" %}[authorized access keys](../../../iam/operations/authorized-key/create.md){%else%}authorized access keys{% endif %} for your service account.

    Also, instead of the flag, you can save this file path to the `SA_KEY_FILE` environment variable.

{% endlist %}

### Verifying authentication {#whoami}

To verify that authentication is correct, you can use the request user information command:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  --yc-token-file <token file path> \
  discovery whoami \
  --groups \
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.
* `--yc-token-file`: OAuth token path.
* `--groups`: Add a list of groups that the user is in to the output.

Execution result:

```text
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

In this example, the token is passed via the `--yc-token-file` option. To save the value of the token to the `YC_TOKEN` environment variable, run the command:

{% list tabs %}

- Linux/macOS

  ```bash
  export YC_TOKEN=<token value>
  ```

- Windows

  * For PowerShell:

      ```powershell
      SET YC_TOKEN=<token value>
      ```

  * For cmd:

      ```cmd
      $YC_TOKEN = “<token value>”
      ```

{% endlist %}

## Use cases {#examples}

### Creating a table {#create-table}

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To create a table, run the query:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'CREATE TABLE series
     (
         series_id Uint64,
         title Utf8,
         series_info Utf8,
         release_date Uint64,
         PRIMARY KEY (series_id)
     );'
     ```

  1. See the result by running the command:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scheme ls -l
     ```

     Result:

     ```bash
     ┌───────┬─────────────────┬──────┬───────────────────────────────┬──────────┬─────────────┐
     | Type  | Owner           | Size | Created                       | Modified | Name        |
     ├───────┼─────────────────┼──────┼───────────────────────────────┼──────────┼─────────────┤
     | table | ajehdq76s7o8ike | 0 b  | Wed, 09 Dec 2020 14:53:25 MSK | Unknown  | series      |
     | dir   |                 |      |                               |          | .sys        |
     └───────┴─────────────────┴──────┴───────────────────────────────┴──────────┴─────────────┘
     ```

{% endlist %}

### Adding rows {#replace-data}

Add data to the table using the [REPLACE INTO](../../yql/reference/syntax/replace_into.md) statement:

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To add data to the table, run the command:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'REPLACE INTO series (series_id, title, release_date, series_info)
     VALUES
     (
         1,
         "IT Crowd",
         CAST(Date("2006-02-03") AS Uint64),
         "The IT Crowd is a British sitcom."
     ),
     (
         2,
         "Silicon Valley",
         CAST(Date("2014-04-06") AS Uint64),
         "Silicon Valley is an American comedy television series."
     ),
     (
         3,
         "Fake series",
         CAST(Date("2018-09-11") AS Uint64),
         "Fake series for testing purposes."
     );'
     ```

     This adds new rows to the `series` table. To see the result, you can [select rows](#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Table preview](../_assets/db_ui_table_preview.png)

{% endif %}

### Replacing rows {#update-data}

Update the existing data in the table using the [UPDATE](../../yql/reference/syntax/update.md) operator:

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To update the data in the `series` table, run the command:

     ```bash
    ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'UPDATE series
     SET series_info="Fake series updated"
     WHERE series_id = 3;'
     ```

     To see the result, you can [select rows](#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Update preview](../_assets/db_ui_run_update.png)

{% endif %}

### Deleting rows {#delete-data}

Delete data from the table using the [DELETE](../../yql/reference/syntax/delete.md) operator:

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To delete the data from the `series` table, run the command:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'DELETE
     FROM series
     WHERE series_id = 3;'
     ```

     This command deletes the rows where `series_id` = 3. To see the result, you can [select rows](#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Delete preview](../_assets/db_ui_run_delete.png)

{% endif %}

### Data query {#select-data}

Query data from the table using the [SELECT](../../yql/reference/syntax/select.md) operator:

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To select data from the `series` table, run the command:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'SELECT series_id,
     title AS series_title,
     CAST (release_date AS Date) AS release_date
     FROM series;'
     ```

     As a result, the following table data is displayed:

     ```bash
     ┌───────────┬──────────────────┬──────────────┐
     | series_id | series_title     | release_date |
     ├───────────┼──────────────────┼──────────────┤
     | 1         | "IT Crowd"       | "2006-02-03" |
     ├───────────┼──────────────────┼──────────────┤
     | 2         | "Silicon Valley" | "2014-04-06" |
     └───────────┴──────────────────┴──────────────┘
     ```

{% endlist %}

{% if audience == "internal" %}

![Select from table](../_assets/db_ui_run_select.png)

{% endif %}

### Deleting a table {#drop-table}

Delete the table using the [DROP TABLE](../../yql/reference/syntax/drop_table.md) statement:

{% list tabs %}

- CLI

  1. View a description of the run YQL query command:

     ```bash
     ydb scripting yql --help
     ```

  1. To delete the `series` table, run the command:

     ```bash
     ydb -e grpcs://<YDB endpoint> -d <database> \
     scripting yql -s \
     'DROP TABLE series;'
     ```

     The table is deleted.

{% endlist %}

### Getting a list of DB endpoints {#discovery_list}

To get a list of endpoints, run the command:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  discovery list
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.

Execution result:

```text
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting`, and other gRPC services available on this endpoint.

### Making a DB query {#query}

Run the data query:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  table query execute \
  --query "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.
* `--query`: Query text.

Execution result:

```text
┌───────────┬────────────┬────────────────────────────────┐
| season_id | episode_id | title                          |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [1u]       | ["The Work Outing"]            |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [2u]       | ["Return of the Golden Child"] |
├───────────┼────────────┼────────────────────────────────┤
| [2u]      | [3u]       | ["Moss and the German"]        |
└───────────┴────────────┴────────────────────────────────┘
```

### Listing objects {#listing}

|||UNTRANSLATED_CONTENT_START|||Листинг объектов производится подкомандой `scheme ls <path>`.|||UNTRANSLATED_CONTENT_END||| If you don't specify the path, the DB root will be listed:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme ls
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.

Execution result:

```text
episodes  seasons  series  some_directory  .sys
```

To view detailed information, add the `-l` flag:

```bash
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme ls \
  -l
```

Execution result:

```text
┌───────┬─────────────────────────┬─────────┬───────────────────────────────┬───────────────────────────────┬────────────────┐
| Type  | Owner                   | Size    | Created                       | Modified                      | Name           |
├───────┼─────────────────────────┼─────────┼───────────────────────────────┼───────────────────────────────┼────────────────┤
| table | aje6o75au36h5d0tnr8k@as | 1.13 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:24:31 UTC | episodes       |
| table | aje6o75au36h5d0tnr8k@as | 1.45 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:20:07 UTC | seasons        |
| table | aje6o75au36h5d0tnr8k@as | 1.12 Kb | Thu, 17 Sep 2020 09:17:44 UTC | Thu, 17 Sep 2020 09:19:46 UTC | series         |
| dir   | aje6o75au36h5d0tnr8k@as |         |                               |                               | some_directory |
| dir   |                         |         |                               |                               | .sys           |
└───────┴─────────────────────────┴─────────┴───────────────────────────────┴───────────────────────────────┴────────────────┘
```

### Working with directories {#directory}

Create a tree from directories:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme mkdir some_directory
```

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme mkdir some_directory/sub-directory1
```

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme mkdir some_directory/sub-directory1/sub-directory1-1
```

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme mkdir some_directory/sub-directory2
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.

To view a recursive listing of all subdirectories and their objects at the specified path, use the `-R` option for the `scheme ls` subcommand:

```bash
{{ ydb-cli }} \
  --endpoint <YDB endpoint> \
  --database <database> \
  scheme ls some_directory \
  -lR
```

Where:

* `--endpoint`: DB endpoint.
* `--database`: Full DB path.

Execution result:

```text
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```

#### What's next {#what-is-next}

See other examples of using the {{ ydb-short-name }} CLI:

* [{#T}](../../operations/ydb-cli/commands.md).
* [{#T}](../../operations/ydb-cli/scheme-describe.md).
* [{#T}](../../operations/ydb-cli/readtable.md).
* [{#T}](../../operations/ydb-cli/operations-index.md).

