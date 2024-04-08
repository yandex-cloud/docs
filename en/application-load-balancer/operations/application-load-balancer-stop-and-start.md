---
title: "How to stop and restart an L7 load balancer in {{ alb-full-name }}"
description: "In this tutorial, you will learn how to stop and restart an L7 load balancer in {{ alb-name }}."
---

# Stopping and restarting an L7 load balancer

## Stopping a load balancer {#stop}

The **{{ ui-key.yacloud.common.stop }}** command shuts down an [L7 load balancer](../concepts/application-load-balancer.md). Once shut down, the load balancer status changes to `STOPPED`. As long as the load balancer is stopped, you are not charged for its use.

You can restart a load balancer at any time to continue using it. All the data and changes you have made are saved.

To stop an L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer name and select **{{ ui-key.yacloud.common.stop }}**.

      To apply this action to multiple load balancers, select the appropriate load balancers in the list, click **{{ ui-key.yacloud.common.stop }}** at the bottom of the screen, and then click **{{ ui-key.yacloud.common.stop }}** in the window that opens.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Review the description of the CLI load balancer stop command:

      ```bash
      yc application-load-balancer load-balancer stop --help
      ```

   1. Get a list of all load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list --format yaml
      ```

      Result:

      
      ```bash
      - id: ds79cfnvmti3********
        name: test-load-balancer
        folder_id: b1gv87ssvu49********
        status: ACTIVE
        network_id: enp45glgitd6********
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
              http_router_id: ds7bharmjfs3********
        allocation_policy:
          locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bn57jvjnbu********
          - zone_id: {{ region-id }}-b
            subnet_id: e2ltcj4urgpb********
          - zone_id: {{ region-id }}-d
            subnet_id: b0c29k6anelk********
        log_group_id: ckgph76s449v********
        created_at: "2022-02-11T09:00:31.911019416Z"
      - id: ds7o71924t0h********
        name: balancer2
        folder_id: b1gv87ssvu49********
        status: ACTIVE
        network_id: enp45glgitd********
        allocation_policy:
          locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bn57jvjnbu********
          - zone_id: {{ region-id }}-b
            subnet_id: e2ltcj4urgpb********
          - zone_id: {{ region-id }}-d
            subnet_id: b0c29k6anelk********
        log_group_id: ckgjhe81a23v********
        created_at: "2022-02-11T09:01:46.724279145Z"
      ```



   1. Stop the load balancer by including its ID or name in the command below:

      ```bash
      yc application-load-balancer load-balancer stop <load_balancer_name>
      ```

      For more information about the `application-load-balancer load-balancer stop` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/stop.md).

- API {#api}

   Use the [stop](../api-ref/LoadBalancer/stop.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Stop](../api-ref/grpc/load_balancer_service.md#Stop) gRPC API call.

{% endlist %}

## Start a load balancer {#start}

The **{{ ui-key.yacloud.common.start }}** command starts a stopped L7 load balancer. Once started, a load balancer changes its status to `ACTIVE`. From this point on, you will be charged for using the load balancer.

To start a load balancer:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer name and select **{{ ui-key.yacloud.common.start }}**.

      To apply this action to multiple load balancers, select the appropriate load balancers in the list, click **{{ ui-key.yacloud.common.start }}** at the bottom of the screen, and then click **{{ ui-key.yacloud.common.start }}** in the window that opens.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI load balancer start command:

      ```bash
      yc application-load-balancer load-balancer start --help
      ```

   1. Get a list of all load balancers in the default folder:

      ```bash
      yc application-load-balancer load-balancer list --format yaml
      ```

      Result:

      
      ```bash
      - id: ds79cfnvmti3********
        name: test-load-balancer
        folder_id: b1gv87ssvu49********
        status: ACTIVE
        network_id: enp45glgitd6********
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
              http_router_id: ds7bharmjfs3********
        allocation_policy:
          locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bn57jvjnbu********
          - zone_id: {{ region-id }}-b
            subnet_id: e2ltcj4urgpb********
          - zone_id: {{ region-id }}-d
            subnet_id: b0c29k6anelk********
        log_group_id: ckgph76s449v********
        created_at: "2022-02-11T09:00:31.911019416Z"
      - id: ds7o71924t0h********
        name: balancer2
        folder_id: b1gv87ssvu49********
        status: STOPPED
        network_id: enp45glgitd********
        allocation_policy:
          locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bn57jvjnbu********
          - zone_id: {{ region-id }}-b
            subnet_id: e2ltcj4urgpb********
          - zone_id: {{ region-id }}-d
            subnet_id: b0c29k6anelk********
        log_group_id: ckgjhe81a23v********
        created_at: "2022-02-11T09:01:46.724279145Z"
      ```



   1. Start the load balancer by including its ID or name in the command below:

      ```bash
      yc application-load-balancer load-balancer start <load_balancer_name>
      ```

      For more information about the `application-load-balancer load-balancer start` command, see the [CLI reference](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/start.md).

- API {#api}

   Use the [start](../api-ref/LoadBalancer/start.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Start](../api-ref/grpc/load_balancer_service.md#Start) gRPC API call.

{% endlist %}
