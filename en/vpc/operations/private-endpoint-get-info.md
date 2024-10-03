---
title: How to get information about a service connection in {{ vpc-full-name }}
description: Follow this guide to get information about a service connection (Private Endpoint) in VPC.
---

# Getting information about a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. View the description of the CLI command for information about a service connection (Private Endpoint):

      ```bash
      yc vpc private-endpoint get --help
      ```

  1. Get information about a service connection by specifying its name or ID:

     ```bash
     yc vpc private-endpoint get s3-vpc-link
     ```

     Command result:
     ```text
     id: enpd7***************
     folder_id: b1g23***************
     created_at: "2024-08-31T16:23:33.859574Z"
     name: s3-vpc-link
     description: Private Endpoint to the Object Storage
     network_id: enpgi***************
     status: AVAILABLE
     address:
       subnet_id: e2l8b***************
       address: 10.128.0.10
       address_id: e2ldn***************
     dns_options: {}
     object_storage: {}
     ```

{% endlist %}
