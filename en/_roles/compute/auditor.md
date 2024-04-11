The `compute.auditor` role allows you to view information on Compute Cloud resources and relevant operations, as well as on the amount of used resources and quotas. It does not allow you to access the serial port or serial console of an instance.

{% cut "Users with this role can:" %}

* View a list of [instances](../../compute/concepts/vm.md) and information on them.
* View a list of [instance groups](../../compute/concepts/instance-groups/index.md) and information on them.
* View a list of [instance placement groups](../../compute/concepts/placement-groups.md) and information on them.
* View lists of instances in placement groups.
* View a list of [dedicated host groups](../../compute/concepts/dedicated-host.md#host-group-size) and information on them.
* View lists of [hosts](../../compute/concepts/dedicated-host.md) and instances in dedicated host groups.
* View information on [GPU clusters](../../compute/concepts/gpus.md#gpu-clusters) and instances included in these clusters.
* View a list of [disks](../../compute/concepts/disk.md) and information on them.
* View a list of [file storages](../../compute/concepts/filesystem.md) and information on them.
* View a list of [non-replicated disk placement groups](../../compute/concepts/disk-placement-group.md) and information on them.
* View lists of disks in placement groups.
* View a list of [images](../../compute/concepts/image.md) and information on them.
* View information on [image families](../../compute/concepts/image.md#family), on images within families, on the latest family image, as well as on [access bindings](../../iam/concepts/access-control/index.md#access-bindings) to image families.
* View a list of [disk snapshots](../../compute/concepts/snapshot.md) and information on them.
* View information on disk snapshot [schedules](../../compute/concepts/snapshot-schedule.md).
* View information on Compute Cloud resource and [quota](../../compute/concepts/limits.md#compute-quotas) consumption and [disk limits](../../compute/concepts/limits.md#compute-limits-disks) in the management console.
* View lists of resource operations for Compute Cloud, as well as information on these operations.
* View information on the status of configuring access via [OS Login](../../organization/concepts/os-login.md) on instances.
* View information on available [platforms](../../compute/concepts/vm-platforms.md).
* View a list of [availability zones](../../overview/concepts/geo-scope.md) and information on them.

{% endcut %}