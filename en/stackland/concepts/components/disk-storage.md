# Disk subsystem

{{ stackland-name }}'s disk subsystem ensures dynamic allocation of block storage for Kubernetes workloads.

## Architecture {#architecture}

The disk subsystem consists of four components:

* **topolvm-controller**: Central CSI controller. Processes volume creation and deletion requests and manages the `PersistentVolumeClaim` bindings to nodes.
* **topolvm-node**: Agent on each cluster node. Creates and deletes logical LVM volumes on the controller's request and provides free space metrics.
* **lvmd**: Daemon on each node. Manages LVM directly: creates and deletes logical volumes, reports the status of volume groups.
* **topovgm-operator**: Volume group management operator. Monitors `VolumeGroup` resources and synchronizes them with the actual LVM status on nodes.

This is how it works when you create a volume:

1. The user creates a `PersistentVolumeClaim` of required storage class.
1. `topolvm-controller` selects a node with enough free space in the relevant volume group.
1. `topolvm-node` creates a logical LVM volume via lvmd on the selected node.
1. Kubernetes mounts the volume to a pod.

## Disk auto-detection {#auto-discovery}

When run, `topovgm-operator` auto-detects disks on each node and creates volume groups based on disk type. A disk gets included into a volume group if it has passed all the checks.

A disk is excluded from auto-detection for the following reasons:

* `NotDisk`: The device is not a disk (partition, loop device, optical drive).
* `Removable`: Removable disk.
* `TooSmall`: The disk is smaller than the minimum allowed size.
* `SystemDisk`: System disk with OS partitions or root file system.
* `HasData`: The disk has a file system, partition table, or other data.
* `HasHolders`: The disk is used by `dm-*` or `md` devices.
* `WrongTier`: The disk belongs to a different storage tier.
* `Mounted`: The disk or its partition has been mounted.
* `ForeignLVM`: The disk belongs to a volume group not managed by the operator.
* `NoStableId`: The disk does not have a stable ID (WWN, serial number).
* `DuplicateId`: Another disk with the same ID has already been processed.
* `LockFailed`: The operator failed to put an exclusive lock on the disk.
* `ReadError`: I/O error or `udev` read error during disk check.

The detection status of each disk is displayed in the `status.discoveredDevices` field of the `VolumeGroup` resource.

## Storage Classes {#storage-classes}

{{ stackland-name }} automatically creates four storage classes matching the disk types:

* `stackland-nvme`: For NVMe disks.
* `stackland-ssd`: For SSD disks.
* `stackland-hdd`: For HDD disks.
* `stackland-other`: For other disks. Default.

All storage classes have similar properties:

* File system: XFS.
* Volume binding mode: `WaitForFirstConsumer`, i.e., the volume is created only after a pod is scheduled for the node.
* Tom expansion: Allowed.

To use a specific storage class, specify its name in the `PersistentVolumeClaim` manifest:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
  namespace: my-project
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: stackland-ssd
  resources:
    requests:
      storage: 10Gi
```

If `storageClassName` is not specified, the default storage class set in `StacklandClusterConfig.spec.storage.defaultStorageClass` is used. For more information, see [Initial configuration](../../quickstart.md#configuration).

## VolumeGroup resource {#volumegroup}

The `VolumeGroup` resource describes the desired LVM volume group state on a particular node. `topovgm-operator` monitors these resources and syncs them with the actual LVM state.

Example of a `VolumeGroup` resource with disks selected based on rotation:

```yaml
apiVersion: topolvm.io/v1alpha1
kind: VolumeGroup
metadata:
  name: stackland-ssd
spec:
  nodeName: <node_name>
  physicalVolumeSelector:
    - matchLSBLK:
        - key: ROTA
          operator: In
          values:
            - "0"
```

Example of a `VolumeGroup` resource with disks named explicitly:

```yaml
apiVersion: topolvm.io/v1alpha1
kind: VolumeGroup
metadata:
  name: stackland-nvme
spec:
  nodeName: <node_name>
  physicalVolumeSelector:
    - matchLSBLK:
        - key: PATH
          operator: In
          values:
            - /dev/nvme0n1
            - /dev/nvme1n1
```

### VolumeGroup properties {#volumegroup-params}

* `spec.nodeName`: Name of the node the volume group is created on. This is a permanent property.
* `spec.physicalVolumeSelector`: Selector of physical volumes. If not specified, the operator selects disks automatically.
* `spec.deviceLossSynchronizationPolicy`: Behavior if the disk is lost:
  * `Fail` (default): Synchronization stops until the disk is recovered or until there is a manual intervention.
  * `Remove`: Missing physical volumes are deleted from the volume group if not containing logical volumes.
  * `ForceRemove`: Deletion of missing physical volumes is forced, even if they contain logical volumes. This may result in data loss.
* `spec.deviceRemovalVolumePolicy`: Behavior if the disk is deleted from the selector:
  * `MoveAndReduce` (default): Data is migrated to the remaining disks before the volume group is reduced.
  * `Reduce`: Immediate reduction of the volume group. Will end with an error if the disk contains logical volumes.
  * `ForceReduce`: Forced reduction of the volume group. This may result in data loss.
* `spec.tags`: Volume group tags in LVM.
* `spec.allocationPolicy`: Extent allocation policy. The possible values are `Normal`, `Contiguous`, `Cling`, `Anywhere`, `ClingByTags`, and `Inherit`.

### VolumeGroup status {#volumegroup-status}

The `status.conditions` field contains the `VolumeGroupSyncedOnNode` condition:

* `True`: Volume group is present on the node and available in LVM.
* `False`: Synchronization not done. The reason is specified in the `reason` field.

## Monitoring {#monitoring}

### Metrics {#metrics}

The disk subsystem provides Prometheus metrics.

TopoLVM (lvmd) metrics:

* `topolvm_volumegroup_available_bytes`: Available space in the volume group on the node.
* `topolvm_volumegroup_size_bytes`: Total size of the volume group on the node.

TopoVGM metrics:

* `topovgm_volumegroup_status`: Volume group status. The possible values are `healthy`, `sync_failed`, and `init_failed`.
* `topovgm_volumegroup_sync_errors_total`: Synchronization error count.
* `topovgm_volumegroup_last_sync_timestamp_seconds`: Time of the last successful synchronization.
* `topovgm_volumegroup_reconcile_duration_seconds`: Reconciliation cycle duration.
* `topovgm_volumegroup_phantom_device`: Phantom device detection. If set to `1`, it means the physical volume is present in LVM, but its block device is is not in `sysfs`. There are no write errors, but the data gets lost.

### Alerts {#alerts}

{{ stackland-name }} includes ready-to-use alerts for the disk subsystem:

* `VolumeGroupSpaceCritical` (critical): Less than 10% of free space is left in the volume group.
* `VolumeGroupSpaceLow` (warning): Less than 20% of free space is left in the volume group.
* `VolumeGroupMissing` (critical): Volume group is not found on the node.
* `VolumeGroupMetricsStale` (critical): Volume group metrics have not been updated for more than five minutes.
* `VolumeGroupWillFillIn4Hours` (warning): According to the hourly trend, the volume group will run out of free space in less than four hours.
* `VolumeGroupHealthDegraded` (critical): Volume group is in `sync_failed` or `init_failed` status.
* `VolumeGroupSyncErrors` (warning): Volume group synchronization errors.
* `VolumeGroupNotSyncing` (warning): Volume group has not been synchronized for more than 10 minutes.
* `TopoLVMControllerDown` (critical): TopoLVM controller is not available.
* `TopoLVMNodeDown` (critical): TopoLVM agent on the node is not available.
* `TopoLVMLvmdDown` (critical): `lvmd` daemon on the node is not available.
* `TopoVGMOperatorDown` (warning): TopoVGM operator is not available.
* `PersistentVolumeClaimPending` (warning): PVC has been in Pending status for more than five minutes.
* `TopoVGMReconcileErrors` (warning): High error rate of the VolumeGroup reconcile controller.
* `TopoVGMReconcileLatencyHigh` (warning): P95 latency of the VolumeGroup reconcile controller exceeds 10 seconds.
* `TopoVGMWorkQueueDepthHigh` (warning): VolumeGroup controller queue has over 100 elements.
* `StorageControllerReconcileErrors` (warning): Reconcile errors in other storage controllers in the `stackland-volumes` namespace.
* `VolumeGroupNeverSynced` (warning): Operator has been at work for more than 10 minutes, but none of the volume groups were synchronized.
* `VolumeGroupReconcileSlow` (warning): P95 reconcile duration of the volume group on the node exceeds 10 seconds.

Disk subsystem alerts complement [hardware monitoring](../../concepts/hardware-monitoring.md), which tracks the physical condition of the disks (SMART, I/O errors, and temperature).

### Grafana dashboard {#grafana-dashboard}

The disk subsystem metrics are available in Grafana. To open a dashboard:

1. Go to `grafana.sys.{{ cluster-domain }}`.
1. Open **Dashboards > stackland-monitoring > Storage**.
