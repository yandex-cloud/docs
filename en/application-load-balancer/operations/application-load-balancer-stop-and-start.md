---
title: How to stop and start an L7 load balancer in {{ alb-full-name }}
description: In this tutorial, you will learn how to stop and start an L7 load balancer in {{ alb-name }}.
---

# Stopping and starting an L7 load balancer

## Stopping a load balancer {#stop}

The **{{ ui-key.yacloud.common.stop }}** command stops an [L7 load balancer](../concepts/application-load-balancer.md). Once stopped, the load balancer changes its status to `STOPPED`. As long as the load balancer is stopped, you are not charged for its use.

You can start the load balancer at any time to continue your work. All your data and changes will remain intact.

To stop an L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer you need, then select **{{ ui-key.yacloud.common.stop }}**.
  
     To stop multiple load balancers at once, select them in the list, click **{{ ui-key.yacloud.common.stop }}** at the bottom of the screen, and then click **{{ ui-key.yacloud.common.stop }}** in the window that opens.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI load balancer stop command:

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
       log_group_id: ckgjhe81a23v********
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```

  1. To stop the load balancer, run the following command with its ID or name specified:

     ```bash
     yc application-load-balancer load-balancer stop <load_balancer_name>
     ```

     For more information about the `application-load-balancer load-balancer stop` command, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/stop.md).

- API {#api}

  Use the [stop](../api-ref/LoadBalancer/stop.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Stop](../api-ref/grpc/LoadBalancer/stop.md) gRPC API call.

{% endlist %}

## Start a load balancer {#start}

The **{{ ui-key.yacloud.common.start }}** command starts an L7 load balancer. Once started, the load balancer changes its status to `ACTIVE`. From this point on, you will be charged for its use.

To start a load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer you need, then select **{{ ui-key.yacloud.common.start }}**.

     To start multiple load balancers at once, select them in the list, click **{{ ui-key.yacloud.common.start }}** at the bottom of the screen, and then click **{{ ui-key.yacloud.common.start }}** in the window that opens.

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
       log_group_id: ckgjhe81a23v********
       created_at: "2022-02-11T09:01:46.724279145Z"
     ```

  1. To start a load balancer, run the following command with its ID or name specified:

     ```bash
     yc application-load-balancer load-balancer start <load_balancer_name>
     ```

     For more information about the `application-load-balancer load-balancer start` command, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/start.md).

- API {#api}

  Use the [start](../api-ref/LoadBalancer/start.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Start](../api-ref/grpc/LoadBalancer/start.md) gRPC API call.

{% endlist %}
