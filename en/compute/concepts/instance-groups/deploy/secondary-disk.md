---
title: Updating secondary disks in an instance template
description: This guide tells you how to update secondary disks in an instance template.
---

# Updating secondary disks in an instance template

{% note info %}

Changing disk parameters leads to instance re-creation.

{% endnote %}

The following parameters can be updated without re-creating a disk:

* `description`: Edit disk description.
* `size`: Increase disk size.
* `preserve_after_instance_delete`: Set or remove a flag.

If you update any other parameter of the `diskSpec` object or decrease disk size, the disk is re-created.

## Algorithm for updating secondary disks {#algorithm}

The decision to update parameters or re-create a disk is based on one of the matching algorithms:

* [By disk names](#algorithm-names): Matching the `name` parameter values (main method).
* [By disk parameters](#algorithm-parameters): Matching the values of other parameters (deprecated method).

### Matching by name {#algorithm-names}

This algorithm matches disk names between the current and new [YAML specifications](../specification.md). The system deletes the disks with names missing in the new specification. The system creates the disks with names missing in the current specification. You can uniquely identify a disk you want to update, add, or delete.

To use the name-matching algorithm for disks, assign a unique `name` for each disk in the YAML specification.

{% note info %}

In the same specification, names should be assigned either to all secondary disks or none of them.

{% endnote %}

When you change from the [deprecated algorithm](#algorithm-parameters) to the name-matching algorithm, on the first run, disks are matched by parameters. On the following runs, they are matched by names.

#### Example of matching secondary disks by names {#example-names}

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

1. `disk-2` in the current specification will be matched against `disk-2` in the updated specification because their names match. Its size will be increased to 60 GB without re-creation, the data on the disk will be preserved.
1. `disk-3` in the current specification will be deleted because there is no such disk in the updated specification.
1. `disk-4` from the updated specification will be created and added because there is no such disk in the current specification.

### Matching by parameters {#algorithm-parameters}

{% note info %}

The algorithm for matching secondary disks by parameters does not provide clear disk identification within an instance and is deprecated. Use [disk matching by names](#algorithm-names).

{% endnote %}

If disk names are not used in the specification, the matching and updating follow this algorithm:

1. For each disk in the current specification, the group searches through the new specification for:

   * A disk with the same parameters.
   * A disk with parameters that can be obtained without re-creation.

   The two specifications are searched sequentially, starting from the first disk.

1. If such a disk is found, the disks are considered successfully matched. If needed, the disk parameters are changed according to the new specification. From then on, these disks are not taking part in the matching.
1. If a disk from the current specification cannot be matched with a disk in the new specification, the disk is deleted.
1. If there is a disk left in the new specification that is not matched with any disk from the old specification, the disk is created.

#### Example of matching secondary disks by parameters {#example-parameters}

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

1. The first disk in the current specification (20 GB) will be matched with the first disk in the updated specification (60 GB). Its size will be increased to 60 GB without re-creation, the data on the disk will be preserved.
1. The second disk of the current specification (50 GB) is not matched with any disk of the new specification and will be deleted.
1. A secondary disk of the new specification (10 GB) will be created and added.
