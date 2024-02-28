---
title: "How to get information about a DNS zone in {{ dns-full-name }}"
---

# Getting information about a DNS zone

To get information about a DNS zone:

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a DNS zone:

      ```bash
      yc dns zone get --help
      ```

   1. Get information about a DNS zone by specifying its name or ID:

      ```bash
      yc dns zone get <DNS_zone_name>
      ```

      Result:

      ```bash
      id: dns6oh57qm9n********
      folder_id: f01derqpemb4********
      created_at: "2023-11-02T08:34:58.493Z"
      name: example.com.
      zone: example-zone-name
      public_visibility: {}
      ```

{% endlist %}
