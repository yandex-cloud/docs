---
title: Deleting a listener
description: Follow this guide to delete a listener.
---

# Deleting a listener

{% list tabs group=instructions %}

- Management console {#console}
  
  To delete a [listener](../concepts/listener.md) for your network load balancer:
  
  1. In the [management console]({{ link-console-main }}), select the folder where you need to delete a load balancer listener.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Select the network load balancer whose listener you need to delete.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_listeners }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the listener to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_delete-listener }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a network load balancer listener, run this command:

  ```bash
  yc load-balancer network-load-balancer remove-listener <load_balancer_name_or_ID> \
     --listener-name=<listener_name>
  ```

  You can get the load balancer ID and name with the [list of network load balancers in the folder](load-balancer-list.md#list), and the listener name with [network load balancer details](load-balancer-list.md#get).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a network load balancer listener created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the section describing the listener.

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       ...
       listener {
         name = "<listener_name>"
         port = <port_number>
         external_address_spec {
           ip_version = "<IP_address_version>"
         }
       }
       ...
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Delete the network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}
  
  To remove a network load balancer listener, use the [removeListener](../api-ref/NetworkLoadBalancer/removeListener.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/RemoveListener](../api-ref/grpc/NetworkLoadBalancer/removeListener.md) gRPC API call, providing the following in your request:

  * Load balancer ID in the `networkLoadBalancerId` parameter.
  * Listener name in the `listenerName` parameter.

  You can get the load balancer ID with the [list of network load balancers in the folder](load-balancer-list.md#list), and the listener name with [network load balancer details](load-balancer-list.md#get).

{% endlist %}