The `compute.admin` role allows you to manage instances, instance groups, disks, images, GPU clusters, and other Compute Cloud resources, as well as manage access to them.

{% cut "Users with this role can:" %}

* Create, modify, start, restart, stop, move, and delete [instances](../../compute/concepts/vm.md), as well as manage access to them.
* View a list of instances, information on instances and on [access bindings](../../iam/concepts/access-control/index.md#access-bindings) to them.
* Connect and disconnect disks, file storages, and network interfaces to and from instances, as well as link [security groups](../../vpc/concepts/security-groups.md) to instance network interfaces.
* Create instances with custom [FQDNs](../../vpc/concepts/address.md#fqdn) and create multi-interface instances.
* Bind [service accounts](../../iam/concepts/users/service-accounts.md) to instances and activate AWS v1 tokens on instances.
* Use the instance [serial port](../../compute/operations/vm-info/get-serial-port-output.md) for reading and writing.
* Simulate instance maintenance events.
* View instance [metadata](../../compute/concepts/vm-metadata.md).
* View information on the status of configuring access via [OS Login](../../organization/concepts/os-login.md) on instances and connect to instances via OS Login using SSH certificates or SSH keys and run commands as a superuser (`sudo`).
* Use, create, modify, start, stop, and delete [instance groups](../../compute/concepts/instance-groups/index.md), as well as manage access to instance groups.
* View a list of instance groups, information on instance groups and on access bindings to them.
* Use, create, modify, and delete [instance placement groups](../../compute/concepts/placement-groups.md), as well as manage access to instance placement groups.
* View a list of instance placement groups, information on instance placement groups and on access bindings to them.
* View lists of instances in placement groups.
* Use, create, modify, and delete [dedicated host groups](../../compute/concepts/dedicated-host.md#host-group-size), as well as manage access to dedicated host groups.
* View a list of dedicated host groups, information on dedicated host groups and on access bindings to them.
* View lists of [hosts](../../compute/concepts/dedicated-host.md) and instances in dedicated host groups.
* Modify scheduled maintenance windows for hosts in dedicated host groups.
* Use, create, modify, and delete [GPU clusters](../../compute/concepts/gpus.md#gpu-clusters), as well as manage access to them.
* View information on GPU clusters and instances included in GPU clusters, as well as the on access bindings to these clusters.
* Use, create, modify, move, and delete [disks](../../compute/concepts/disk.md), as well as manage access to them.
* Create [encrypted disks](../../compute/concepts/disk.md#encryption).
* View a list of disks, information on disks and on access bindings to them.
* View and update disk links.
* Use, create, modify, and delete [file storages](../../compute/concepts/filesystem.md), as well as manage access to them.
* View a list of file storages, information on file storages and on access bindings to them.
* Use, create, modify, and delete [non-replicated disk placement groups](../../compute/concepts/disk-placement-group.md), as well as manage access to non-replicated disk placement groups.
* View a list of non-replicated disk placement groups, information on non-replicated disk placement groups and on access bindings to them.
* View lists of disks in placement groups.
* Use, create, modify, and delete [images](../../compute/concepts/image.md), as well as manage access to them.
* View a list of images, information on images and on access bindings to them.
* Create, modify, delete, and update [image families](../../compute/concepts/image.md#family), as well as manage access to them.
* View information on image families, on images within families, on the latest family image, as well as on access bindings to image families.
* Use, create, modify, and delete [disk snapshots](../../compute/concepts/snapshot.md), as well as manage access to them.
* View a list of disk snapshots, information on disk snapshots and on access bindings to them.
* Create, modify, and delete [disk snapshot schedules](../../compute/concepts/snapshot-schedule.md), as well as manage access to them.
* View information on disk snapshot schedules and on access bindings to them.
* View information on [cloud networks](../../vpc/concepts/network.md#network) and use them.
* View information on [subnets](../../vpc/concepts/network.md#subnet) and use them.
* View information on [cloud resource addresses](../../vpc/concepts/address.md) and use them.
* View information on [route tables](../../vpc/concepts/routing.md#rt-vpc) and use them.
* View information on security groups and use them.
* View information on [NAT gateways](../../vpc/concepts/gateways.md) and connect them to route tables.
* View information on the IP addresses used in subnets.
* View information on resource operations for Virtual Private Cloud.
* View information on Virtual Private Cloud [quotas](../../vpc/concepts/limits.md#vpc-quotas).
* View information on Compute Cloud resource and [quota](../../compute/concepts/limits.md#compute-quotas) consumption and [disk limits](../../compute/concepts/limits.md#compute-limits-disks) in the management console.
* View lists of resource operations for Compute Cloud and information on operations, as well as abort such operations.
* View information on available [platforms](../../compute/concepts/vm-platforms.md) and use them.
* View a list of [availability zones](../../overview/concepts/geo-scope.md), information on availability zones and on access bindings to them.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role also includes the `compute.editor` and `compute.osAdminLogin` permissions.