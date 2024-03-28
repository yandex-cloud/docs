---
title: "How to get information about a disk placement group in {{ compute-full-name }}"
---

# Getting information about a disk placement group

You can get the folder ID, availability zone, and other information about a disk placement group.

{% list tabs group=instructions %}

To get information about a disk placement group:

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a disk placement group:

      ```bash
      yc compute disk-placement-group get --help
      ```

   1. Get information about the disk placement group by specifying its ID or name:

      ```bash
      yc compute disk-placement-group get <disk_placement_group_ID>
      ```

      Result:

      ```bash
      id: d9h3qkknmtsl********
      folder_id: aoe3hggkil3t********
      created_at: "2023-10-27T13:01:20Z"
      name: test-placement-group
      zone_id: {{ region-id }}-d
      status: READY
      spread_placement_strategy: {}
      ```

{% endlist %}