# Getting a query plan and AST

To get a query plan and an abstract syntax tree (AST):

```bash
ydb -e <endpoint> -d <database> table query explain -q "SELECT season_id, episode_id, title FROM episodes WHERE series_id = 1 AND season_id > 1 ORDER BY season_id, episode_id LIMIT 3" --ast
```

Command results:

```bash
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

## Analyzing the query plan {#analysis}

The main section of the query plan, `tables`, contains information about querying tables. Reads are described in the `reads` section and writes in the `writes` section. The key characteristic of any table query is its type.

Types of reads:

* **FullScan**. Full table scan. All entries on all shards are read.
* **Scan**. A certain range of entries is read.
* **Lookup**. A read by key or key prefix.
* **MultiLookup**. Multiple reads by key or key prefix. Supported, for example, in JOINs.

Types of writes:

* **Upsert**. Add a single entry.
* **MultiUpsert**. Add multiple entries.
* **Erase**. A single delete by key.
* **MultiErase**. Multiple deletions.

Let's take the query plan from the example above.
The `lookup_by` parameter shows what columns (key or key prefix) reads are made by.
The `scan_by` parameter shows what columns a scan is made by, meaning reads of all entries in a certain range of values.
The `columns` parameter lists the columns whose values will be read from the table.
The `Query AST` section contains a view in the internal language called miniKQL. This information is required by YDB developers for query diagnostics.

## Example of query modification {#examples}

Let's say you only need to get the first seasons of all the series. Your query will then look like this:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table query explain -q "SELECT sa.title AS season_title, sr.title AS series_title, sr.series_id, sa.season_id FROM seasons AS sa INNER JOIN series AS sr ON sa.series_id = sr.series_id WHERE sa.season_id = 1"
```

Command results:

```bash
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

