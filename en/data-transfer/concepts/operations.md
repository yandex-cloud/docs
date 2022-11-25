# Transfer operations

An operation is an action on a transfer that can be initiated:
* By the user, for example, when activating or deactivating the transfer.
* By the transfer itself, for example, if an error occurs in the operation of the transfer.
* Administrators of {{ yandex-cloud }}, for example, when updating the transfer version.

The history of operations on the transfer is available on the operations page.

## User-initiated operations {#user-operations}

* **Activate**: When [activating](../operations/transfer.md#activate) the transfer.
* **Deactivate**: When [deactivating](../operations/transfer.md#deactivate) the transfer.
* **ReUpload**: When [restarting](../operations/transfer.md#reupload) the transfer.
* **Restart**: When editing the settings of a transfer in the {{ dt-status-repl }} state, or when editing the settings of one of the endpoints of such a transfer.

## Operations initiated by the transfer {#transfer-operations}

* **Termination**: When an irreparable error occurs in the operation of the transfer, leading to shutdown (for example, when deleting the replication slot in the case of delivery from {{ PG }}).
* **CleanupResource**: When necessary, delete external resources created by the transfer. Occurs when the transfer is completed in case of an error and when deactivated.

## Operations initiated by the administrator {#administrator-operations}

* **Update version**: When a new version of the {{ data-transfer-name }} service is released and the transfer version is updated.
