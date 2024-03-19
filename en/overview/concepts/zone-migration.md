# Migrating resources to the {{ region-id }}-d availability zone

The `{{ region-id }}-c` availability zone will be [discontinued](./ru-central1-c-deprecation.md) in the first six months of 2024. You can migrate resources from it to the new `{{ region-id }}-d` zone.

We added the `relocate` CLI command for a number of {{ compute-name }} and {{ vpc-name }} resources, which allows you to migrate resources to a different zone. To migrate instance groups, {{ network-load-balancer-name }} and {{ alb-name }} resources, managed databases, {{ managed-k8s-name }} clusters, and serverless services, use the existing tools.

We are currently developing custom migration tools for {{ mgl-name }}. If you have any {{ mgl-name }} resources deployed in `{{ region-id }}-c`, we will notify you when these tools become available.

If among your services there are {{ objstorage-name }}, {{ cdn-name }}, {{ dns-name }} and others not listed below, you do not need to migrate their resources.

## Deadlines for migration from the {{ region-id }}-c zone {#relocation-deadline}

We will be discontinuing the `{{ region-id }}-c` zone in multiple steps. In Q1 2024, you will receive a newsletter or message from your account manager with a deadline for migrating your resources.

### What happens if I do not make it in time? {#what-if}

Once the migration timeline expires, we will forcibly migrate your resources from the `{{ region-id }}-c` zone. This will include:

* Creating backups on your network disks located in the `{{ region-id }}-c` zone and migrating your disks to the `{{ region-id }}-d` zone.
* Migrating your VMs to the `{{ region-id }}-d` availability zone. When being migrated, your resources will be stopped, and their network settings, subnets, IP addresses, and FQDNs will change. Then, they will be launched in the new availability zones.
* When it comes to managed database resources and {{ managed-k8s-name }}: backing up your data and migrating your resources to `{{ region-id }}-d`; this will also trigger changing network settings, subnets, IP addresses, and FQDNs.

Over this forced migration, your resources will change both its public and internal IP addresses. This may lead to losing network access to the resources through the previous IP addresses; you may also have to update your firewall and DNS configuration, as well as other settings that depend on the addresses your resources refer to.

During the forced migration, your services may also become unavailable.

To keep your services available and minimize your risks, make sure to migrate your resources from the `{{ region-id }}-c` zone on your own before the deadline.

### How do I get help with migration? {#need-help}

You can contact [our partners](./zone-migration-partners.md) for assistance and advice.

## Recommended migration process {#migration-best-practices}

1. For all networks, [create a new subnet](../../vpc/operations/subnet-create.md) in the `{{ region-id }}-d` zone.
1. (Optional) If you are using {{ interconnect-name }}, contact [support]({{ link-console-support }}) to configure the new subnet. To complete subnet configuration, you must create any resource (e.g., a VM) and connect it to the subnet to correctly announce the new subnet's routing information in {{ interconnect-name }}.
1. Migrate your resources to the new availability zone:
   1. [VM instances](#compute) (one by one or by expanding the instance group).
   1. [Database hosts](#mdb).
   1. (Optional) [Restart](../../data-transfer/operations/transfer.md) the linked {{ data-transfer-name }} transfers.
   1. [{{ managed-k8s-name }} master hosts and node groups](../../managed-kubernetes/tutorials/migration-to-an-availability-zone.md).
1. If you were using [network](../../network-load-balancer/operations/load-balancer-change-zone.md) or [L7 load balancers](../../application-load-balancer/operations/application-load-balancer-relocate.md), add the resources you want to migrate to their target groups. Enable ingress traffic in the new availability zone for the L7 load balancers.
1. Make sure the subnets in `{{ region-id }}-c` have no resources left. Delete any remaining resources.

## Migration tools {#migration-tools}

### {{ compute-name }} {#compute}

To migrate [VM instances](../../compute/operations/vm-control/vm-change-zone.md) and [disks](../../compute/operations/disk-control/disk-change-zone.md), we recommend using [snapshots](../../compute/operations/disk-control/create-snapshot.md) or [{{ backup-name }}](../../backup/).

These solutions help you manage the migration process on your own. You can decide when to shut down the VM instance in the source availability zone and when to make it available in the target zone. The VM in the source availability zone may continue to run until you make sure that the VM you created from a snapshot works properly in the new availability zone.

If using snapshots as a migration tool is not an option, you can migrate VM instances and disks by running the `yc compute instance relocate` or `yc compute disk relocate` command, respectively. In this case, you should still take a snapshot or make a backup in {{ backup-name }} before running the commands. This is because the migration process will change your VM's network environment, which may impact its performance. In addition, if something goes wrong during migration, you will be able to quickly restore your VM to the original availability zone from the snapshot or backup and attempt the migration again. You can delete the snapshots and backups once the `relocate` command is done running.

{% note warning %}

Currently, you can use the `relocate` command to migrate VMs and disks only to the `{{ region-id }}-d` zone from any other zone.

{% endnote %}

Note that you cannot migrate VM instances with attached [file storages](../../compute/concepts/filesystem.md).

You can expand [instance groups](../../compute/operations/instance-groups/move-group.md) by adding VM instances to the new availability zone. You can then delete the VM instances from the old availability zone.

The migration process for [instance groups with load balancers](../../compute/operations/instance-groups/move-group-with-nlb.md) depends on the type of load balancer you use.

For a group with an external network load balancer, all you need to do is add the VM instances to the new availability zone. For a group with an internal load balancer, you need to specify a new listener created on a subnet in the new availability zone or migrate the existing subnet to the new zone.

If your group has an [L7 load balancer](../../compute/operations/instance-groups/move-group-with-alb.md), you need to enable traffic in the new availability zone and add the VM instances to the target group.

### Managed database services {#mdb}

In most cases, to migrate a managed database service host, you need to create a host in the new availability zone, add it to the cluster, and specify the FQDN of the new host in the backend or client.

See these service-specific migration guides:

* [{{ mpg-name }}](../../managed-postgresql/operations/host-migration.md)
* [{{ mch-name }}](../../managed-clickhouse/operations/host-migration.md)
* [{{ mmg-name }}](../../managed-mongodb/operations/host-migration.md)
* [{{ mmy-name }}](../../managed-mysql/operations/host-migration.md)
* [{{ mrd-name }}](../../managed-redis/operations/host-migration.md)
* [{{ mos-name }}](../../managed-opensearch/operations/host-migration.md)
* [{{ ydb-name }}](../../ydb/operations/migration-to-an-availability-zone.md)
* {{ mgp-name }}: To migrate, restore the cluster from a [backup](../../managed-greenplum/operations/cluster-backups.md).
* [{{ dataproc-name }}](../../data-proc/operations/migration-to-an-availability-zone.md)

   Guides for {{ dataproc-name }} HDFS clusters are currently under development. If your cluster is hosted in the `ru-central1-c` availability zone and uses the HDFS, the {{ yandex-cloud }} support team will notify you when the migration guides for these clusters are available.

The migration tools for {{ mkf-name }} will become available in early 2024. If you have any resources hosted in the `{{ region-id }}-c` zone, we will notify you when this happens.

### {{ data-transfer-name }} {#data-transfer}

If you added a new host in the `{{ region-id }}-d` zone to a cluster that has {{ data-transfer-name }} configured, to [resume the transfer](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md), you will need to:

1. Have at least one host in the cluster that is outside `{{ region-id }}-d`.
1. After changing the cluster, restart the transfers that were previously in the `Running` status or change the settings of the transfer or its endpoints: this way, the transfer will restart with a new cluster topology.

### {{ managed-k8s-name }} {#k8s}

{% include [unable-migration-in-relocated-subnet](../../_includes/managed-kubernetes/unable-migration-in-relocated-subnet.md) %}

To move a {{ managed-k8s-name }} cluster between availability zones:

* [Migrate a master host](../../managed-kubernetes/tutorials/migration-to-an-availability-zone.md#transfer-a-master).
* [Migrate the node group and the pod workloads](../../managed-kubernetes/tutorials/migration-to-an-availability-zone.md#transfer-a-node-group).

### {{ network-load-balancer-name }} {#nlb}

When using network load balancers without instance groups, you need to [migrate the VM to the new availability zone](../../network-load-balancer/operations/load-balancer-change-zone.md) and add it to the load balancer's target group.

### {{ alb-name }} {#alb}

To migrate a VM that is connected to an L7 load balancer, you need to enable traffic in the new availability zone, [migrate the VM, and add it to the target group](../../application-load-balancer/operations/application-load-balancer-relocate.md).

### {{ vpc-name }} {#vpc}

Subnet migration allows you to maintain the original addressing and the IP addresses configured for the listeners of the internal load balancers. Note that you can only migrate empty subnets that do not have any connected resources, such as VM instances, database hosts, and {{ managed-k8s-name }} nodes.

{% note alert %}

Currently, you cannot migrate subnets.

Additionally, you cannot currently create or migrate {{ managed-k8s-name }} clusters and node groups within the subnets migrated from the `{{ region-id }}-c` availability zone.

{% endnote %}

You can [migrate](../../vpc/operations/subnet-relocate.md) subnets by running the `relocate` command.

#### IP address migration {#ip-addresses}

You cannot migrate public IP addresses between zones. To save the public address for incoming traffic, [reserve](../../vpc/operations/get-static-ip.md) this address and then assign it to the network balancer handler. Next, you can migrate the VM and connect it to a network balancer. If the public IP address of the balancer was in the `{{ region-id }}-c` zone, it will continue working; see [{#T}](../../network-load-balancer/concepts/specifics.md) of the network balancer for details.

Note: This way, you can save the IP address for incoming traffic only. For example, if the IP address of a VM is licensed, you cannot use the public IP address of the balancer to check it.

If you need an IP address with open port `25` in a new zone, order a new one in advance by contacting support.

### {{ api-gw-name }}, {{ sf-name }}, {{ serverless-containers-name }} {#serverless}

To migrate functions, containers, and API gateways, you need to create a subnet in the new availability zone.

* [Functions](../../functions/operations/function/migration.md)
* [Containers](../../serverless-containers/operations/migration.md)
* [API gateways](../../api-gateway/operations/api-gw-migration.md)

### {{ mgl-name }} {#gitlab}

A tool that will allow you to migrate {{ mgl-name }} installations hosted in the `{{ region-id }}-c` availability zone on your own is currently under development and is scheduled for release by late March 2024. If you use {{ mgl-name }} in the `{{ region-id }}-c` zone, we will notify you as soon as the option to migrate resources from `{{ region-id }}-c` is available.

### {{ cloud-desktop-name }} {#cloud-desktop}

If your desktop contains no valuable information, it is enough to [create a new desktop](../../cloud-desktop/operations/desktops/create.md) and [delete the old one](../../cloud-desktop/operations/desktops/delete.md). If there is valuable information, [create an image](../../cloud-desktop/operations/images/create-from-desktop.md) from the old desktop and then create a new desktop from that image.
