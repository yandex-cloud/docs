{% include [intro.md](_includes/explain-plan/intro.md) %}

Result:

```text
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "{{ cloud-bases-path }}/episodes",
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

{% include [intro-exp.md](_includes/explain-plan/intro-exp.md) %}

{% include [examples.md](_includes/explain-plan/examples.md) %}

Result:

```text
Query plan:
{
    meta : {
        version : "0.1",
        type : query
    },
    tables : [
        {
            name : "/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/seasons",
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
            name : "/ru-central1/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e/series",
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

{% include [examples-exp.md](_includes/explain-plan/examples-exp.md) %}
