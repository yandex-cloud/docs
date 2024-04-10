---
title: "How to get information about file storage in {{ compute-full-name }}"
---

# Getting information about file storage

You can get the file storage size, availability zone, and other file storage information.

{% list tabs group=instructions %}

To get information about file storage:

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about file storage:

      ```bash
      yc compute filesystem get --help
      ```

   1. Get information about the file storage by specifying its ID or name:

      ```bash
      yc compute filesystem get <file_storage_ID>
      ```

      Result:

      ```bash
      id: epdt429j3unu********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:15:53Z"
      name: test-filesystem
      type_id: network-hdd
      zone_id: {{ region-id }}-b
      size: "1073741824"
      block_size: "4096"
      status: READY
      ```

{% endlist %}