# Detach a target group from a network load balancer

{% list tabs %}

- Management console

   To detach a [target group](../concepts/target-resources.md) from a network load balancer:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to detach a target group from a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Select the load balancer that you wish to detach the target group from.
   1. Under **Target groups**, click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the appropriate target group.
   1. In the menu that opens, click **Detach**.
   1. In the window that opens, click **Detach**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to detach a target group from a network load balancer:

      ```bash
      yc load-balancer network-load-balancer detach-target-group --help
      ```

   1. Detach a [target group](../concepts/target-resources.md) from a network load balancer:

      ```bash
      yc load-balancer network-load-balancer detach-target-group <load balancer ID or name> \
         --target-group-id=<target group ID>
      ```

      You can get the load balancer ID and name, as well as the IDs of the attached target groups, with a [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To detach a [target group](../concepts/target-resources.md) from a network load balancer created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the target group description.

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

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Delete the network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   To detach a target group from a network load balancer, use the [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/DetachTargetGroup](../api-ref/grpc/network_load_balancer_service.md#DetachTargetGroup) gRPC API call and provide the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Target group ID in the `targetGroupId` parameter.

   You can get the IDs of the load balancer and attached target groups with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
