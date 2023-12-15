---
title: "How to get information about a backend group in {{ alb-full-name }}"
---

# Getting information about a backend group

You can view a group's ID, backends, and backend target groups.

{% list tabs %}

To get information about a backend group:

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See a description of the CLI command to get information about a backend group:

      ```bash
      yc alb backend-group get --help
      ```

   1. Get information about a backend group by specifying its name or ID:

      ```bash
      yc alb backend-group get <backend_group_name>
      ```

      Result:

      ```bash
      id: ds7maho6c4or********
      name: alb-bg
      folder_id: b1geoelk7fld********
      http:
        backends:
          - name: backend-1
            backend_weight: "1"
            port: "80"
            target_groups:
              target_group_ids:
                - ds7cjrs15ero********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthcheck_port: "80"
                http:
                  path: /
      created_at: "2023-10-24T12:22:20.870326850Z"
      ```

{% endlist %}
