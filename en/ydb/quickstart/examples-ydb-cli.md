# Using the YDB CLI

This section describes how to work with the database using the YDB command-line interface (YDB CLI). You'll learn what you need to get started with the YDB CLI, how to install it, and how to use it to perform a number of basic queries.

## Before you start {#before-you-begin}

To successfully run commands via the YDB CLI, you need:

* A database. If you don't have a DB, [create one](create-db.md) and [populate it with data](examples-yql.md).

* The endpoint and full path to the database in {{ ydb-full-name }}.

    {% cut "How to find out the endpoint and path for your database" %}

    To find out the endpoint and path for your database:
    1. Go to the [management console]({{ link-console-main }}).
    1. Select the folder and go to **{{ ydb-full-name }}**.
    1. Select the database you want to query.
    1. In the menu on the left, go to the **Overview** section.
    1. The endpoint value is in the **Endpoint** line.
        * Sample parameter value for a Dedicated database: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`.
        * Sample parameter value for a Serverless database: `ydb.serverless.yandexcloud.net:2135`.
The endpoint default port is `2135`, so you don't have to specify `:2135` in your query.
    1. See the full database path in the **Database** line.
Sample parameter value: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.

    {% endcut %}

* Permission to accept incoming traffic through port `2135`. Make sure that the assigned {% if deploy != "arc" %}[security group](../../vpc/concepts/security-groups.md){%else%}security group{% endif %} contains the corresponding rule. If not, add it.

## Installing the YDB CLI {#how-to-install}

{% list tabs %}

- Linux

  To install the YDB CLI:

  1. Run the command:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     The script will install the CLI and add the executable file path to the environment variable PATH.

     {% note info %}

     The script will update PATH only if you run it in the bash or zsh command shell.
If you run the script in a different shell, add the path to the CLI to the variable PATH yourself.

     {% endnote %}

  1. Restart your terminal.

- macOS

  To install the YDB CLI:

  1. Run the command:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     The script will install the CLI and add the executable file path to the environment variable PATH.

  1. Restart your terminal for the changes to take effect.

- Windows

    For Windows, you can install the YDB CLI using PowerShell or `cmd`:

    - To install using PowerShell:

        1. Run the command:

            ```
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
            ```

        1. The installation script will ask whether to add the path to `{{ ydb-cli }}` to the PATH variable:

            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`. After this, you can use the YDB CLI without restarting the command shell.

    - To install using `cmd`:

        1. Run the command:

            ```
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
            ```

        1. The installation script will ask whether to add the path to `{{ ydb-cli }}` to the PATH variable:

            ```
            Add ydb installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`.

        1. Restart your terminal for the changes to take effect.

        {% note info %}

        The YDB CLI uses Unicode characters in the output of some commands. If these characters aren't displayed correctly in the Windows console, switch the encoding to UTF-8 by running the command:

        ```
        chcp 65001
        ```

        {% endnote %}

{% endlist %}

## Authentication in the YDB CLI { #authentication }

To make queries to {{ ydb-full-name }} in {{ yandex-cloud }} using the YDB CLI, you need to authenticate. Choose one of the authentication methods listed below.

{% list tabs %}

- OAuth token

    In the `--yc-token-file` parameter, specify the path to the file with your {% if deploy != "arc" %}[OAuth token](../../iam/concepts/authorization/oauth-token.md){%else%}OAuth token{% endif %}.

    To avoid entering it every time you run `{{ ydb-cli }}` commands, save the OAuth token **value** to the `YC_TOKEN` environment variable.

- IAM token

    In the `--iam-token-file` parameter, specify the path to the file with your {% if deploy != "arc" %}[IAM token](../../iam/concepts/authorization/iam-token.md){%else%}IAM token{% endif %}.

    To avoid entering it every time you run `{{ ydb-cli }}` commands, save the **value of your** {% if deploy != "arc" %}[IAM token](../../iam/concepts/authorization/iam-token.md){%else%}IAM token{% endif %} to the `IAM_TOKEN` environment variable.

    {% note alert %}

    The validity period of an IAM token is 12 hours.

    {% endnote %}

- Metadata service

    Add the `--use-metadata-credentials` flag to the command and `{{ ydb-cli }}` will try to get your {% if deploy != "arc" %}[IAM token](../../iam/concepts/authorization/iam-token.md){%else%}IAM token{% endif %} via the {% if deploy != "arc" %}[metadata service](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md){%else%}metadata service{% endif %} if you're working from a VM in {{ yandex-cloud }}.

    Also, instead of the flag, you can set **1** in the environment variable: `USE_METADATA_CREDENTIALS=1`.

- Authorized access keys

    In the `--sa-key-file` parameter, specify the path to the file with {% if deploy != "arc" %}[authorized access keys](../../iam/operations/authorized-key/create.md){%else%}authorized access keys{% endif %} for your service account.

    Alternatively, you can save this **file path** to the `SA_KEY_FILE` environment variable.

{% endlist %}

### Verifying authentication {#whoami}

To verify that authentication is correct, you can use the request user information command:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> --yc-token-file <token file path> discovery whoami -g
```

Command parameters:

- `-e` and `-d` stand for the **Endpoint** and **Database**, respectively. See the [Prerequisites](#requirements) section for detailed instructions on how to get them.
- The `-g` option adds a list of groups that the user is in to the output.

Command results:

```bash
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

In this example, the token is passed via the `--yc-token-file` option. You can save the **value** of the token to the YC_TOKEN environment variable to reduce the input text volume.

To do this, run the command:

{% list tabs %}

- Linux/macOS

    ```bash
    export YC_TOKEN=<token value>
    ```

- Windows

    * For PowerShell:

        ```bash
        SET YC_TOKEN=<token value>
        ```

    * For `cmd`:

        ```bash
        $YC_TOKEN = “<token value>”
        ```

{% endlist %}

## Use cases {#examples}

### Getting a list of DB endpoints {#discovery_list}

To get a list of endpoints, run the command:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> discovery list
```

Command results:

```bash
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting`, and other gRPC services available on this endpoint.

### Making a DB query {#query}

To query data, run the command:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table query execute -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
```

Command results:

```bash
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

To have objects listed, use the `scheme ls <path>` subcommand. If you don't specify the path, the DB root will be listed:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> scheme ls
```

Command results:

```bash
episodes  seasons  series  some_directory  .sys
```

You can view detailed information by adding the `-l` flag:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> scheme ls -l
```

Command results:

```bash
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

{% note info %}

You can create the `episodes`, `series`, and `seasons` tables from given examples yourself.
[Quickstart - Sample YQL queries](examples-yql.md) describes how you can query {{ ydb-full-name }} in the [{{ yandex-cloud }} console](https://console.cloud.yandex.ru/).
Creating all tables from the given examples is described in [YQL Tutorial - Creating a table](../yql/tutorial/create_demo_tables.md).
For populating tables with data — [YQL Tutorial - Adding data to a table](../yql/tutorial/fill_tables_with_data.md).

{% endnote %}

Create a tree from directories:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> scheme mkdir some_directory
{{ ydb-cli }} -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory1
{{ ydb-cli }} -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory1/sub-directory1-1
{{ ydb-cli }} -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory2
```

Now, using the `-R` option for the `scheme ls` command, we can get a recursive listing of all subdirectories and their objects at the specified path:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> scheme ls some_directory -lR
```

Command results:

```bash
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```

#### What's next {#what-is-next}

See other examples of using the YDB CLI:

* [{#T}](../operations/ydb-cli/commands.md).
* [{#T}](../operations/ydb-cli/scheme-describe.md).
* [{#T}](../operations/ydb-cli/readtable.md).
* [{#T}](../operations/ydb-cli/operations-index.md).

