---
title: Adding a listener to a network load balancer
description: Follow this guide to add a listener to a network load balancer.
---

# Adding a listener to a network load balancer

{% list tabs group=instructions %}

- Management console {#console}
  
  To add a [listener](../concepts/listener.md) to a network load balancer:
  
  1. In the [management console]({{ link-console-main }}), select the folder where you need to add a listener to a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Next to the load balancer to add a listener to, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
  1. In the window that opens, specify these listener settings:

     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}` or `{{ ui-key.yacloud.common.label_udp }}`.

        {% note info %}

        By default, the listener uses TCP. To use UDP, [contact technical support]({{ link-console-support }}).

        {% endnote %}

     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** where the listener will listen for incoming traffic. The possible values range from `1` to `32767`.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** to which the load balancer will redirect traffic. The possible values range from `1` to `32767`.
     * Click **{{ ui-key.yacloud.common.add }}**.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To add a [listener](../concepts/listener.md) to a network load balancer, run this command:

  ```bash
  yc load-balancer network-load-balancer add-listener <load_balancer_name_or_ID> \
     --listener name=<listener_name>,`
               `port=<port>,`
               `target-port=<target_port>,`
               `protocol=<protocol>,`
               `external-address=<external_IP_address>,`
               `external-ip-version=<IP_address_version>
  ```

  Where:

  {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

  You can get the load balancer ID and name with the [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `listener` section to the network load balancer description:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<load_balancer_name>"
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

     Where:

     * `name`: Name of the network load balancer.
     * `listener`: Listener settings:
       * `name`: Listener name.
       * `port`: Port number (ranging from `1` to `32767`) on which the load balancer will listen to incoming traffic.
       * `external_address_spec`: Specification of the listener for the external load balancer settings:
         * `ip_version`: External IP address specification. Specify the IP address version, `ipv4` or `ipv6`. The default value is `ipv4`.

     For more information about `yandex_lb_network_load_balancer` settings, see [this {{ TF }} article]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Add a listener.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To add a listener to a network load balancer, use the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/AddListener](../api-ref/grpc/NetworkLoadBalancer/addListener.md) gRPC API call.

{% endlist %}

## Examples {#examples}

### Adding a listener to a network load balancer {#add-listener}

Add a listener with the following test settings to `test-load-balancer`:

* Name: `test-listener`
* Port: `80`
* Target port: `81`
* Protocol: `TCP`
* IP address version: `ipv4`

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc load-balancer network-load-balancer add-listener test-load-balancer \
     --listener name=test-listener,`
               `port=80,`
               `target-port=81,`
               `protocol=tcp,`
               `external-ip-version=ipv4
  ```

- {{ TF }} {#tf}

  1. Open the {{ TF }} configuration file and add the `listener` section to the network load balancer description:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "test-load-balancer"
       listener {
         name        = "test-listener"
         port        = 80
         target_port = 81
         protocol    = "tcp"
         external_address_spec {
           ip_version = "ipv4"
         }
       }
     }
     ```

     For more information about the resources you can create with {{ TF }}, see [this article]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Use the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) API method, providing the following in the request body:

  ```api
  {
    "listenerSpec": {
      "name": "test-listener",
      "port": "80",
      "protocol": "TCP",
      "targetPort": "81",
      "externalAddressSpec": {
        "ipVersion": "ipv4"
      }
    }
  }
  ```

{% endlist %}
