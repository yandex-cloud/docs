# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-mg).
1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-mg).
1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

   * **Database type**: `MongoDB`.
   * **Endpoint parameters** → **Connection settings**: `Custom installation`.
      Specify the parameters for connecting to the source cluster.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

   * **Database type**: `MongoDB`.
   * **Endpoint parameters** → **Connection settings**: `MDB cluster`.
      Specify the ID of the target cluster.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
1. [Activate](../../data-transfer/operations/transfer.md#activate) it.
1. Wait for the transfer to change to the `Replicated` status.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait its status to change to `Stopped`.

   For more information about the transfer lifecycle, see the [appropriate section](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../../data-transfer/operations/transfer.md#delete) the stopped transfer.
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.
