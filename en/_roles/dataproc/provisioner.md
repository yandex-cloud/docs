The `dataproc.provisioner` role grants access to the API to create, update, and delete Yandex Data Proc cluster objects.

{% cut "Users with this role can:" %}

* View information on [DNS zones](../../dns/concepts/dns-zone.md) as well as create, use, modify, and delete them.
* View information on [resource records](../../dns/concepts/resource-record.md) as well as create, modify, and delete them.
* Create nested public DNS zones.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) for DNS zones.
* View information on available [platforms](../../compute/concepts/vm-platforms.md) and use them.
* Create, modify, start, restart, stop, move, and delete [instances](../../compute/concepts/vm.md).
* View the list of instances, information on instances and on granted access permissions for them.
* Connect and disconnect disks, file storages, and network interfaces to and from instances, as well as link [security groups](../../vpc/concepts/security-groups.md) to instance network interfaces.
* Create instances with custom [FQDNs](../../vpc/concepts/address.md#fqdn) and create multi-interface instances.
* Bind [service accounts](../../iam/concepts/users/service-accounts.md) to instances and activate AWS v1 tokens on instances.
* View the list of service accounts and info on them, as well as perform operations on behalf of a service account.
* Use the instance [serial port](../../compute/operations/vm-info/get-serial-port-output.md) for reading and writing.
* Simulate instance maintenance events.
* View instance [metadata](../../compute/concepts/vm-metadata.md).
* View information on the status of configuring access via [OS Login](../../organization/concepts/os-login.md) on instances and connect to instances via OS Login using SSH certificates or SSH keys.
* View the list of [instance groups](../../compute/concepts/instance-groups/index.md), information on instance groups and on granted access permissions for them, as well as use, create, modify, start, stop, and delete instance groups.
* View the list of [instance placement groups](../../compute/concepts/placement-groups.md), information on instance placement groups and on granted access permissions for them, as well as use, modify, and delete instance placement groups.
* View lists of instances in placement groups.
* View the list of [dedicated host groups](../../compute/concepts/dedicated-host.md#host-group-size), information on dedicated host groups and on granted access permissions for them, as well as use, modify, and delete dedicated host groups.
* View lists of [hosts](../../compute/concepts/dedicated-host.md) and instances in dedicated host groups.
* Modify scheduled maintenance windows for hosts in dedicated host groups.
* Use [GPU clusters](../../compute/concepts/gpus.md#gpu-clusters), as well as create, modify, and delete them.
* View info on GPU clusters and instances included in GPU clusters, as well as on granted access permissions for these clusters.
* View the list of [disks](../../compute/concepts/disk.md), information on disks and on granted access permissions for them, as well as use, modify, move, and delete disks.
* Create [encrypted disks](../../compute/concepts/disk.md#encryption).
* View and update disk links.
* View the list of [file storages](../../compute/concepts/filesystem.md), information on file storages and on granted access permissions for them, as well as use, create, modify, and delete file storages.
* View the list of [non-replicated disk placement groups](../../compute/concepts/disk-placement-group.md), information on non-replicated disk placement groups and on granted access permissions for them, as well as use, modify, and delete non-replicated disk placement groups.
* View lists of disks in placement groups.
* View the list of [images](../../compute/concepts/image.md), information on images and on granted access permissions for them, as well as use, modify, and delete images.
* Create, modify, delete, and update [image families](../../compute/concepts/image.md#family).
* View info on image families, on images within families, on the latest family image, as well as on granted access permissions for image families.
* View the list of [disk snapshots](../../compute/concepts/snapshot.md), information on disk snapshots and on granted access permissions for them, as well as use, modify, and delete disk snapshots.
* View info on disk snapshot [schedules](../../compute/concepts/snapshot-schedule.md) and on granted access permissions for them, as well as create, modify, and delete disk snapshot schedules.
* View the list of [cloud networks](../../vpc/concepts/network.md#network) and info on them, as well as use them.
* View the list of [subnets](../../vpc/concepts/network.md#subnet) and info on them, as well as use them.
* View the list of [cloud resource addresses](../../vpc/concepts/address.md) and info on them, as well as use such addresses.
* View the list of [route tables](../../vpc/concepts/routing.md#rt-vpc) and info on them, as well as use them.
* View the list of security groups and info on them, as well as use them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md) and connect them to route tables.
* View information on the IP addresses used in subnets.
* View info on Monitoring [metrics](../../monitoring/concepts/data-model.md#metric) and their [labels](../../monitoring/concepts/data-model.md#label), as well as download metrics.
* View the list of Monitoring [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [widgets](../../monitoring/concepts/visualization/widget.md), as well as the info on those.
* View the Monitoring [notification](../../monitoring/concepts/alerting/notification-channel.md) history.
* View info on [log groups](../../logging/concepts/log-group.md).
* View info on log sinks.
* View info on granted access permissions for Cloud Logging resources.
* View info on log exports.
* View information on Compute Cloud resource and [quota](../../compute/concepts/limits.md#compute-quotas) consumption and [disk limits](../../compute/concepts/limits.md#compute-limits-disks) in the management console.
* View info on the [Cloud DNS](../../dns/concepts/limits.md#cloud-dns-quotas), [Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-quotas), and [Monitoring](../../monitoring/concepts/limits.md#monitoring-quotas) quotas.
* View lists of resource operations for Compute Cloud and information on operations, as well as abort such operations.
* View information on resource operations for Virtual Private Cloud.
* View the list of [availability zones](../../overview/concepts/geo-scope.md), information on availability zones and on granted access permissions for them.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `iam.serviceAccounts.user`, `dns.editor`, `compute.editor`, `monitoring.viewer`, and `logging.viewer` permissions.