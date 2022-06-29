# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster database](../../data-transfer/operations/prepare.md#prepare-source-my).
1. [Prepare the target cluster database](../../data-transfer/operations/prepare.md#prepare-target-my).
1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `{{ MY }}`.
   * **Connection settings**: `MDB cluster`.
      Specify the source cluster ID.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `{{ MY }}`.
   * **Connection settings**: `Custom installation`.
      Specify the target cluster connection settings.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create-transfer) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
1. [Activate](../../data-transfer/operations/transfer.md#activate-transfer) it.

   {% note warning %}

   Avoid any changes to the data schema in the source and target clusters during the transfer operation. For more information, see [{#T}](../../data-transfer/operations/db-actions.md).

   {% endnote %}

1. Wait for the transfer to change to the **Incremented** status.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery, [s]** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait its status to change to **Stopped**.

   To learn more about the transfer lifecycle, see the [{{ data-transfer-full-name }} documentation](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../../data-transfer/operations/transfer.md#delete-transfer) the stopped transfer.
1. [Delete endpoints for the source and target](../../data-transfer/operations/endpoint/index.md#delete).
