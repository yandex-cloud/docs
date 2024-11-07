### Lack of resources or increasing data latency {#pod-restarted}

You may encounter the following problems when migrating data to a {{ CH }} target:

1. Transfer fails with an error. Error message:

    ```text
    pod instance restarted
    ```

1. [Transfer state monitoring](../../../../data-transfer/operations/monitoring.md) indicates an increasing data latency (a time difference between when the records appear in the target and when they appear in the source).

Possible cause:

The write interval specified in the target endpoint settings is too large, which leads to the lack of RAM (OOM) on the transfer VM.

**Solution**:

In the management console, set the value of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}** target endpoint setting to 10 seconds or less.

In addition, if your transfer type is {{ dt-type-copy }}, [reactivate](../../../../data-transfer/operations/transfer.md#activate) it. Transfers of the other types will restart automatically.
