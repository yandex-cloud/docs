---
title: Compute maintenance policies
description: In this tutorial, you will learn about compute maintenance policies.
---

# Compute maintenance policies


Use *compute maintenance policies* to manage a VM's response to scheduled maintenance and receive maintenance information via [metadata](vm-metadata.md).

During maintenance, a VM instance is migrated to a different host. The policy determines how the system migrates the VM instance:

* Restarts the instance on another host.
* Performs [live migration](live-migration.md) to another host without restarting the instance.

If the policy is configured, information about upcoming maintenance may be written to the VM instance’s metadata. Stored in the metadata service, maintenance metadata is only accessible from within the VM. Applications running on the VM instance can read it and get ready for maintenance, e.g., by completing active requests or saving state before a restart.

## Compute maintenance policy settings {#parameters}

{% note warning %}

Before configuring a policy, review [these considerations for different VM types](#vm-specifics). The available policy types and maintenance behavior depend on the VM type.

{% endnote %}

A VM maintenance policy is defined by two parameters:

* `maintenance_policy`: Type of maintenance policy. 
* `maintenance_grace_period`: Maintenance grace period.

To select how the system migrates the VM to another host, set the relevant `maintenance_policy` value. To restart the VM, set to `RESTART`. To perform live migration, specify `MIGRATE`.

To not specify a policy, set the value to `MAINTENANCE_POLICY_UNSPECIFIED`. In this case, maintenance information does not appear in the metadata, and there is no grace period before maintenance.

The `maintenance_grace_period` value defines a delay for the VM restart or migration.

Maximum grace period:

* Up to one minute for VMs without GPUs.
* Up to one hour for VMs with GPUs.

Maintenance information appears in the VM metadata only if `maintenance_grace_period > 0`. If set to zero, the metadata includes no maintenance information, and maintenance is performed without a grace period.

You can configure the maintenance policy when [creating](../operations/index.md#vm-create) and [updating](../operations/vm-control/vm-update.md) a VM instance. You can use the [CLI](../../cli/index.yaml), [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md), or [API](../api-ref/index.md) to configure both the policy type and grace period, while the management console only allows you to set the policy type.

## Working with metadata {#handle-event}

Information about upcoming maintenance is written to the VM metadata under the `/instance/maintenance-event` key. You can use this key to access maintenance information [only from within the VM](../concepts/metadata/accessing-metadata.md) via the [metadata service](vm-metadata.md). For more details on the metadata storage format, see [this article](vm-metadata.md#metadata-formats).

The following values are written:

* `TERMINATE_ON_HOST_MAINTENANCE` before the VM restarts.
* `MIGRATE_ON_HOST_MAINTENANCE` before live migration.

You can implement [reading metadata from within the VM](../operations/vm-metadata/get-vm-metadata.md#internal-access) and have your application react to maintenance.

For example, let’s assume your maintenance policy is `RESTART`. The system writes `TERMINATE_ON_HOST_MAINTENANCE` to the metadata and starts the countdown for `maintenance_grace_period`. The application reads the metadata and uses the grace period to save its state. After the grace period expires, the VM restarts.

To test the maintenance response in your application, [simulate a maintenance event](../operations/vm-control/vm-update-policies.md#simulate).

## Considerations for different types of VMs {#vm-specifics}

### Considerations for preemptible VMs {#preemptible-vm}

During maintenance, [preemptible VMs](preemptible-vm.md) are stopped and do not migrate. Maintenance information does not appear in the metadata.

### Considerations for VMs with GPUs {#vm-with-gpu}

VMs with GPUs [do not support live migration](live-migration.md#limitations).

If the `RESTART` policy is configured for a non-preemptible VM with a GPU, [email notifications](../../resource-manager/concepts/notify.md#technical) about scheduled maintenance are disabled, and [maintenance tasks](./gpus-maintenance.md#tasks) are not created. During scheduled maintenance, the VM automatically restarts following a `maintenance_grace_period`.

## Limitations {#limits}

Metadata events only warn about scheduled maintenance. If a VM fails, it may restart on another host without warning. The system will notify of a [failure](../../resource-manager/concepts/notify.md#infra) by email.

#### Useful links {#see-also}

* [Maintenance policy management](../operations/vm-control/vm-update-policies.md)
* [Getting VM instance metadata](../operations/vm-metadata/get-vm-metadata.md)
