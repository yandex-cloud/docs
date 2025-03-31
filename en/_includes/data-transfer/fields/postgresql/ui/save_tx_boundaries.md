**{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}**: Enable so that the service writes data to the target database only after fully reading the transaction data from the source database.

We recommend enabling this setting for transfers from {{ PG }} to {{ PG }}. While it may slightly reduce transfer performance, it will prevent [errors](../../../../../data-transfer/operations/endpoint/target/postgresql.md#duplicate-key) related to exceeded limitations.


{% note warning %}

This feature is at the [Preview](../../../../../overview/concepts/launch-stages.md) stage.

{% endnote %}
