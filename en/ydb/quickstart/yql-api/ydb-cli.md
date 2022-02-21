---
sourcePath: en/ydb/overlay/quickstart/yql-api/ydb-cli.md
---
# Working with the {{ ydb-short-name }} CLI

This section describes how to work with the database using the {{ ydb-short-name }} command-line interface (YDB CLI). You'll learn what you need to get started with the YDB CLI, how to install it, and how to execute a number of basic queries with it.

## Before you start {#before-you-begin}

1. [Install](../../../cli/quickstart.md#install) and [initialize](../../../cli/quickstart.md#initialize) the {{ yandex-cloud }} CLI.
1. Get the YDB endpoint and the full path to the [created database](../create-db.md).

{% cut "How to get the YDB endpoint and the path to the database" %}

{% include [ydb-endpoint](../../_includes/ydb-endpoint.md) %}

{% endcut %}

{% note info %}

When using a non-standard DB configuration, you may need to explicitly allow incoming traffic through port `2135`. Make sure that the assigned [security group](../../../vpc/concepts/security-groups.md) contains the corresponding rule. If not, add it.

{% endnote %}

## Installing the {{ ydb-short-name }} CLI {#how-to-install}

{% include [ydb-cli-install](../../reference/ydb-cli/install.md) %}

## Setting up authorization {#iam}

In this tutorial, authorization in {{ ydb-short-name }} is performed using an [IAM token](../../../iam/concepts/authorization/iam-token.md). For information about other authorization methods, see [{#T}](../../reference/ydb-cli/authorization.md).

1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md):

    ```bash
    yc iam create-token
    ```

1. Save the received token to a file (such as `iam-token.txt`). You'll need it in the next step.

    {% note alert %}

    The maximum lifetime of an IAM token is 12 hours.

    {% endnote %}

1. Check that the authorization is correct by requesting user information:

    ```bash
    {{ ydb-cli }} \
      --endpoint <endpoint> \
      --database <database> \
      --iam-token-file <path> \
      discovery whoami \
      --groups
    ```

    * `--endpoint`: DB endpoint.
    * `--database`: Full DB path.
    * `--iam-token-file`: Path to the IAM token file.
    * `--groups`: Add a list of groups that the user is in to the output.

    Command example:

    ```bash
    {{ ydb-cli }} \
      --endpoint ydb.serverless.yandexcloud.net:2135 \
      --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
      --iam-token-file iam-token.txt \
      discovery whoami \
      --groups
    ```

    Result example:

    ```text
    User SID: aje6o75au36h5d0tnr8k@as
    
    User has no groups
    ```

## Use cases {#examples}

To avoid specifying the endpoint, full DB path, and authorization parameters each time you run {{ ydb-short-name }} CLI commands, configure a [profile](../../reference/ydb-cli/profile/create.md) for the {{ ydb-short-name }} CLI.

### Creating a table {#create-table}

Add data to the table using the [CREATE TABLE](../../yql/reference/syntax/create_table.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
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

View the result:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scheme ls -l
```

Result:

```text
┌───────┬─────────────────────────┬──────┬───────────────────────────────┬──────────┬──────────────┐
| Type  | Owner                   | Size | Created                       | Modified | Name         |
├───────┼─────────────────────────┼──────┼───────────────────────────────┼──────────┼──────────────┤
| table | ajevsalaghmdvtfjgm29@as | 0 b  | Thu, 17 Jun 2021 11:00:28 UTC | Unknown  | series       |
| dir   |                         |      |                               |          | .sys         |
└───────┴─────────────────────────┴──────┴───────────────────────────────┴──────────┴──────────────┘
```

### Adding data {#replace-data}

Add data to the table using the [REPLACE INTO](../../yql/reference/syntax/replace_into.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
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

As a result, new rows are added to the `series` table. To view the result, [request](#select-data) data from the table.

### Updating data {#update-data}

Update data using the [UPDATE](../../yql/reference/syntax/update.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'UPDATE series
  SET series_info="Fake series updated"
  WHERE series_id = 3;'
```

To view the result, [request](#select-data) data from the table.

### Deleting data {#delete-data}

Delete data from the table using the [DELETE](../../yql/reference/syntax/delete.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'DELETE
  FROM series
  WHERE series_id = 3;'
```

This command deletes the records where `series_id` = 3. To view the result, [request](#select-data) data from the table.

### Data query {#select-data}

Query data from the table using the [SELECT](../../yql/reference/syntax/select.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'SELECT series_id, title AS series_title,
  CAST (release_date AS Date) AS release_date
  FROM series;'
```

Result:

```text
┌───────────┬──────────────────┬──────────────┐
| series_id | series_title     | release_date |
├───────────┼──────────────────┼──────────────┤
| 1         | "IT Crowd"       | "2006-02-03" |
├───────────┼──────────────────┼──────────────┤
| 2         | "Silicon Valley" | "2014-04-06" |
└───────────┴──────────────────┴──────────────┘
```

### Deleting a table {#drop-table}

Delete a table using the [DROP TABLE](../../yql/reference/syntax/drop_table.md) instruction:

```bash
{{ ydb-cli }} \
  --endpoint ydb.serverless.yandexcloud.net:2135 \
  --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
  --iam-token-file iam-token.txt \
  scripting yql -s \
  'DROP TABLE series;'
```

The table is deleted.
