# Compute maintenance policies


*Compute Maintenance Policies* provide the ability to report the planned impact on the user VM by the cloud infrastructure using the [metadata service](vm-metadata.md).

A planned impact means the occurrence of one of the following VM maintenance events:

* `TERMINATE_ON_HOST_MAINTENANCE`: User VM restart is scheduled.
* `MIGRATE_ON_HOST_MAINTENANCE`: [Live migration](live-migration.md) of user VM to another host (server) is scheduled.

Compute maintenance policy can be defined using:

* Maintenance policy type: `maintenance_policy`.
* Maintenance grace period: `maintenance_grace_period`.

The following maintenance policy types are supported:

* `RESTART`: When a maintenance event occurs, the `TERMINATE_ON_HOST_MAINTENANCE` line appears in the metadata. After the `maintenance_grace_period` ends, the VM will be migrated to another host using the VM stop and run procedures.
* `MIGRATE`: When a maintenance event occurs, the `MIGRATE_ON_HOST_MAINTENANCE` line appears in the VM metadata. After the `maintenance_grace_period` ends, the VM will be migrated to another host using the live migration procedure.
* `MAINTENANCE_POLICY_UNSPECIFIED`: No policy is specified. Nothing is supplied to the metadata service; there is no wait time before maintenance.

When setting the maintenance grace period, keep in mind that you can delay the start of maintenance by the following maximum period after the maintenance event occurs:

* `Up to one minute` for VMs without GPUs.
* `Up to 24 hours` for VMs with GPUs.

### Features for preemptible VMs {#preemptible-vm}

When maintenance events occur, [preemptible VMs](preemptible-vm.md) simply stop instead of migrating. No maintenance events appear in the VM metadata in this case.

### Features for VMs with GPUs {#vm-with-gpu}

If the `RESTART` policy is set for VMs with GPUs (non-preemptible), [email notifications](../../resource-manager/concepts/notify.md#technical) about scheduled maintenance works on such VMs are disabled. During scheduled works, the VM will automatically restart following a`maintenance_grace_period` after a maintenance event appears in the metadata.

### How to enable {#apply}

You can [enable and configure](../operations/vm-control/vm-update-policies.md) VM maintenance policies using the [CLI](../../cli/index.yaml) and [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md). Currently you cannot configure maintenance policies from the management console.

### Limitations {#limits}

A maintenance event can only be generated in the case of planned impact on a VM. If a VM fails, it may be restarted on another physical host. In this case, nothing appears in the VM metadata service. You will receive a [failure](../../resource-manager/concepts/notify.md#infra) notification by email.
