# Attach a target group to a network load balancer

{% list tabs %}

- Management console

   To attach a [target group](../concepts/target-resources.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to attach a target group to a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to attach a target group to, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Attach target group**.
   1. Select a target group or [create a new one](target-group-create.md).
   1. Configure health check settings.
   1. Click **Attach target group**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to attach a target group to a network load balancer:

      ```bash
      yc load-balancer network-load-balancer attach-target-group --help
      ```

   1. Attach a target group to your load balancer by specifying the group ID and health check settings in the appropriate command parameters:

      ```bash
      yc load-balancer network-load-balancer attach-target-group <load balancer ID or name> \
         --target-group target-group-id=<target group ID>,`
                       `healthcheck-name=<health check name>,`
                       `healthcheck-interval=<health check interval>s,`
                       `healthcheck-timeout=<response timeout>s,`
                       `healthcheck-unhealthythreshold=<number of failed health checks for Unhealthy status>,`
                       `healthcheck-healthythreshold=<number of successful health checks for Healthy status>,`
                       `healthcheck-tcp-port=<TCP port>,`
                       `healthcheck-http-port=<HTTP port>,`
                       `healthcheck-http-path=<URL for health checks>
      ```

      Where:

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list) and the target group ID with a [list of folder target groups](target-group-list.md#list).

      For more information about check parameters, see [Resource health check](../concepts/health-check).

- {{ TF }}

   1. Open the {{ TF }} configuration file and add the `attached_target_group` section to the network load balancer description:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network load balancer name>"
        ...
        attached_target_group {
          target_group_id = "<target group ID>"
          healthcheck {
            name = "<health check name>"
            http_options {
              port = <port number>
              path = "<URL for health checks>"
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
         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Target group ID in the `attachedTargetGroup.targetGroupId` parameter.
   * Health check settings in the `attachedTargetGroup.healthChecks` parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list) and the target group ID with a [list of folder target groups](target-group-list.md#list).

{% endlist %}