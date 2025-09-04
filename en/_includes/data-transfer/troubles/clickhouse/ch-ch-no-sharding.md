### Sharding is not available for transfers from {{ CH }} to {{ CH }} {#ch-ch-no-sharding}

For transfers from {{ CH }} to {{ CH }}, sharding is not supported.

**Solution:**

The possible workaround is to create a distributed table in the target cluster and perform a transfer to this table by selecting the `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` cleanup policy.
