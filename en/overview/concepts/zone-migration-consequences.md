# Consequences of forced migration of resources from the {{ region-id }}-c zone

If you have not [migrated](./zone-migration.md) your resources from the `{{ region-id }}-c` availability zone before the deadline, we will migrate them forcibly. For more information about the possible risks of forced migration, see [Forced migration risks](./zone-migration.md#technical-risks).

This page explains what you may need to do to restore your infrastructure after a forced migration.

## Forced migration of VMs, disks, and subnets {#vm-disks-subnets}

[Snapshots](../../compute/concepts/snapshot.md) have been taken of all your disks. You can find them in the [management console]({{ link-console-main }}), under {{ compute-full-name }} **Snapshots**.

Where possible, your VMs, disks, and subnets were moved to the `{{ region-id }}-d` zone. Check whether you can access them and everything works well. However, due to [forced migration risks](./zone-migration.md#technical-risks), your resources may not be available. In this case, restore them from the snapshots.

Your static public IP addresses from the `{{ region-id }}-c` zone may not be available. If required, reserve new static external IP addresses from the `{{ region-id }}-d` zone.

If you are unable to restore your infrastructure after a forced migration, contact [technical support]({{ link-console-support }}).

## Forced migration of managed service resources {#managed-services}

For a forced migration, we could create special subnets in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` zones. Your resources were moved to them from the {{ managed-k8s-full-name }}, {{ ig-full-name }}, {{ mgl-full-name }} managed database services located in the `{{ region-id }}-c` zone. Make sure your resources are working correctly.

However, due to [forced migration risks](./zone-migration.md#technical-risks), your resources may not be available: both the public and internal IP addresses of your resources may have changed. If you need help with recovery from backups, contact [technical support]({{ link-console-support }}).

## Forced migration of {{ alb-full-name }} {#alb}

We have disabled incoming traffic for your L7 load balancers in the `{{ region-id }}-c` zone. If you need to enable incoming traffic in the `{{ region-id }}-d` zone, do it [yourself](../../application-load-balancer/operations/application-load-balancer-relocate.md).

## Forced migration of {{ data-transfer-full-name }}

If during forced migration your transfers in {{ data-transfer-name }} stopped working, [restart](../../data-transfer/operations/transfer.md) them.

## FAQ {#qa}

### Why do I get the Access Denied error? {#access-denied}

As long as your VMs, disks, and subnets from the `{{ region-id }}-c` zone are in the active phase of forced migration, you will not be able to use or modify them. You will get an error if you attempt to modify them: this is to be expected. Wait until the active phase is over and the resources are in the `{{ region-id }}-d` zone. Then you can modify them again.

The active phase of forced migration can take up to several days. It will begin on an individual schedule for each client after the [migration deadline](./zone-migration.md#relocation-deadline).

If your resources are already in the `{{ region-id }}-d` zone, but you still cannot modify them, contact [technical support]({{ link-console-support }}).

### What will happen to resources on the standard-v1 (Intel Broadwell) platform? {#standard-v1}

The old `standard-v1` (Intel Broadwell) platforms are not supported in the `{{ region-id }}-d` zone. If we forcibly migrate resources based on such platforms into the `{{ region-id }}-d` zone, they will not be able to run there. You will get the `platform "standard-v1" is unavailable in zone “ru-central1-d”` error if you try to run them. If you encounter this, change the VM and [select a different platform](../../compute/operations/vm-control/vm-update-resources.md), preferably `standard-v3` (Intel Ice Lake), set the required number of cores and memory size, save the new configuration, and try running the VM again.

If you cannot run the VM after changing the platform, contact [technical support]({{ link-console-support }}).