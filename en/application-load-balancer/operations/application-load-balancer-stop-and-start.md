# Stop and restart an L7 load balancer

## Stop a load balancer {#stop}

The **Stop** command shuts down an L7 load balancer. Once shut down, the load balancer status changes to `STOPPED`. As long as the load balancer is stopped, you are not charged for its use.

You can re-start a load balancer at any time to continue using it. All data and changes you've made are saved.

To stop an L7 load balancer:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder the load balancer belongs to.
  1. Select **{{ alb-name }}**.
  1. To stop a single load balancer, select it and click ![image](../../_assets/horizontal-ellipsis.svg) → **Stop**.

      To apply this action to several load balancers, highlight the desired load balancers in the list, click **Stop** at the bottom of the screen, and confirm.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Review the description of the CLI load balancer stop command:

      ```bash
      yc application-load-balancer load-balancer stop --help
      ```

  1. Retrieve a list of all the load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list --format yaml
      ```

      Result:

      ```bash
      - id: ds79cfnvmti39p7k83sa
        name: test-load-balancer
        folder_id: b1gv87ssvu497lpgjh5o
        status: ACTIVE
        network_id: enp45glgitd6e44dn1fj
        listeners:
        - name: test-listener
          endpoints:
          - addresses:
            - external_ipv4_address:
                address: 51.250.35.12
            ports:
            - "80"
          http:
            handler:
              http_router_id: ds7bharmjfs30dll9r3s
        allocation_policy:
          locations:
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
            subnet_id: b0c29k6anelkik7jg5v1
        log_group_id: ckgph76s449vsca8ho9p
        created_at: "2022-02-11T09:00:31.911019416Z"
      - id: ds7o71924t0hqmu9h0n2
        name: balancer2
        folder_id: b1gv87ssvu497lpgjh5o
        status: ACTIVE
        network_id: enp45glgitd6e44dn1fj
        allocation_policy:
          locations:
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
            subnet_id: b0c29k6anelkik7jg5v1
        log_group_id: ckgjhe81a23v2miqfl7u
        created_at: "2022-02-11T09:01:46.724279145Z"
      ```

  1. Stop a balancer by including its `id` or `name` in your command, such as `balancer2`:

      ```bash
      yc application-load-balancer load-balancer stop balancer2
      ```

      For more information about the `application-load-balancer load-balancer stop` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/stop.md).

- API

  Use the gRPC API [LoadBalancerService/Stop](../api-ref/grpc/load_balancer_service.md#Stop) or the REST API [stop](../api-ref/LoadBalancer/stop.md) method.

{% endlist %}

## Start a load balancer {#start}

The **Start** command starts a stopped L7 load balancer. Once started, a load balancer changes its status to `ACTIVE`. From this point on, you will be charged for using the load balancer.

To start a load balancer:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder the load balancer belongs to.
  1. Select **{{ alb-name }}**.
  1. To start a single load balancer, select it and click ![image](../../_assets/horizontal-ellipsis.svg) → **Start**.

      To apply this action to several load balancers, highlight the desired load balancers in the list, click **Start**, and confirm.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI load balancer start command:

      ```bash
      yc application-load-balancer load-balancer start --help
      ```

  1. Retrieve a list of all the load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list --format yaml
      ```

      Result:

      ```bash
      - id: ds79cfnvmti39p7k83sa
        name: test-load-balancer
        folder_id: b1gv87ssvu497lpgjh5o
        status: ACTIVE
        network_id: enp45glgitd6e44dn1fj
        listeners:
        - name: test-listener
          endpoints:
          - addresses:
            - external_ipv4_address:
                address: 51.250.35.12
            ports:
            - "80"
          http:
            handler:
              http_router_id: ds7bharmjfs30dll9r3s
        allocation_policy:
          locations:
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
            subnet_id: b0c29k6anelkik7jg5v1
        log_group_id: ckgph76s449vsca8ho9p
        created_at: "2022-02-11T09:00:31.911019416Z"
      - id: ds7o71924t0hqmu9h0n2
        name: balancer2
        folder_id: b1gv87ssvu497lpgjh5o
        status: STOPPED
        network_id: enp45glgitd6e44dn1fj
        allocation_policy:
          locations:
          - zone_id: ru-central1-a
            subnet_id: e9bn57jvjnbujnmk3mba
          - zone_id: ru-central1-b
            subnet_id: e2ltcj4urgpbsbaq9977
          - zone_id: ru-central1-c
            subnet_id: b0c29k6anelkik7jg5v1
        log_group_id: ckgjhe81a23v2miqfl7u
        created_at: "2022-02-11T09:01:46.724279145Z"
      ```

  1. Start a balancer by including its `id` or `name` in your command, such as `balancer2`:

      ```bash
      yc application-load-balancer load-balancer start balancer2
      ```

      For more information about the `application-load-balancer load-balancer start` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/start.md).

- API

  Use the gRPC API [LoadBalancerService/Start](../api-ref/grpc/load_balancer_service.md#Start) or the REST API [start](../api-ref/LoadBalancer/start.md) method.

{% endlist %}
