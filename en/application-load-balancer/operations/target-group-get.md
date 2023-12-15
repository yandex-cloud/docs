---
title: "How to get information about a target group in {{ alb-full-name }}"
---

# Getting information about a target group

You can view a group's ID and resources.

{% list tabs %}

To get information about a target group:

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See a description of the CLI command to get information about a target group:

      ```bash
      yc alb target-group get --help
      ```

   1. Get information about the target group by specifying its ID or name:

      ```bash
      yc alb target-group get <target_group_name>
      ```

      Result:

      ```bash
      id: ds7cjrs15ero********
      name: alb-tg
      folder_id: b1geoelk7fld********
      targets:
        - ip_address: 192.168.3.34
          subnet_id: b0cqh32phmc1********
        - ip_address: 192.168.2.4
          subnet_id: e2ltekraekpc********
        - ip_address: 192.168.1.10
          subnet_id: e9bns2fv233c********
      created_at: "2023-10-24T12:21:09.159841076Z"
      ```

{% endlist %}
