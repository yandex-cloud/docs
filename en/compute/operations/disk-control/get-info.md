---
title: "How to get information about a disk in {{ compute-full-name }}"
---

# Getting information about a disk

You can get the disk size, availability zone, and other disk information.

{% list tabs group=instructions %}

To get information about a disk:

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a disk:

      ```bash
      yc compute disk get --help
      ```

   1. Get information about the disk by specifying its ID or name:

      ```bash
      yc compute disk get <disk_ID>
      ```

      Result:

      ```bash
      id: epdi2r341gcq********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:14:30Z"
      name: test-disk
      type_id: network-hdd
      zone_id: ru-central1-b
      size: "21474836480"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

{% endlist %}