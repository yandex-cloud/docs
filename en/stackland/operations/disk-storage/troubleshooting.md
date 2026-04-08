# Diagnosing a disk subsystem

This page describes the typical issues of a {{ stackland-name }} disk subsystem and how to fix them.

## Status diagnostics {#diagnostics}

Check the status of volume groups on all nodes:

```bash
kubectl get volumegroups -A -o wide
```

Check synchronization conditions:

```bash
kubectl get volumegroups -A -o custom-columns="NAME:.metadata.name,NODE:.spec.nodeName,REASON:.status.conditions[0].reason,STATUS:.status.conditions[0].status"
```

For detailed diagnostics, connect to the `topovgm-operator` pod on the relevant node. All LVM utilities are available in the pod:

```bash
kubectl -n stackland-volumes exec -it <topovgm_pod_name> -- sh
```

Run the following LVM commands inside the pod:

```bash
pvs   # List of physical volumes
vgs   # List of volume groups
lvs   # List of logical volumes
```

## Common issues {#common-issues}

This section lists the typical issues of a disk subsystem and relevant fixes.

### VolumeGroupSyncedOnNode = False {#vg-not-synced}

The `VolumeGroupSyncedOnNode` condition in the `VolumeGroup` resource status is set to `False`.

* The disk is missing or available. Check the physical connection of the disk. Run `pvs` in the `topovgm-operator` pod and make sure that all physical volumes are visible.
* Volume Group initialization error. Check the operator logs:

  ```bash
  kubectl -n stackland-volumes logs -l app.kubernetes.io/name=topovgm-operator --tail=100
  ```

* The disk contains data and was not auto-detected. Check the `status.discoveredDevices` field of the `VolumeGroup` resource: it will state the reason why the disk was excluded.

### PhantomDeviceDetected {#phantom-device}

The `PhantomDeviceDetected` condition on the node. This means the disk which earlier belonged to the volume group is now temporarily unavailable, but its metadata was preserved in LVM.

1. Check the physical connection of the disk.
1. If the disk was reconnected, the operator will automatically update the `device-mapper` tables and restore the volume group.
1. If the disk was replaced, follow the [corrupt disk replacement](#disk-replacement) procedure.

### PVC froze in Pending status {#pvc-pending}

`PersistentVolumeClaim` is in `Pending` status for a long time.

* Not enough storage space in the volume group of required type. Check for free space:

  ```bash
  kubectl get volumegroups -A -o custom-columns="NAME:.metadata.name,NODE:.spec.nodeName,FREE:.status.free,SIZE:.status.size"
  ```

* A non-existing storage class is specified. Check the storage class name in the PVC manifest. The valid values are `stackland-nvme`, `stackland-ssd`, `stackland-hdd`, and `stackland-other`.
* No disks of required type on the nodes. For example, if `stackland-nvme` is specified, but there are no NVMe disks, no volume group will be created for this type.

### Disk I/O errors {#io-errors}

The `DiskIOErrors` alert triggers in [hardware monitoring](../../concepts/hardware-monitoring.md). Applications report write or read errors.

1. Identify the defective disk based on the **Hardware Monitoring** dashboard in Grafana.
1. If, according to [SMART monitoring](../../concepts/hardware-monitoring.md), the disk is defective, follow the [corrupt disk replacement](#disk-replacement) procedure.

## Corrupt disk replacement {#disk-replacement}

{% note warning %}

Before replacing a disk, make sure its data is backed up or replicated. If the disk has logical volumes containing unreplicated data, this data will be lost.

{% endnote %}

### Step 1: Identify the corrupt disk {#identify-disk}

Find the volume group with the defective disk:

```bash
kubectl get volumegroups -A -o wide
```

Get detailed status of the volume group:

```bash
kubectl describe volumegroup <vg_name> -n stackland-volumes
```

In the `status.physicalVolumes` field, find a disk with the `attributes` attribute containing the `m` (missing) property.

Connect to the `topovgm-operator` pod on the relevant node and check the status of its physical volumes:

```sh
kubectl -n stackland-volumes exec -it <topovgm_pod_name> -- pvs
```

### Step 2: Transfer data from the disk (if possible) {#move-data}

If the disk is still available and there is data on it, transfer it to other disks in the volume group:

```sh
kubectl -n stackland-volumes exec -it <topovgm_pod_name> -- pvmove /dev/<disk_name>
```

If the disk is completely unavailable, skip this step.

### Step 3: Delete the disk from the volume group {#remove-from-vg}

If the disk is unavailable, set the following deletion policy in the `VolumeGroup` resource. To delete without data:

```bash
kubectl patch volumegroup <vg_name> -n stackland-volumes --type=merge \
  -p '{"spec":{"deviceLossSynchronizationPolicy":"Remove"}}'
```

The operator will automatically run `vgreduce --removemissing` and delete the missing physical volume from the volume group.

When done, set the policy back to its original value:

```bash
kubectl patch volumegroup <vg_name> -n stackland-volumes --type=merge \
  -p '{"spec":{"deviceLossSynchronizationPolicy":"Fail"}}'
```

### Step 4: Replace the physical disk {#replace-physical}

Physically replace the disk in the server as per the manufacturer documentation.

### Step 5: Make sure the new disk has been detected {#verify-discovery}

Once the disk is replaced, `topovgm-operator` will automatically detect the new disk during the next reconciliation cycle.

If auto-detection is on (`physicalVolumeSelector` not set), the new disk will be added to the volume group automatically.

If an explicit selector is used (`physicalVolumeSelector` with specific paths), update the `VolumeGroup` resource by specifying a path to the new disk:

```bash
kubectl edit volumegroup <vg_name> -n stackland-volumes
```

### Step 6: Check the recovery {#verify-recovery}

Make sure that the volume group is synchronized:

```bash
kubectl get volumegroup <vg_name> -n stackland-volumes -o jsonpath='{.status.conditions[0]}'
```

The `VolumeGroupSyncedOnNode` condition should be set to `True`.

Check the volume group's status in LVM:

```sh
kubectl -n stackland-volumes exec -it <topovgm_pod_name> -- vgs
```
