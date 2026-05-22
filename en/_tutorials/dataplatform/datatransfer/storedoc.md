# Migrating data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-mg).
1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-mg).
1. {% include [source endpoint](../../_tutorials_includes/storedoc-source-endpoint.md) %}
1. {% include [target endpoint](../../_tutorials_includes/storedoc-target-endpoint.md) %}
1. {% include [storedoc transfer](../../_tutorials_includes/storedoc-transfer.md) %}
1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to "read-only" mode and move the workload to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Ensure the transfer is stopped, then delete it](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
