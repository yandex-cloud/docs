The `compute.viewer` role allows you to view information on Compute Cloud resources and resource operations, as well as on access permissions assigned to the resources and on the amount of used resources and quotas. This role also grants access to instance metadata and serial port output.

{% cut "Users with this role can:" %}

* View the instance [serial port output](../../compute/operations/vm-info/get-serial-port-output.md).
* View instance [metadata](../../compute/concepts/vm-metadata.md).
* View a list of [instances](../../compute/concepts/vm.md), information on instances and on [access permissions](../../iam/concepts/access-control/index.md) assigned to them.
* View a list of [instance groups](../../compute/concepts/instance-groups/index.md) and information on them.
* View a list of [instance placement groups](../../compute/concepts/placement-groups.md), information on instance placement groups and on access permissions assigned to them.
* View lists of instances in placement groups.
* View a list of [dedicated host groups](../../compute/concepts/dedicated-host.md#host-group-size), information on dedicated host groups and on access permissions assigned to them.
* View lists of [hosts](../../compute/concepts/dedicated-host.md) and instances in dedicated host groups.
* View information on [GPU clusters](../../compute/concepts/gpus.md#gpu-clusters) and instances included in GPU clusters, as well as the on access permissions assigned to these clusters.
* View a list of [disks](../../compute/concepts/disk.md), information on disks and on access permissions assigned to them.
* View a list of [file storages](../../compute/concepts/filesystem.md), information on file storages and on access permissions assigned to them.
* View a list of [non-replicated disk placement groups](../../compute/concepts/disk-placement-group.md), information on non-replicated disk placement groups and on access permissions assigned to them.
* View lists of disks in placement groups.
* View a list of [images](../../compute/concepts/image.md), information on images and on access permissions assigned to them.
* View information on [image families](../../compute/concepts/image.md#family), on images within families, on the latest family image, as well as on access permissions assigned to image families.
* View a list of [disk snapshots](../../compute/concepts/snapshot.md), information on disk snapshots and on access permissions assigned to them.
* View information on [disk snapshot schedules](../../compute/concepts/snapshot-schedule.md) and on access permissions assigned to them.
* View information on Compute Cloud resource and [quota](../../compute/concepts/limits.md#compute-quotas) consumption and [disk limits](../../compute/concepts/limits.md#compute-limits-disks) in the management console.
* View lists of resource operations for Compute Cloud, as well as information on these operations.
* View information on the status of configuring access via [OS Login](../../organization/concepts/os-login.md) on instances.
* View information on available [platforms](../../compute/concepts/vm-platforms.md).
* View a list of [availability zones](../../overview/concepts/geo-scope.md), information on availability zones and on access permissions assigned to them.

{% endcut %}

This role includes the `compute.auditor` permissions.