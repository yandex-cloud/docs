# Compute maintenance policies

*Compute Maintenance Policies* provide the ability to report the planned impact on the user VM by the cloud infrastructure using the [metadata service](https://cloud.yandex.ru/ru/docs/compute/concepts/vm-metadata).

A planned impact means the occurrence of one of the following VM maintenance events:

* `TERMINATE_ON_HOST_MAINTENANCE`: User VM shutdown is scheduled.
* `MIGRATE_ON_HOST_MAINTENANCE`: [Live migration](https://cloud.yandex.ru/ru/docs/compute/concepts/live-migration) of user VM to another host (server) is scheduled.

Compute maintenance policy can be defined using:

* Maintenance policy type: `maintenance_policy`.
* Maintenance grace period: `maintenance_grace_period`.

The following maintenance policy types are supported:

* `RESTART`: When a maintenance event occurs, the `TERMINATE_ON_HOST_MAINTENANCE` line appears in the metadata. After the `maintenance_grace_period` ends, the VM will be migrated to another host using the VM stop and run procedures.
* `MIGRATE`: When a maintenance event occurs, the `MIGRATE_ON_HOST_MAINTENANCE` line appears in the VM metadata. After the `maintenance_grace_period` ends, the VM will be migrated to another host using the live migration procedure.
* `MAINTENANCE_POLICY_UNSPECIFIED`: Default maintenance policy if no maintenance policy is explicitly set. In this case, nothing appears in the VM metadata service.

When setting the maintenance grace period, keep in mind that you can delay the start of maintenance by the following maximum period after the maintenance event occurs:

* `Up to 1 minute` for live migration or shutdown of a VM without a GPU.
* `Up to 24 hours` for a VM with a GPU.

#### Maintenance policy support for preemptible VMs {#int}

When maintenance events occur, [preemptible VMs](../concepts/preemptible-vm.md) simply stop instead of migrating. No maintenance events appear in the VM metadata in this case.

This functionality for preemptible VMs has not been implemented yet, but is in our plans going forward. For preemptible VMs with GPUs, the maximum `grace period` cannot be more than 1 minute.

### Enabling a VM maintenance policy {#apply}

You can [enable and configure](../operations/vm-control/vm-update-policies.md) VM maintenance policies using the [CLI](../../cli/index.yaml) and [Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md). Currently you cannot configure maintenance policies from the management console.
