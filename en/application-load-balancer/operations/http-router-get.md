---
title: "How to get information about an HTTP router in {{ alb-full-name }}"
---

# Getting information about an HTTP router

You can view a router's ID, its hosts, and routes in the hosts.

{% list tabs group=instructions %}

To get information about an HTTP router:

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See a description of the CLI command to get information about an HTTP router:

      ```bash
      yc alb http-router get --help
      ```

   1. Get information about an HTTP router by specifying its ID or name:

      ```bash
      yc alb http-router get <HTTP_router_name>
      ```

      Result:

      ```bash
      id: ds7u8nv8gl2s********
      name: alb-router
      folder_id: b1geoelk7fld********
      virtual_hosts:
        - name: alb-host
          authority:
            - www.first-site.ru
            - first-site.ru
          routes:
            - name: route-1
              http:
                route:
                  backend_group_id: ds7maho6c4or********
      created_at: "2023-10-24T12:20:44.091821711Z"
      ```

{% endlist %}
