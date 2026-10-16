---
title: Operations on transfers in {{ data-transfer-full-name }}
description: An operation is an action performed on a transfer that can be initiated by users, the transfer itself, or {{ yandex-cloud }} administrators.
---

# Operations on transfers

An operation is an action performed on a transfer that can be initiated by:
* Users, e.g., when activating or deactivating a transfer.
* Transfer itself, e.g., in the event of an error in the transfer.
* {{ yandex-cloud }} administrators, e.g., when upgrading the transfer version.

The history of transfer operations is available on the operations page.

## Operations initiated by users {#user-operations}

* **Activate**: [Activates](../operations/transfer.md#activate) the transfer. Activation is required for each new transfer, except for an `INCREMENT_ONLY` or `SNAPSHOT_AND_INCREMENT` transfer [created](../operations/transfer.md#create) using Terraform.

  Upon activation, the system provisions resources for the transfer. The actions depend on the transfer type:

    * {{ dt-type-copy }}: Initiates a full data copy.
    * {{ dt-type-repl }}: Starts replication of changes without prior copying.
    * {{ dt-type-copy-repl }}: Creates a replication slot, makes a full data copy, and runs replication of changes.

  For transfers with periodic copying, each run triggers either full data copy or incremental copy, if this mode is configured for tables.

* **Deactivate**: Deactivates the transfer.

  During transfer [deactivation](../operations/transfer.md#deactivate), the system cleans up run artifacts. For example:

    * For {{ dt-type-copy-repl }} transfers, disables the replication slot on the source.
    * Deletes temporary data transfer logs.
    * Synchronizes the target:

        * Transfers the source data schema objects for the final deactivation stage.
        * Creates indexes.


* **UpdateTransfer** when editing the settings of the transfer in the {{ dt-status-repl }} status.

## Operations initiated by a transfer {#transfer-operations}

* **Termination** if a fatal error occurs during the transfer that terminates it (for example, when deleting a replication slot if data is delivered from {{ PG }}).
* **CleanupResource** to delete external resources created by the transfer. Takes place if the transfer shuts down due to an error or deactivation.

## Operations initiated by administrators {#administrator-operations}

* **Update version** when a new {{ data-transfer-name }} version is released or the transfer version is updated.
