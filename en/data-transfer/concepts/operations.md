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

* **Activate** when [activating](../operations/transfer.md#activate) a transfer.
* **Deactivate** when [deactivating](../operations/transfer.md#deactivate) a transfer.
* **Restart** when editing the settings of an endpoint of the transfer in the {{ dt-status-repl }} status.
* **UpdateTransfer** when editing the settings of the transfer in the {{ dt-status-repl }} status.

## Operations initiated by a transfer {#transfer-operations}

* **Termination** if a fatal error occurs during the transfer that terminates it (for example, when deleting a replication slot if data is delivered from {{ PG }}).
* **CleanupResource** to delete external resources created by the transfer. Takes place if the transfer shuts down due to an error or deactivation.

## Operations initiated by administrators {#administrator-operations}

* **Update version** when a new {{ data-transfer-name }} version is released or the transfer version is updated.
