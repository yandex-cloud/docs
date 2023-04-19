# Create a network load balancer

{% note info %}

Before creating a network load balancer, [create](target-group-create.md) a target group to attach to it.

{% endnote %}

{% list tabs %}

- Management console

   To create a [network load balancer](../concepts/index.md).

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Click **Create a network load balancer**.
   1. Enter a name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Assign a public IP address to the load balancer. You can assign an address automatically or select one from the list of reserved addresses.
   1. Under **Listeners**, add a [listener](../concepts/listener.md):
      1. Click **Add listener**.
      1. In the window that opens, set the listener parameters:

         * **Name**.
         * **Protocol**: **TCP** or **UDP**.

            {% note info %}

            By default, the listener uses TCP. To use UDP, [submit a request to technical support]({{ link-console-support }}/create-ticket).

            {% endnote %}

         * **Port** where the listener will listen for incoming traffic. The acceptable values are from `1` to `32767`.
         * **Target port**, to which the load balancer will redirect traffic. The acceptable values are from `1` to `32767`.

      1. Click **Add**.

   1. Under **Target groups** add a [target group](../concepts/target-resources.md):
      1. Click **Add target group**.
      1. Select a target group or [create a new one](target-group-create.md):
         * In the **Target group** field, select ![image](../../_assets/plus-sign.svg) **Create target group**.
         * In the resulting window, enter a target group name.
         * Add virtual machines to the target group.
         * Click **Create**.
      1. (Optional) Under **Health check**, click **Configure**. In the window that opens, specify the [resource health check](../concepts/health-check.md) settings:
         * **Name**.
         * **Type**: **HTTP** or **TCP**. For health checks to use HTTP, specify the URL to check in the **Path** field.
         * Health check **port**. The acceptable values are from `1` to `32767`.
         * **Timeout**: Response timeout in seconds.
         * **Interval**: Health check interval in seconds.
         * **Healthy threshold**: Number of successful checks required to consider a virtual machine ready to receive traffic.
         * **Unhealthy threshold**: Number of failed checks after which no traffic will be routed to a virtual machine.

      1. Click **Apply**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a network load balancer:

      ```bash
      yc load-balancer network-load-balancer create --help
      ```

   1. To create a load balancer with a [listener](../concepts/listener.md) and a [target group](../concepts/target-resources.md), run this command:

      ```bash
      yc load-balancer network-load-balancer create <load balancer name> \
         --listener name=<listener name>,`
                   `port=<port>,`
                   `target-port=<target port>,`
                   `protocol=<protocol: TCP or UDP>,`
                   `external-ip-version=<IP address version: ipv4 or ipv6> \
         --target-group target-group-id=<target group ID>,`
                       `healthcheck-name=<health check name>,`
                       `healthcheck-interval=<interval between health checks>s,`
                       `healthcheck-timeout=<health check timeout>s,`
                       `healthcheck-unhealthythreshold=<number of failed health checks for Unhealthy status>,`
                       `healthcheck-healthythreshold=<number of successful health checks for Healthy status>,`
                       `healthcheck-tcp-port=<TCP port>,`
                       `healthcheck-http-port=<HTTP port>,`
                       `healthcheck-http-path=<URL for health checks>
      ```

      Where:

      {% include [listener-cli-description](../../_includes/network-load-balancer/listener-cli-description.md) %}

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the parameters of the network load balancer resource in a configuration file.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network load balancer name>"
        listener {
          name = "<listener name>"
          port = <port number>
          external_address_spec {
            ip_version = "<IP address version: ipv4 or ipv6>"
          }
        }
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
      }
      ```

      Where:

      * `name`: Name of the network load balancer.
      * `listener`: Listener parameters:
         * `name`: Name of the listener.
         * `port`: Port in the range of `1` to `32767` that the network load balancer will receive incoming traffic on.
         * `external_address_spec`: Specification of the listener for the external load balancer:
            * `ip_version`: External IP address specification. Set the IP address version: `ipv4` or `ipv6`. The default value is `ipv4`.
      * `attached_target_group`: Description of the network load balancer's target group parameters:
         * `target_group_id`: Target group ID.
         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

      For more information about the `yandex_lb_network_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method and include the following information in the request:

   * ID of the folder where the network load balancer should be placed, in the `folderId` parameter.
   * Network load balancer name in the `name` parameter.
   * [Listener](../concepts/listener.md) specification in the `listenerSpecs` parameter.
   * [Target group](../concepts/target-resources.md) IDs and settings of its [resource health checks](../concepts/health-check.md) in the `attachedTargetGroups` parameter.

   You can get the target group IDs with a [list of target groups in the folder](target-group-list.md#list).

{% endlist %}

## Examples {#examples}

### Creating a network load balancer without a listener {without-listener}

Create a network load balancer named `test-load-balancer-1` without a listener and target group.

{% list tabs %}

- CLI

   Run the following command:

   ```bash
   yc load-balancer network-load-balancer create test-load-balancer-1
   ```

- {{ TF }}

   1. In the configuration file, describe the resource parameters without the `listener` and `attached_target_group` sections:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "test-load-balancer-1"
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method and include the following information in the request body:

   ```api
   {
     "folderId": "<folder ID>",
     "name": "test-load-balancer-1",
     "type": "EXTERNAL"
   }
   ```

{% endlist %}

### Creating a network load balancer with a listener and attached target group {with-listener-and-target-group}

Create a network load balancer with a listener and attached target group with the following test specifications:

* Name: `test-load-balancer-2`.
* Listener parameters:
   * Name: `test-listener`.
   * Port: `80`.
   * Target port: `81`.
   * Protocol: `TCP`.
   * IP version: `ipv4`.
* Target group ID: `enpu2l7q9kth8906spjn`.
* Target group resource health check parameters:
   * Name: `HTTP`.
   * Health check interval: `2` seconds.
   * Response timeout: `1` second.
   * Unhealthy threshold: `2`.
   * Healthy threshold: `2`.
   * Port for HTTP health checks: `80`.
   * URL for health checks: `/`.

{% list tabs %}

- CLI

   Run the following command:

   ```bash
   yc load-balancer network-load-balancer create test-load-balancer-2 \
      --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `external-ip-version=ipv4 \
      --target-group target-group-id=enpu2l7q9kth8906spjn,`
                    `healthcheck-name=http,`
                    `healthcheck-interval=2s,`
                    `healthcheck-timeout=1s,`
                    `healthcheck-unhealthythreshold=2,`
                    `healthcheck-healthythreshold=2,`
                    `healthcheck-http-port=80,`
                    `healthcheck-http-path=/
   ```

- {{ TF }}

   1. In the configuration file, describe the resource parameters with the `listener` and `attached_target_group` sections:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "test-load-balancer-2"
        listener {
          name        = "test-listener"
          port        = 80
          target_port = 81
          protocol    = "tcp"
          external_address_spec {
            ip_version = "ipv4"
          }
        }
        attached_target_group {
          target_group_id = "enpu2l7q9kth8906spjn"
          healthcheck {
            name                = "http"
            interval            = 2
            timeout             = 1
            unhealthy_threshold = 2
            healthy_threshold   = 2
            http_options {
              port = 80
              path = "/"
            }
          }
        }
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

   Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method and include the following information in the request body:

   ```api
   {
     "folderId": "<folder ID>",
     "name": "test-load-balancer-2",
     "type": "EXTERNAL",
     "listenerSpecs": [
       {
         "name": "test-listener",
         "port": "80",
         "protocol": "TCP",
         "targetPort": "81",
         "externalAddressSpec": {
           "ipVersion": "IPV4"
         }
       }
     ],
     "attachedTargetGroups": [
       {
         "targetGroupId": "b7rjtf12qdeehrj31hri",
         "healthChecks": [
           {
             "name": "http",
             "interval": "2s",
             "timeout": "1s",
             "unhealthyThreshold": "2",
             "healthyThreshold": "2",
             "httpOptions": {
               "port": "80",
               "path": "/"
             }
           }
         ]
       }
     ]
   }
   ```

{% endlist %}
