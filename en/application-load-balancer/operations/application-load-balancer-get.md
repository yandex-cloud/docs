---
title: "How to get information about an L7 load balancer in {{ alb-full-name }}"
---

# Getting information about an L7 load balancer

You can view a load balancer's ID, listeners, location, security groups, and logging settings.

{% list tabs group=instructions %}

To get information about an L7 load balancer:

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command to get information about the L7 load balancer:

      ```bash
      yc alb load-balancer get --help
      ```

   1. Get information about a load balancer by specifying its name or ID:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

      Result:

      ```bash
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje6********
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

{% endlist %}
