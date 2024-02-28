---
title: "How to get information about a cloud network in {{ vpc-full-name }}"
---

# Getting information about a cloud network

To get information about a network:

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about a network:

      ```bash
      yc vpc network get --help
      ```

   1. Get information about a network by specifying its name or ID:

      ```bash
      yc vpc network get <network_name>
      ```

      Result:

      ```bash
      id: ne7w0rkfj75j********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:46Z"
      name: my-network
      description: Auto-created network
      default_security_group_id: 5ecur17yj09k********
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](subnet-get-info.md)