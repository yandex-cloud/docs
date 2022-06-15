# Changing secondary disks in an instance template

{% note info %}

Changing disk parameters leads to instance re-creation.

{% endnote %}

The following parameters can be updated without re-creating a disk:

* `description`: Edit the disk description.
* `size`: Increase the disk size.
* `preserve_after_instance_delete`: Set or remove a flag.

When updating any other parameter of the `diskSpec` object, disks are re-created.

## Algorithm for changing secondary disks {#algorithm}

The decision to re-create a disk is made by an instance group after comparing the current and new disk specifications.

They are compared using the following algorithm:

1. For each disk in the current specification, the group searches in the new specification for a disk whose specification matches or can be met by updating the disk without re-creating it. A search in both specifications is performed sequentially, starting from the first disk.

1. If this specification is found, the disks are considered successfully mapped. If necessary, disk parameters are updated. The corresponding disks are no longer involved in the mapping process.

1. If a disk in the current specification can't be mapped to a disk in the new specification, the disk is deleted.

1. If there is a disk left in the new specification that is not mapped to any disk from the old specification, such a disk is created.

## Example of changing secondary disks {#example}

The current specification describes two secondary disks, one for 20 GB and one for 50 GB:

```json
"secondaryDiskSpecs": [
  {
    "diskSpec": {
      "preserveAfterInstanceDelete": false,
      "typeId": "network-hdd",
      "size": "21474836480"
    },
    "mode": "READ_WRITE"
  },
  {
    "diskSpec": {
      "preserveAfterInstanceDelete": false,
      "typeId": "network-hdd",
      "size": "53687091200"
    },
    "mode": "READ_WRITE"
  }
]
```

An updated specification contains two secondary disks, one for 60 GB and one for 10 GB:

```json
"secondaryDiskSpecs": [
  {
    "diskSpec": {
      "preserveAfterInstanceDelete": false,
      "typeId": "network-hdd",
      "size": "64424509440"
    },
    "mode": "READ_WRITE"
  },
  {
    "diskSpec": {
      "preserveAfterInstanceDelete": false,
      "typeId": "network-hdd",
      "size": "10737418240"
    },
    "mode": "READ_WRITE"
  }
]
```

All disk parameters, except for the disk size, are the same in both specifications.

When updating, the following actions are performed:

1. The first disk of the current specification (20 GB) is mapped to the first disk of the updated specification (60 GB). As a result, the size of the disk is increased to 60 GB without re-creating it and the data on the disk is retained.
1. The second disk of the current specification (50 GB) is not mapped to any disk of the new specification and is deleted.
1. A secondary disk of the new specification (10 GB) is created and added.
