#### {{ dspm-name }} limits {#sd-dspm-limits}

Type of limit | Value    
--- | ---
Number of scanning sessions per folder | 10,000
Number of data sources per folder | 1,000
Number of files per bucket to scan | 500
Number of results per scanning session | 1,000
Number of results per file | 1,000
Number of results for a particular data type per file | 500

#### {{ cspm-name }} limits {#sd-cspm-limits}

Type of limit | Value
--- | ---
Number of [alerts](../../security-deck/concepts/alerts.md) per [alert sink](../../security-deck/concepts/workspace.md#alert-sinks) | 10,000
Maximum number of checks stored in [workspace](../../security-deck/concepts/workspace.md) at any given time^1^ | 100
Retention period for check results^1^ | 30 days

^1^ These limitations do not apply to the latest successful test.
