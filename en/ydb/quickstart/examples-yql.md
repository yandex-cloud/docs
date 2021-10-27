# Operations with data

After [creating a database](create-db.md), make basic YQL queries: create a table, work with the table data, and delete it. You can use the [management console]({{ link-console-main }}) or the [command-line interface (YDB CLI)](examples-ydb-cli.md).

{% note tip %}

For more information about YQL syntax, see the [YQL reference](../yql/reference/overview.md).

{% endnote %}

## Before you start { #before-work }

To efficiently work with the database using the YDB CLI:

1. [Install the YDB CLI](examples-ydb-cli.md#how-to-install) console client to work with {{ ydb-full-name }}.

1. To find out the endpoint and path for your database:

   {% list tabs %}
   - Management console

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

   - CLI

     {% if deploy != "arc" %}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% endif %}

     1. View a description of the command to get a list of databases:

        ```bash
        yc ydb database list --help
        ```

     1. To get a list of databases in the default folder, run the command:

        ```bash
        yc ydb database list
        ```

        As a result, the `ENDPOINT` column will show the `endpoint` and database.

        ```bash
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        |          ID          |   NAME   | DESCRIPTION |                    ENDPOINT                    |     CREATED AT      | STATUS  |
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        | etn008v5oqsj8joktlvd | ydb-test |             | grpcs://<YDB endpoint>/?database=<database> | 2020-12-09 11:46:45 | RUNNING |
        +----------------------+----------+-------------+------------------------------------------------+---------------------+---------+
        ```

      1. Save the `YDB endpoint` and database name specified in the `ENDPOINT` column. You'll need them for further queries.

   {% endlist %}

1. Check if incoming traffic through port 2135 is allowed. Make sure that the assigned {% if deploy != "arc" %}[security group](../../vpc/concepts/security-groups.md){%else%}security group{% endif %} contains the corresponding rule. If not, add it.

1. Use one of the authentication methods described in [Authentication in the YDB CLI](examples-ydb-cli.md#authentication).

    One of the easiest ways to authenticate is to save the {% if deploy != "arc" %}[OAuth token](../../iam/concepts/authorization/oauth-token.md){%else%}OAuth token{% endif %} value to the YC_TOKEN environment variable. To do this, run the command:

    ```bash
    export YC_TOKEN=<OAuth token>
    ```

## Creating a table {#create-table}

Create a new DB table using [CREATE TABLE](../yql/reference/syntax/create_table.md):

{% list tabs %}

- Management console

  {% include [create-schema-via-console](../_includes/create-schema-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

## Adding rows {#replace-data}

Add data to the table using [REPLACE INTO](../yql/reference/syntax/replace_into.md):

{% list tabs %}

- Management console

  {% include [replace-data-via-console](../_includes/replace-data-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

     This adds new rows to the `series` table. To see the result, you can [select rows](../quickstart/examples-yql.md#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Table preview](../_assets/db_ui_table_preview.png)

{% endif %}

## Replacing rows {#update-data}

Update the table data using [UPDATE](../yql/reference/syntax/update.md):

{% list tabs %}

- Management console

  {% include [update-data-via-console](../_includes/update-data-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

     To see the result, you can [select rows](../quickstart/examples-yql.md#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Update preview](../_assets/db_ui_run_update.png)

{% endif %}

## Deleting rows {#delete-data}

Delete data from the table using [DELETE](../yql/reference/syntax/delete.md):

{% list tabs %}

- Management console

  {% include [delete-data-via-console](../_includes/delete-data-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

     This command deletes the rows where `series_id` = 3. To see the result, you can [select rows](../quickstart/examples-yql.md#select-data) from the table.

{% endlist %}

{% if audience == "internal" %}

![Delete preview](../_assets/db_ui_run_delete.png)

{% endif %}

## Selecting rows {#select-data}

Select data from the table using [SELECT](../yql/reference/syntax/select.md):

{% list tabs %}

- Management console

  {% include [select-data-via-console](../_includes/select-data-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

## Deleting a table {#drop-table}

Delete a table using [DROP TABLE](../yql/reference/syntax/drop_table.md):

{% list tabs %}

- Management console

  {% include [drop-table-via-console](../_includes/drop-table-via-console.md) %}

- CLI

  1. If you don't have the YDB CLI yet, [install and initialize it](examples-ydb-cli.md#how-to-install).

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

