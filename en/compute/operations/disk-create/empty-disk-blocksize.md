---
title: How to create an empty disk with a large block
description: Follow this guide to create an empty disk with a large block.
---

# Creating an empty disk with a large block


{% include [default-catalogue](../../../_includes/compute/disk-blocksize.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  See [{#T}](../../../compute/operations/disk-create/empty.md).

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the CLI commands for creating disks:

        ```bash
        yc compute disk create --help
        ```

    1. Create a disk in the default folder:

        ```bash
        yc compute disk create \
          --name big-disk \
          --zone <availability_zone> \
          --block-size 8K \
          --size 40G \
          --description "my 8k blocksize disk via yc"
        ```

       Where:
       * `--name`: Disk name. The disk naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

       * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) of the new disk. If the availability zone is not set in the [CLI profile](../../../cli/concepts/core-properties.md) by default, the parameter is required.
       * `--block-size`: Disk block size.
       * `--size`: Disk size.
       * `--description`: Disk description.

       This command will create a 40 GB disk with 8 KB block size, named `big-disk` and described as `my 8k blocksize disk via yc`.


    1. Get a list of disks in the default folder:

       {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

       Get the same list with more details in YAML format:

        ```bash
        yc compute disk list --format yaml
        ```

        Result:
        ```text
        - id: fhmm0br99mig********
           folder_id: b1gb9jeqoior********
           created_at: "2021-01-11T09:35:05Z"
           name: big-disk
           description: 8k blocksize disk
           type_id: network-hdd
           zone_id: {{ region-id }}-a
           size: "42949672960"
           block_size: "8192"
           status: READY
           disk_placement_policy: {}
        ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

- API {#api}

  Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}


#### Useful links {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
