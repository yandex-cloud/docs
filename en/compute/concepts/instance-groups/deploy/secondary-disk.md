---
title: Updating secondary disks in an instance template
description: This guide tells you how to update secondary disks in an instance template.
---

# Updating secondary disks in an instance template

{% note info %}

Changing disk parameters leads to instance recreation.

{% endnote %}

The following parameters can be updated without recreating a disk:

* `description`: Editing disk description.
* `size`: Increasing disk size.
* `preserve_after_instance_delete`: Setting or removing a flag.

If you update any other parameter of the `disk_spec` object or decrease the disk size, the disk is recreated.

## Algorithm for updating secondary disks {#algorithm}

The decision to reconfigure or recreate a disk is based on one of the mapping algorithms:

* [By disk names](#algorithm-names): Mapping the `name` parameter values (main method).
* [By disk parameters](#algorithm-parameters): Mapping other parameter values (deprecated method).

### Mapping by name {#algorithm-names}

This algorithm maps disk names between the current and new [YAML specifications](../specification.md). The system deletes the disks with names missing in the new specification. The system creates the disks with names missing in the current specification. You can uniquely identify a disk you want to update, add, or delete.

To use name-based mapping for disks, give a unique `name` to each disk in the YAML specification.

{% note info %}

In the same specification, names should be assigned either to all secondary disks or none of them.

{% endnote %}

When you change from the [deprecated algorithm](#algorithm-parameters) to the name-based mapping algorithm, the very first time the disks will be mapped by parameters. On subsequent runs, they will be mapped by names.

#### Example of secondary disk mapping by names {#example-names}

The current specification describes two secondary disks, a 20 GB one and a 50 GB one:

```yaml
instance_template:
...
  secondary_disk_specs:
    - name: disk-2
      mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 21474836480
    - name: disk-3
      mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 53687091200
...
```

An updated specification contains two secondary disks, a 60 GB one and a 10 GB one:

```yaml
instance_template:
...
  secondary_disk_specs:
    - name: disk-2
      mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 64424509440
    - name: disk-4
      mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 10737418240
...
```

When updating, the following actions will be performed:

1. The disk named `disk-2` from the current specification will be mapped to `disk-2` from the updated specification because their names match. Its size will be increased to 60 GB without recreation, the data on the disk will be preserved.
1. `disk-3` will be deleted from the current specification because there is no such disk in the updated specification.
1. `disk-4` from the updated specification will be created and added because there is no such disk in the current specification.

### Mapping by parameters {#algorithm-parameters}

{% note info %}

The parameter-based mapping algorithm for secondary disks does uniquely identify disks within an instance and is deprecated. Use [name-based disk mapping](#algorithm-names).

{% endnote %}

If disk names are not used in the specification, the mapping and updating follow this algorithm:

1. For each disk in the current specification, the group searches through the new specification for:

   * A disk with the same parameters.
   * A disk with parameters that can be obtained without recreation.

   The two specifications are searched sequentially, starting from the first disk.

1. If the disk is found, the disks are considered successfully mapped. If needed, the disk parameters are changed according to the new specification. From then on, these disks take no part in further mapping.
1. If a disk from the current specification cannot be matched with a disk in the new specification, the disk is deleted.
1. If the new specification has a disk left unmapped to any disk from the old specification, such a disk gets created.

#### Example of secondary disk mapping by parameters {#example-parameters}

The current specification describes two secondary disks, a 20 GB one and a 50 GB one:

```yaml
instance_template:
...
  secondary_disk_specs:
    - mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 21474836480
    - mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 53687091200
...
```

An updated specification contains two secondary disks, a 60 GB one and a 10 GB one:

```yaml
instance_template:
...
  secondary_disk_specs:
    - mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 64424509440
    - mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 10737418240
...
```

All disk parameters, except for disk size, are the same in both specifications.

When updating, the following actions will be performed:

1. The first disk in the current specification (20 GB) will be mapped to the first disk in the updated specification (60 GB). Its size will be increased to 60 GB without recreation, the data on the disk will be preserved.
1. The second disk of the current specification (50 GB) will not be mapped to any disk of the new specification and will be deleted.
1. A secondary disk of the new specification (10 GB) will be created and added.

## Use cases {#examples}

* [{#T}](../../../tutorials/updating-under-load.md)
