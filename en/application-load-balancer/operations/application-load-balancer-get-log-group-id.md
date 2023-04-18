# Getting log group ID of L7 load balancer

To get the ID of the log group created together with the L7 load balancer to store its [logs](../concepts/application-load-balancer.md#logging):

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command to get information about the L7 load balancer:
      ```
      yc alb load-balancer get --help
      ```

   1. Run the command, specifying the name of the load balancer:
      ```
      yc alb load-balancer get <load balancer name>
      ```

      Result:
      ```
      id: a5d88ep483cmbfm63g9t
      name: test-balancer2
      folder_id: aoe197919j8elpeg1lkp
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d15178sa87k0
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hvramg61g8
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje62sqvjq5b
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9vpfdnno8
      log_group_id: eolul9ap0bv02i8bsp87
      created_at: "2021-04-26T12:12:13.624832586Z"
      ```

      The ID of the log group will be specified in the `log_group_id` field.

- API

   Use the [get](../api-ref/LoadBalancer/get.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get) gRPC API call. The ID of the log group will be specified in the `log_group_id` field.

{% endlist %}
