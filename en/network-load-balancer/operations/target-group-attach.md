---
title: Attaching a target group to a network load balancer
description: Follow this guide to attach a target group to a network load balancer.
---

# Attaching a target group to a network load balancer

{% list tabs group=instructions %}

- Management console {#console}

   To attach a [target group](../concepts/target-resources.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to attach a target group to a load balancer.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the line of the load balancer to attach a target group to, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_attach-tg }}**.
   1. Select a target group or [create a new one](target-group-create.md).
   1. Configure health check settings.
   1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_attach-tg }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to attach a target group to a network load balancer:

      ```bash
      yc load-balancer network-load-balancer attach-target-group --help
      ```

   1. Find out the ID or name of the load balancer by getting a [list of network load balancers in the folder](load-balancer-list.md#list).

   1. Attach a target group to your load balancer by specifying the group ID and health check settings in the appropriate command parameters:

      ```bash
      yc load-balancer network-load-balancer attach-target-group <load_balancer_name_or_ID> \
         --target-group target-group-id=<target_group_ID>,`
                       `healthcheck-name=<health_check_name>,`
                       `healthcheck-interval=<health_check_interval>s,`
                       `healthcheck-timeout=<response_timeout>s,`
                       `healthcheck-unhealthythreshold=<number_of_failed_health_checks_for_Unhealthy_status>,`
                       `healthcheck-healthythreshold=<number_of_successful_health_checks_for_Healthy_status>,`
                       `healthcheck-tcp-port=<TCP_port>,`
                       `healthcheck-http-port=<HTTP_port>,`
                       `healthcheck-http-path=<URL>
      ```

      Where:

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

      For more information about check parameters, see [Resource health check](../concepts/health-check).

- {{ TF }} {#tf}

   1. Open the {{ TF }} configuration file and add the `attached_target_group` section to the network load balancer description:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<load_balancer_name>"
        ...
        attached_target_group {
          target_group_id = "<target_group_ID>"
          healthcheck {
            name = "<health_check_name>"
            http_options {
              port = <port_number>
              path = "<URL>"
            }
          }
        }
        ...
      }
      ```

      Where:

      * `name`: Name of the network load balancer.
      * `attached_target_group`: Description of the network load balancer's target group parameters:
         * `target_group_id`: Target group ID.

            {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To attach a target group to a network load balancer, use the [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/AttachTargetGroup](../api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md) gRPC API call and provide the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Target group ID in the `attachedTargetGroup.targetGroupId` parameter.
   * Health check settings in the `attachedTargetGroup.healthChecks` parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list) and the target group ID with a [list of folder target groups](target-group-list.md#list).

{% endlist %}