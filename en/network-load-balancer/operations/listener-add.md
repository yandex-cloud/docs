# Adding a listener to a network load balancer

{% list tabs %}

- Management console

   To add a [listener](../concepts/listener.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you need to add a listener to a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to add a listener to, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Add listener**.
   1. In the window that opens, set the listener parameters:

      * **Name**.
      * **Protocol**: **TCP** or **UDP**.

         {% note info %}

         By default, the listener uses TCP. To use UDP, [submit a request to technical support]({{ link-console-support }}/create-ticket).

         {% endnote %}

      * **Port** where the listener will listen for incoming traffic. The acceptable values are from `1` to `32767`.
      * **Target port**, to which the load balancer will redirect traffic. The acceptable values are from `1` to `32767`.
      * Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a [listener](../concepts/listener.md) to a network load balancer, run this command:

   ```bash
   yc load-balancer network-load-balancer add-listener <load balancer ID or name> \
      --listener name=<listener name>,`
                `port=<port>,`
                `target-port=<target port>,`
                `protocol=<protocol: TCP or UDP>,`
                `external-address=<listener external IP>,`
                `external-ip-version=<IP version: ipv4 or ipv6>
   ```

   Where:

   {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

   You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and add the `listener` section to the network load balancer description.

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network load balancer name>"
        ...
        listener {
          name = "<listener name>"
          port = <port number>
          external_address_spec {
            ip_version = "<IP version: ipv4 or ipv6>"
          }
        }
        ...
      }
      ```

      Where:

      * `name`: Name of the network load balancer.
      * `listener`: Listener parameters:
         * `name`: Name of the listener.
         * `port`: Port in the range of `1` to `32767` that the network load balancer will receive incoming traffic on.
         * `external_address_spec`: Specification of the listener for the external load balancer:
            * `ip_version`: External IP address specification. Set the IP address version: `ipv4` or `ipv6`. The default value is `ipv4`.

      For more information about the `yandex_lb_network_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Add a listener.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Listener name in the `listenerSpec.name` parameter.
   * Listener port in the `listenerSpec.port` parameter.
   * Listener protocol in the `listenerSpec.protocol` parameter.
   * Listener target port in the `listenerSpec.targetPort` parameter.
   * Listener external address specification in the `listenerSpec.externalAddressSpec` parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API

   To add a listener to the network load balancer, use the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/AddListener](../api-ref/grpc/network_load_balancer_service.md#AddListener) gRPC API call.

{% endlist %}

## Examples {#examples}

### Adding a listener to a network load balancer {#add-listener}

Add a listener with the following test specifications to the `test-load-balancer`:

* Name: `test-listener`.
* Port: `80`.
* Target port: `81`.
* Protocol: `TCP`.
* IP version: `ipv4`.

{% list tabs %}

- CLI

   Run the following command:

   ```bash
   yc load-balancer network-load-balancer add-listener test-load-balancer \
      --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `external-ip-version=ipv4
   ```

- {{ TF }}

   1. Open the {{ TF }} configuration file and add the `listener` section to the network load balancer description.

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

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) API method and include the following information in the request body:

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
