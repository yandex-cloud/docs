# Edit an L7 load balancer

To edit an L7 load balancer:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder that the load balancer belongs to.
  1. Select **{{ alb-name }}**.
  1. Click on the name of the load balancer you need.
  1. Click **Edit**.
  1. Edit the load balancer parameters, for example, rename the load balancer.
  1. At the bottom of the page, click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for updating the load balancer parameters:

     ```
     yc alb load-balancer update --help
     ```

  1. Run the command, indicating the new load balancer parameters:

     ```
     yc alb load-balancer update <load balancer name> --new-name <new load balancer name>
     ```

     Result:

     ```
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2-updated
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d15178sa87k0
     listeners:
     - name: test-listener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 130.193.32.206
         ports:
         - "80"
       http:
         handler:
           http_router_id: a5dv7tjdo9gt2pq5l906
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: ru-central1-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: ru-central1-c
         subnet_id: fo2ap2nrhjk9vpfdnno8
     log_group_id: eolul9ap0bv02i8bsp87
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

{% endlist %}

