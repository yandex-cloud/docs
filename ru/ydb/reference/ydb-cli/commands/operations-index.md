---
sourcePath: overlay/reference/ydb-cli/commands/operations-index.md
---
{% include [intro.md](_includes/operations-index/intro.md) %}

{% include [operation-index.md](_includes/operations-index/operation-index.md %}

{% if audience == "external" %}

Результат:

```text
┌───────────────────────────────────────┬───────┬────────┐
| id                                    | ready | status |
├───────────────────────────────────────┼───────┼────────┤
| ydb://buildindex/7?id=562950460138467 | false |        |
└───────────────────────────────────────┴───────┴────────┘
```

{% endif %}

{% include [operations-index-exp.md](_includes/operations-index/operations-index-exp.md) %}

{% include [one-get.md](_includes/operations-index/one-get.md) %}

{% if audience == "external" %}

Результат:

```bash
┌──────────────────────────────────┬───────┬─────────┬───────┬──────────┬────────────────────────────────┬─────────────┐
| id                               | ready | status  | state | progress | table                          | index       |
├──────────────────────────────────┼───────┼─────────┼───────┼──────────┼────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=5629504601 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1gia87mbaomkfvsl | title_index |
| 38467                            |       |         |       |          | eds/etn02j1mlm4vgjhij03e/serie |             |
|                                  |       |         |       |          | s                              |             |
└──────────────────────────────────┴───────┴─────────┴───────┴──────────┴────────────────────────────────┴─────────────┘
```

{% endif %}

{% include [one-get-exp.md](_includes/operations-index/one-get-exp.md) %}

{% if audience == "external" %}

Результат:

```text
┌─────────────────────────────────┬───────┬─────────┬───────┬──────────┬─────────────────────────────────┬─────────────┐
| id                              | ready | status  | state | progress | table                           | index       |
├─────────────────────────────────┼───────┼─────────┼───────┼──────────┼─────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=562950460 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1gia87mbaomkfvsle | title_index |
| 138467                          |       |         |       |          | ds/etn02j1mlm4vgjhij03e/series  |             |
├─────────────────────────────────┼───────┼─────────┼───────┼──────────┼─────────────────────────────────┼─────────────┤
| ydb://buildindex/7?id=281475457 | true  | SUCCESS | Done  | 100.00%  | /ru-central1/b1gia87mbaomkfvsle | idname      |
| 674715                          |       |         |       |          | ds/etn02j1mlm4vgjhij03e/my_tabl |             |
|                                 |       |         |       |          | e                               |             |
└─────────────────────────────────┴───────┴─────────┴───────┴──────────┴─────────────────────────────────┴─────────────┘

Next page token: 0
```

{% endif %}

{% include [all-get.md](_includes/operations-index/all-get.md) %}

{% if audience == "external" %}

## Отмена операции построения индекса {#cancel}

Отмените операцию построения индекса:

```bash
ydb operation cancel ydb://buildindex/7?id=562950460138467
```

После того как операция завершена или отменена, удалите ее из базы:

```bash
ydb operation forget ydb://buildindex/7?id=562950460138467
```

{% endif %}

{% include [delete-index.md](_includes/operations-index/delete-index.md) %}
