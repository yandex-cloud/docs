# Using a query plan

When you run a query, the YDB query optimizer tries to come up with an optimal plan for executing that query. To analyze and better understand how your queries work, you can get and analyze a query plan. You can get a query plan:

* Using the YDB CLI.
* In the management console.

In addition to the query plan, you can get an abstract syntax tree (AST). The AST section contains a view in the internal language called miniKQL. This information is required by YDB developers for query diagnostics.

## Getting a query plan

{% include [note_sample_tables](../_includes/note_sample_tables.md) %}

Get a plan for the following query:

{% include [select-from-series](../_includes/queries/select-from-series.md) %}

{% list tabs %}

- YDB CLI

  1. If you don't have the YDB CLI, [install and initialize it](../quickstart/examples-ydb-cli.md#requirements).

  2. To get a query plan, use the `explain` command. See how to use the command by running:

     ```bash
     ydb table query explain --help
     ```

  3. Run the command:

     ```bash
     ydb -e grpcs://<endpoint> -d <database> \
     table query explain -q "SELECT season_id, episode_id, title \
     FROM episodes \
     WHERE series_id = 1 AND season_id > 1 \
     ORDER BY season_id, episode_id LIMIT 3"
     ```

     Execution result:

     ```bash
     Query plan:
     {
         meta : {
             version : "0.1",
             type : query
         },
         tables : [
             {
                 name : "/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes",
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
     ```

  4. To get an abstract syntax tree, add the `--ast` flag at the end of the command:

     ```bash
     ydb -e grpcs://<endpoint> -d <database> \
     table query explain -q "SELECT season_id, episode_id, title \
     FROM episodes \
     WHERE series_id = 1 AND season_id > 1 \
     ORDER BY season_id, episode_id LIMIT 3" --ast
     ```

     This additionally displays the AST of the query:

     ```bash
     Query AST:
     (
     (let $1 '('"/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes" '"1" '"72075186234215788:16"))
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

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to use.

  1. In the list of services, select **Yandex Database**.

  2. On the **Databases** page, select the database that contains the `episodes` table.

  3. To open the DB root directory, go to the **Navigation** tab.

  4. To make a query to the database, click SQL query in the upper-right corner. The **Query** page opens.

  5. In the **Query** field, enter:

     {% include [select-from-series](../_includes/queries/select-from-series.md) %}

  6. To get a query plan, click ![image](../_assets/ydb_btn_select.png "Select") (next to the Query button) at the bottom of the window and choose **Explain**.

     This displays a field with the query plan:

     ```
     {
         "meta": {
             "type": "query",
             "version": "0.1"
         }
         "tables": [
             {
                 "name": "/ru-central1/b1gia87mbaomkfvsleds/etn008v5oqsj8joktlvd/episodes",
                 "reads": [
                     {
                         "columns": [
                             "episode_id",
                             "season_id",
                             "title"
                         ],
                         "lookup_by": [
                             "series_id (\"1\")"
                         ],
                         "scan_by": [
                             "season_id (\"1\", +inf]",
                             "episode_id"
                         ],
                         "type": "Lookup"
                     }
                 ]
             }
         ]
     }
     ```

{% endlist %}

## Analyzing the query plan

{% include [query explain](../_includes/query-explain.md) %}

