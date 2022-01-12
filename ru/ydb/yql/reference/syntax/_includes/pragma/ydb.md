---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/pragma/ydb.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/pragma/ydb.md
---

{% if tech %}

## YDB

### `kikimr.IsolationLevel`

| Тип значения | По умолчанию |
| --- | --- |
| Serializable, ReadCommitted, ReadUncommitted или ReadStale. | Serializable |

Экспериментальная pragma, позволяет ослабить уровень изоляции текущей транзакции в YDB.

{% endif %}