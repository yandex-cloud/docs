{#ai-decom1-id}

Requirement ID: `AI-DECOM1`

{#ai-decom1-requirement}

**Requirement**

Before decommissioning a model, index, agent, or application, the owner must register a versioned inventory of all active and reserved objects: data, models, indexes, logs, keys, secrets, identities, role bindings, endpoints, routes, disks, backups, and external integrations.

For each object, select one of the following: deletion, transfer, retention for an approved period, or a deletion-prohibition mode based on legal grounds. Procedure readiness is required for each production component; the `N/A` result is acceptable as evidence of actual execution, but not for verifying readiness.

{#ai-decom1-implementation}

**Implementation**

First, new calls and access to the component are halted: its keys and bindings are revoked, the dedicated endpoint is closed, or the route for the component being decommissioned is removed from the shared gateway. The shared identity or gateway is not deleted entirely if it serves other systems; instead, the capabilities and permissions associated with the component are deleted in this case. [{{ ciem-name }}](../../../../security-deck/concepts/ciem.md) is entirely at the Preview stage: if availability is confirmed, it can be used to verify assignments and [revoke access](../../../../security-deck/operations/ciem/revoke-permissions.md) within published roles and group restrictions.

Next, active objects are deleted, and lifecycle termination for backups and versions is configured. Immediate deletion may not be possible due to an [object lock](../../../../storage/concepts/object-lock.md), established retention periods, backups, or specific {{ kms-short-name }} features. Any legal prohibition on deletion takes precedence.

Before destructive operations, the configuration is exported, as it may not be possible to roll back the deletion.

{#ai-decom1-check}

**Check**

1. Try to invoke the component using the same method, use the revoked key, and read the active object.
1. Match the result with the inventory and change events.

The completion report must include the inventory version, evidence for each object, unresolved dependencies, the owner of the preserved data, the next action date, and the approving authority. The system is deleted from the registry of active systems only after mandatory items have been checked off; pending deletion remains a recorded obligation. After execution, the inventory process is repeated and must not reveal any unaccounted for objects; the saved record is only accessible to the specified owner.

{#ai-decom1-artifacts}

**Artifact**

* Inventory version.
* Completion report.
* Call test using the same method.
* Pre- and post-inventory.
* Result of search for residual objects.
