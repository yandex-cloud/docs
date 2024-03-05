---
title: "How to get information about a disk snapshot in {{ compute-full-name }}"
---

# Getting information about a disk snapshot

You can view your snapshot ID, creation time, and disk size.

To get information about a disk snapshot:

{% list tabs %}

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a disk snapshot:

      ```bash
      yc compute snapshot get --help
      ```

   1. Get information about your disk snapshot by specifying its name or ID:

      ```bash
      yc compute snapshot get <snapshot_name>
      ```

      Result:

      ```
      id: fd8if7bg95dm********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:52:37Z"
      name: fhm0r72q6mvq********-1698677556360
      storage_size: "3779067904"
      disk_size: "34359738368"
      product_ids:
        - f2ebcrn2h53v********
        - f2e8f6be9gr1********
      status: READY
      source_disk_id: fhm0r72q6mvq********
      ```

{% endlist %}