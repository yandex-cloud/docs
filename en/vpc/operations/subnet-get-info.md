---
title: "How to get information about a subnet in {{ vpc-full-name }}"
---

# Getting information about a subnet

To get information about a subnet:

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a subnet:

      ```bash
      yc vpc subnet get --help
      ```

   1. Get information about a subnet by specifying its name or ID:

      ```bash
      yc vpc subnet get <subnet_name>
      ```

      Result:

      ```bash
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-{{ region-id }}-a
      description: Auto-created default subnet for zone {{ region-id }}-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-get-info.md)