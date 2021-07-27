---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Using the YDB console client

This section describes how to work with the database using the YDB console client (YDB CLI).

You'll learn what you need to get started with the YDB CLI, how to install it, and how to use it to perform a number of basic queries.

## Prerequisites {#requirements}

To successfully execute a command via the YDB CLI, you need:

* The `{{ ydb-cli }}` console client itself. For information about how to install it, see the [Installing the YDB CLI](#how-to-install) section below.
* A previously created DB (for information about how to create a DB, see [Quickstart - Creating a database](create-db.md)).
* The endpoint and full path to the database in {{ ydb-full-name }}. To find out the endpoint and path for your database:
    1. Go to the [{{ yandex-cloud }} console](https://console.cloud.yandex.ru/).
    1. Select the desired folder and go to {{ ydb-full-name }}.
    1. Select the database you want to query.
    1. In the menu on the left, go to the Overview section.
    1. The endpoint value is in the **Endpoint** line. Sample parameter value for a Dedicated database: `lb.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135`. Sample parameter value for a Serverless database: `ydb.serverless.yandexcloud.net:2135`. The endpoint default port is 2135, so you don't have to specify `:2135`.
    1. See the full database path in the **Database** line.  Sample parameter value: `/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj`.
* You can use one of the authentication methods described in [Authentication in the YDB CLI](#authentication).

## Installing the YDB CLI {#how-to-install}

{% list tabs %}

- Linux

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

  1. Run the command:

     ```
     curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
     ```

     The script will install the CLI and add the executable file path to the environment variable PATH.

  1. Restart your terminal for the changes to take effect.

- Windows

    For Windows, the CLI can be installed using PowerShell and `cmd`:

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

    The YDB CLI uses Unicode characters in the output of some commands. Most likely, to display these characters correctly in the Windows console, you'll need to switch the encoding to UTF-8 by running the command:

    ```
    chcp 65001
    ```

    {% endnote %}

{% endlist %}

### Authentication in the YDB CLI {#authentication}

To make queries to {{ ydb-full-name }} in {{ yandex-cloud }}, the console client needs to authenticate on behalf of the [IAM user](https://cloud.yandex.ru/docs/iam/concepts/). The console client can get the valid [IAM token](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) on its own in several ways or you can explicitly pass the [IAM token](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) that you obtained yourself to it. Below are all four possible authentication methods in the YDB CLI:

* Using the `--yc-token-file` option, you can specify the path to the file with the [user OAuth token](https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token). This is the easiest way. Instead of setting this option every time you call the `{{ ydb-cli }}` commands, you can save the **value** of the OAuth token to the `YC_TOKEN` environment variable.
* Using the `--iam-token-file` option, you can specify the path to the file with the [IAM token](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) that you obtained yourself. Also, instead of setting the option, you can save the **value of the** [IAM token](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) to the `IAM_TOKEN` environment variable.
* When using the `--use-metadata-credentials` option (with no value), the YDB CLI tries to get the [IAM token](https://cloud.yandex.ru/docs/iam/concepts/authorization/iam-token) through the [metadata service](https://cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm#auth-inside-vm) if working from a VM in {{ yandex-cloud }}. Also, instead of the option, you can set the environment variable `USE_METADATA_CREDENTIALS=1`.
* Using the `--sa-key-file` option, you can set the path to the file with [authorized access keys](https://cloud.yandex.ru/docs/iam/operations/authorized-key/create) of your service account. Alternatively, you can save this **file path** to the `SA_KEY_FILE` environment variable.

## Use examples

### Verifying authentication {#whoami}

It's often useful to find out how you introduce yourself to the database.

```bash
$ ydb -e <endpoint> -d <database> --yc-token-file <token file path> discovery whoami -g
User SID: aje6o75au36h5d0tnr8k@as

User has no groups
```

The `-e` and `-d` parameters are the **Endpoint** and **Database**, respectively. In the [Prerequisites](#requirements) section, you can find detailed instructions on how to do this.
The `-g` option also adds a list of groups that the user is in to the output.

{% note info %}

In this example, the token is passed via the `--yc-token-file` option. Save the **value** of the token to the YC_TOKEN environment variable to reduce the input text volume. For example, on Linux, you can run the `export YC_TOKEN=<token value>` command.

{% endnote %}

### Getting a list of DB endpoints {#discovery_list}

```bash
$ ydb -e <endpoint> -d <database> discovery list
grpcs://vm-etn01lrprvnlnhv8v5kj-ru-central1-a-abod.etn01lrprvnlnhv8v5kj.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

`#table_service`, `#scripting`, and others are services available on this endpoint.

### Listing objects at the specified path

If you don't specify the path, the DB root will be listed:

```bash
$ ydb -e <endpoint> -d <database> scheme ls
episodes  seasons  series  some_directory  .sys
```

You can view detailed information by adding the `-l` flag:

```bash
$ ydb -e <endpoint> -d <database> scheme ls -l
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

Let's create a tree like that from directories:

```bash
$ ydb -e <endpoint> -d <database> scheme mkdir some_directory
$ ydb -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory1
$ ydb -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory1/sub-directory1-1
$ ydb -e <endpoint> -d <database> scheme mkdir some_directory/sub-directory2
```

Now, using the `-R` option for the `scheme ls` command, we can get a recursive listing of all subdirectories and their objects at the specified path:

```bash
$ ydb -e <endpoint> -d <database> scheme ls some_directory  -lR
┌──────┬─────────────────────────┬──────┬─────────┬──────────┬─────────────────────────────────┐
| Type | Owner                   | Size | Created | Modified | Name                            |
├──────┼─────────────────────────┼──────┼─────────┼──────────┼─────────────────────────────────┤
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1                  |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory1/sub-directory1-1 |
| dir  | aje6o75au36h5d0tnr8k@as |      |         |          | sub-directory2                  |
└──────┴─────────────────────────┴──────┴─────────┴──────────┴─────────────────────────────────┘
```

### Getting detailed information about schema objects

Using the `episodes` table as an example.

```bash
$ ydb -e <endpoint> -d <database> scheme describe episodes --stats
┌────────────┬─────────┬────────┬─────┐
| Name       | Type    | Family | Key |
├────────────┼─────────┼────────┼─────┤
| air_date   | Uint64? |        |     |
| episode_id | Uint64? |        | K2  |
| season_id  | Uint64? |        | K1  |
| series_id  | Uint64? |        | K0  |
| title      | Utf8?   |        |     |
└────────────┴─────────┴────────┴─────┘

Storage settings:
Internal channel 0 commit log storage pool: ssd
Internal channel 1 commit log storage pool: ssd
Store large values in "external blobs": false

Column families:
┌─────────┬──────┬─────────────┬────────────────┐
| Name    | Data | Compression | Keep in memory |
├─────────┼──────┼─────────────┼────────────────┤
| default | ssd  | None        |                |
└─────────┴──────┴─────────────┴────────────────┘

Auto partitioning settings:
Partitioning by size: true
Partitioning by load: false
Preferred partition size (Mb): 2048

Table stats:
Partitions count: 1
Approximate number of rows: 70
Approximate size of table: 11.05 Kb
Last modified: Thu, 17 Sep 2020 10:02:41 UTC
Created: Thu, 17 Sep 2020 09:17:44 UTC
```

{% note info %}

You can create the `episodes`, `series`, and `seasons` tables from given examples yourself.
[Quickstart - Sample YQL queries](../quickstart/examples-yql.md) describes how you can query {{ ydb-full-name }} in the [{{ yandex-cloud }} console](https://console.cloud.yandex.ru/).
Creating all tables from the given examples is described in [YQL Tutorial - Creating a table](../yql/tutorial/create_demo_tables.md).
For populating tables with data — [YQL Tutorial - Adding data to a table](../yql/tutorial/fill_tables_with_data.md).

{% endnote %}

### Making a DB query

```bash
$ ydb -e <endpoint> -d <database> table query execute -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3"
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

### Streaming table reads

```bash
$ ydb -e <endpoint> -d <database> table readtable episodes --ordered --limit 5 --columns series_id,season_id,episode_id,title
┌───────────┬───────────┬────────────┬─────────────────────────────────┐
| series_id | season_id | episode_id | title                           |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [1u]       | ["Yesterday's Jam"]             |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [2u]       | ["Calamity Jen"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [3u]       | ["Fifty-Fifty"]                 |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [4u]       | ["The Red Door"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [5u]       | ["The Haunting of Bill Crouse"] |
└───────────┴───────────┴────────────┴─────────────────────────────────┘
```

`--limit`: Limit the number of entries to be read.
`--ordered`: Order read entries by key.
`--columns`: Columns whose values should be read (all by default) in CSV format.

To only get the number of read entries, use the `--count-only` parameter:

```bash
$ ydb -e <endpoint> -d <database> table readtable episodes --columns series_id --count-only
70
```

### Getting a query plan and AST {#explain_plan}

```bash
$ ydb -e <endpoint> -d <database> table query explain -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3" --ast
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/episodes",
            reads : [
                {
                    type : Lookup,
                    lookup_by : [
                        "series_id (\"1\")"
                    ],
                    scan_by : [
                        "season_id (\"1\", +inf]",
                        episode_id
                    ],
                    columns : [
                        episode_id,
                        season_id,
                        title
                    ]
                }
            ]
        }
    ]
}

Query AST:
(
(let $1 '('"/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/episodes" '"1" '"72075186224811560:11"))
(let $2 (Uint64 '"1"))
(let $3 '('"series_id" $2 $2))
(let $4 '('"season_id" $2 (Void)))
(let $5 '('"episode_id" (Void) (Void)))
(let $6 '('"ExcFrom" '"IncTo" $3 $4 $5))
(let $7 '('"episode_id" '"season_id" '"title"))
(let $8 (KiSelectRange '"db" $1 $6 $7 '('('"SkipNullKeys" '('"series_id" '"season_id")))))
(let $9 (Bool 'true))
(let $10 '($9 $9))
(let $11 (lambda '($15) '((Member $15 '"season_id") (Member $15 '"episode_id"))))
(let $12 (KiPartialSort $8 $10 $11))
(let $13 (Uint64 '"3"))
(let $14 (Sort (KiPartialTake $12 $13) $10 $11))
(return '('((Take $14 $13)) (List (ListType (VoidType)))))
)
```

##### Analyzing the query plan

The main section of the query plan, `tables`, contains information about querying tables. Reads are described in the `reads` section and writes in the `writes` section. The key characteristic of any table query is its type. Types of reads:

1. **FullScan**. Full table scan. All entries on all shards are read.
2. **Scan**. A certain range of entries is read.
3. **Lookup**. A read by key or key prefix.
4. **MultiLookup**. Multiple reads by key or key prefix. Supported, for example, in JOINs.

Types of writes:

1. **Upsert**. Add a single entry.
2. **MultiUpsert**. Add multiple entries.
3. **Erase**. A single delete by key.
4. **MultiErase**. Multiple deletions.

Let's take the query plan from the example above. The `lookup_by` parameter shows what columns (key or key prefix) reads are made by. The `scan_by` parameter shows what columns a scan is made by, meaning reads of all entries in a certain range of values. The `columns` parameter lists the columns whose values will be read from the table. The `Query AST` section contains a view in the internal language called miniKQL. This information is required by YDB developers for query diagnostics.

Let's look at another example. Let's say you only need to get the first seasons of all the series.

```bash
$ ydb -e <endpoint> -d <database> table query explain -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id FROM seasons AS sa INNER JOIN series AS sr ON sa.series_id = sr.series_id WHERE sa.season_id = 1"
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/seasons",
            reads : [
                {
                    type : FullScan,
                    scan_by : [
                        series_id,
                        season_id
                    ],
                    columns : [
                        season_id,
                        series_id,
                        title
                    ]
                }
            ]
        },
        {
            name : "/ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series",
            reads : [
                {
                    type : MultiLookup,
                    lookup_by : [
                        "series_id (expr)"
                    ],
                    columns : [
                        series_id,
                        title
                    ]
                }
            ]
        }
    ]
}
```

This query plan implies that a `FullScan` is made for the `seasons` table and multiple reads are made for the `series` table (the `MultiLookup` type) by the key `series_id` (lookup_by). The `MultiLookup` read type and the `lookup_by` section indicate that the `series` table is subject to multiple reads by the `series_id` key.

##### Running an operation to add a secondary index

YDB provides a mechanism of operations for time-consuming processes that don't require user intervention but are to undergo a client connectivity break.

```bash
$ ydb -e <endpoint> -d <database> table index add global --index-name title_index --columns title series
┌────────────────────────────────────────┬───────┬────────┐
| id                                     | ready | status |
├────────────────────────────────────────┼───────┼────────┤
| ydb://buildindex/7?id=1407375091598308 | false |        |
└────────────────────────────────────────┴───────┴────────┘
```

The command returned the ID of the build index operation. To get information about the progress of the operation, it should be polled on a regular basis with its progress and status returned as a result.
The progress field value is calculated as the percentage of shards in the source table that completed the data transfer.
The status field value is displayed when the operation is complete and indicates the result of the entire build operation.

The operation polling command looks like this:

```bash
$ ydb -e <endpoint> -d <database> operation get ydb://buildindex/7?id=1407375091598308
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘
```

View all build index operations for the DB:

```bash
$ ydb -e <endpoint> -d <database> operation list buildindex
┌────────────────────────────────────────┬───────┬─────────┬───────┬──────────┬───────────────────────────────────────────────────────────────┬─────────────┐
| id                                     | ready | status  | state | progress | table                                                         | index       |
├────────────────────────────────────────┼───────┼─────────┼───────┼──────────┼───────────────────────────────────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=1407375091598308 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1g4ej5ju4rf5kelpk4b/etn01lrprvnlnhv8v5kj/series | title_index |
└────────────────────────────────────────┴───────┴─────────┴───────┴──────────┴───────────────────────────────────────────────────────────────┴─────────────┘

Next page token: 0
```

You can cancel the build operation:

```bash
$ ydb -e <endpoint> -d <database> operation cancel ydb://buildindex/7?id=1407375091598308
```

After the operation is completed or canceled, it should be erased from the database:

```bash
$ ydb -e <endpoint> -d <database> operation forget ydb://buildindex/7?id=1407375091598308
```

#### Deleting an index

If you don't need an index, you can delete it. Deleting an index is a regular synchronous query. The result is returned as soon as the query is executed.

```bash
$ ydb -e <endpoint> -d <database> table index drop --index-name title_index series
```

## Structure of YDB CLI commands

You can always get a list of all available YDB CLI commands with a brief description of each of them by running the command:

```bash
$ ydb --help
YDB client

Usage: ydb [options...] <subcommand>

Subcommands:
ydb
├─ discovery                Discovery service operations
│  ├─ list                  List endpoints
│  └─ whoami                Who am I?
├─ export                   Export service operations
│  └─ s3                    Create export to S3
├─ operation                Operation service operations
│  ├─ cancel                Start cancellation of a long-running operation
│  ├─ forget                Forget long-running operation
│  ├─ get                   Check status for a given operation
│  └─ list                  List operations of specified kind
├─ scheme                   Scheme service operations
│  ├─ describe              Show information about object at given object
│  ├─ ls                    Show information about objects inside given directory
│  ├─ mkdir                 Make directory
│  ├─ permissions           Modify permissions
│  │  ├─ chown              Change owner
│  │  ├─ clear              Clear permissions
│  │  ├─ grant              Grant permission (aliases: add)
│  │  ├─ revoke             Revoke permission (aliases: remove)
│  │  └─ set                Set permissions
│  └─ rmdir                 Remove directory
├─ scripting                Scripting service operations
│  └─ yql                   Execute YQL script
├─ table                    Table service operations
│  ├─ attribute             Attribute operations (aliases: attr)
│  │  ├─ add                Add attributes to the specified table
│  │  └─ drop               Drop attributes from the specified table
│  ├─ drop                  Drop a table
│  ├─ index                 Index operations
│  │  ├─ add                Add index in to the specified table
│  │  │  └─ global          Add global index. The command returns operation
│  │  └─ drop               Drop index from the specified table
│  ├─ query                 Query operations
│  │  ├─ execute            Execute query (aliases: exec)
│  │  └─ explain            Explain query
│  ├─ readtable             Stream read table
│  └─ ttl                   Ttl operations
│     ├─ drop               Drop ttl settings from the specified table
│     └─ set                Set ttl settings for the specified table
├─ tools                    YDB tools service
│  ├─ copy                  Copy table(s)
│  ├─ dump                  Dump specified database directory or table into local directory
│  └─ restore               Restore database from local dump into specified directory
├─ update                   Update current YDB CLI binary if there is a newer version available
└─ version                  Print Yandex.Cloud YDB CLI version


Options:
  {-?|-h|--help}        print usage
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                        [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH  [Required] Database to work with
  {-v|--verbose}        Increase verbosity of operations (default: 0)
  --ca-file PATH        Path to a file containing the PEM encoding of the server root certificates for tls connections.
                        If this parameter is empty, the default roots will be used.
  --iam-token-file PATH IAM token file
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                          Token search order:
                            1. This option
                            2. "IAM_TOKEN" environment variable
  --yc-token-file PATH  YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                          For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                          Token search order:
                            1. This option
                            2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                        Use metadata service on a virtual machine to get credentials
                          For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                          Definition priority:
                            1. This option
                            2. "USE_METADATA_CREDENTIALS" environment variable (default: 0)
  --sa-key-file PATH    Security account key file
                          For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                          Definition priority:
                            1. This option
                            2. "SA_KEY_FILE" environment variable
```

You can also get a more detailed description for any of the subcommands with a list of available parameters:

```bash
$ ydb discovery whoami --help
Usage: ydb [global options...] discovery whoami [options...]

Description: Who am I?

Global options:
  {-e|--endpoint} [PROTOCOL://]HOST[:PORT]
                            [Required] Endpoint to connect. Protocols: grpc, grpcs (Default: grpcs).
  {-d|--database} PATH      [Required] Database to work with
  {-v|--verbose}            Increase verbosity of operations (default: 0)
  --ca-file PATH            Path to a file containing the PEM encoding of the server root certificates for tls connections.
                            If this parameter is empty, the default roots will be used.
  --iam-token-file PATH     IAM token file
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
                              Token search order:
                                1. This option
                                2. "IAM_TOKEN" environment variable
  --yc-token-file PATH      YC token file. It should contain OAuth token of a Yandex Passport user to get IAM token with.
                              For more info go to: cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
                              Token search order:
                                1. This option
                                2. "YC_TOKEN" environment variable
  --use-metadata-credentials
                            Use metadata service on a virtual machine to get credentials
                              For more info go to: cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
                              Definition priority:
                                1. This option
                                2. "USE_METADATA_CREDENTIALS" environment variable
                            Default: 0
  --sa-key-file PATH        Security account key file
                              For more info go to: cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
                              Definition priority:
                                1. This option
                                2. "SA_KEY_FILE" environment variable

Options:
  {-?|-h|--help}      print usage
  --client-timeout ms Operation client timeout
  {-g|--groups}       With groups (default: 0)
```

There are two types of passed parameters:

* Global: Parameters specified in the "root", that is, after `{{ ydb-cli }}`.
* Options of the subcommand itself are specified at the end.

