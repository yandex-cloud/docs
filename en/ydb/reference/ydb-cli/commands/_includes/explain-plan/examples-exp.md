---
sourcePath: en/ydb/ydb-docs-core/en/core/reference/ydb-cli/commands/_includes/explain-plan/examples-exp.md
---
This query plan implies that a `FullScan` is made for the `seasons` table and multiple reads are made for the `series` table (the `MultiLookup` type) by the key `series_id` (lookup_by). The `MultiLookup` read type and the `lookup_by` section indicate that the `series` table is subject to multiple reads by the `series_id` key.

