# Transfer types and lifecycles

A transfer's lifecycle is the set of its statuses and transitions between them. The transfer type determines the order of transitions between statuses. The current transfer status determines available actions with transfers. For more information, see [{#T}](../operations/transfer.md).

## Statuses {#statuses}

* {{ dt-status-created }}: Assigned to a transfer immediately after [creation](../operations/transfer.md#create).

* {{ dt-status-creation }}: Assigned to a transfer after [activation](../operations/transfer.md#activate).

   At this time, the service checks the connection to the source and target and creates the resources necessary for the transfer. Depending on the [transfer type](./index.md#transfer-type) and [endpoint](./index.md#endpoint) settings, additional actions may be available, for example, creating replication slots, copying a data schema, and so on.

* {{ dt-status-stopping }}: Assigned to the transfer after [deactivation](../operations/transfer.md#deactivate).

   At this time, the service performs the actions necessary to properly disconnect from the source and target. Depending on the [transfer type](./index.md#transfer-type) and [endpoint](./index.md#endpoint) settings, additional actions may be performed, for example, closing replication slots, transferring triggers, stored procedures, and functions, creating indexes in the target database, and so on.

* {{ dt-status-stopped }}: Assigned to the transfer after [deactivation](../operations/transfer.md#deactivate) is complete.

   Only successful transfer deactivation guarantees the operability of the target and the source.

* {{ dt-status-copy }}: Assigned to _{{ dt-type-copy }}_ and _{{ dt-type-copy-repl }}_ transfers for the period while data is copied from the source.

* {{ dt-status-repl }}: Assigned to _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers.

   * _{{ dt-type-repl }}_: After a successful [activation](../operations/transfer.md#activate).
   * _{{ dt-type-copy-repl }}_: After successfully copying data from the source.

* {{ dt-status-finished }}: Assigned to transfers that have successfully transferred the data.

* {{ dt-status-error }}: Assigned to the transfer if any issues occur.

   A transfer's status may transition to **{{ dt-status-error }}** during activation, data replication, or copying. Depending on the status that preceded the error, the transfer can be [reactivated](../operations/transfer.md#activate) or [restarted](../operations/transfer.md#reupload). Errors may occur both on the source and the target.

   Learn more about possible causes for errors and how to resolve them in [{#T}](../troubleshooting/index.md).

## Transfer types {#transfer-types}

### Copy {#copy}

The _{{ dt-type-copy }}_ transfer is designed for transferring the state of the source database to the target without keeping it up-to-date. Changes that occurred on the source after the transfer is completed will not be transferred. This type of transfers can be useful when there is no writing load on the source or there is no need to keep the target database up-to-date, for example, [when deploying test environments](./use-cases.md#testing).

When the transfer is ready, its status automatically switches to {{ dt-status-copy }}. It's maintained until all the data in the source is transferred to the target. Then the transfer is automatically deactivated and switches its status to {{ dt-status-finished }}.

The transition between statuses for the _{{ dt-type-copy }}_ transfer type is shown below:

![lifecycle-copy](../../_assets/data-transfer/lifecycle/copy.svg)

{{ data-transfer-full-name }} supports three types of data copy:

* _{{ dt-copy-snapshot }}_: Copies all data from the source to the target when activating a transfer. This type of copy may take a long time if the amount of data to transfer is large. In addition, a one-time copy operation doesn't factor in data changes. You can recopy the data only after the previous operation is completed.
* _{{ dt-copy-regular }}_: Copies all data from the source to the target at certain intervals of time. This copy method lets you set up regular data delivery. It's recommended for small tables that are frequently modified.
* _{{dt-copy-regular-incremental}}_: Only copies the data that has been modified in the source since the previous copy operation to the target at certain intervals of time. This approach lets you arrange data delivery to the target with the minimum possible latency and load on the data source. However, it doesn't let you factor in the source data delete operations.

### Replicate {#replication}

The _{{ dt-type-repl }}_ transfer is designed for transferring changes from the source to the target without completely copying all the data: during [activation](../operations/transfer.md#activate), only the data schema is transferred.

When the transfer is ready, its status automatically switches to {{ dt-status-repl }}, which is maintained indefinitely. Changes occurring in the source are automatically transmitted to the target.

The transition between statuses for the _{{ dt-type-repl }}_ transfer type is shown below:

![lifecycle-replication](../../_assets/data-transfer/lifecycle/replication.svg)

### Copy and replicate {#copy-and-replication}

The _{{ dt-type-copy-repl }}_ transfer combines the functionality of _{{ dt-type-copy }}_ and _{{ dt-type-repl }}_ transfers: the source data is completely transferred to the target and is kept up-to-date. Typically, such transfers are used in migration scenarios.

After successful [activation](../operations/transfer.md#activate) and preparation for work, the status of the transfer automatically switches to {{ dt-status-copy }}. It's maintained until all the data in the source is transferred to the target.

Then the status of the transfer switches to {{ dt-status-repl }}: all changes occurring on the source are automatically transferred to the target.

The transition between statuses for the _{{ dt-type-copy-repl }}_ transfer type is shown below:

![lifecycle-copy-and-replication](../../_assets/data-transfer/lifecycle/copy-and-replication.svg)

### Selecting a transfer type {#select-transfer-type}

{% include [copying-changing-tables](../../_includes/data-transfer/copying-changing-tables.md) %}