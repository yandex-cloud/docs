# Create an internal network load balancer

{% note info %}

To create an internal network load balancer, you need the `load-balancer.privateAdmin` role.

{% endnote %}

{% note info %}

The internal load balancer's listener is assigned a random IP address from the range belonging to the selected [subnet](../../vpc/concepts/network.md#subnet).

{% endnote %}

{% list tabs %}

- Management console

   To create an [internal network load balancer](../concepts/internal-load-balancer.md):
   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Click **Create a network load balancer**.
   1. Enter a name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select **Internal** as your load balancer type.
   1. Under **Listeners**, add a [listener](../concepts/listener.md):
      1. Click **Add listener**.
      1. In the window that opens, set the listener parameters:
         * **Name**.
         * **Subnet**, in which the load balancer will redirect traffic.
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
         * Add VMs to the target group.
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

   1. Before creating a load balancer, [create a target group](target-group-create.md) to attach to it.

   1. View a description of the CLI command to create a network load balancer:

      ```bash
      yc load-balancer network-load-balancer create --help
      ```

   1. To create an internal load balancer with a [listener](../concepts/listener.md) and a [target group](../concepts/target-resources.md), run this command:

      ```bash
      yc load-balancer network-load-balancer create <load_balancer_name> \
         --type=internal \
         --listener name=<listener_name>,`
                   `port=<port>,`
                   `target-port=<target_port>,`
                   `protocol=<protocol:_tcp_or_udp>,`
                   `internal-subnet-id=<subnet_ID>,`
                   `internal-ip-version=<IP_version:_ipv4_or_ipv6> \
         --target-group target-group-id=<target_group_ID>,`
                       `healthcheck-name=<health_check_name>,`
                       `healthcheck-interval=<health_check_interval>s,`
                       `healthcheck-timeout=<health_check_timeout>s,`
                       `healthcheck-unhealthythreshold=<number_of_failed_health_checks_for_Unhealthy_status>,`
                       `healthcheck-healthythreshold=<number_of_successful_health_checks_for_Healthy_status>,`
                       `healthcheck-tcp-port=<TCP_port>,`
                       `healthcheck-http-port=<HTTP_port>,`
                       `healthcheck-http-path=<URL_to_perform_health_checks_at>
      ```

      Where:

      * `type`: Load balancer type.
      * `listener`: Listener parameters:
         * `name`: Name of the listener.
         * `port`: Port where the load balancer will accept incoming traffic. The acceptable values are from `1` to `32767`.
         * `target-port`: Port to which the load balancer will redirect traffic. The acceptable values are from `1` to `32767`.
         * `protocol`: Protocol the listener will use (`TCP` or `UDP`).
         * `internal-subnet-id`: Subnet ID.
         * `internal-ip-version`: Version of the internal IP address (`ipv4` or `ipv6`).

      {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create an internal load balancer with a [listener](../concepts/listener.md) and a [target group](../concepts/target-resources.md):

   1. Describe the parameters of the network load balancer resource in a configuration file:

      Example of the configuration file structure:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network_load_balancer_name>"
        type = "internal"
        deletion_protection = "<deletion_protection:_true_or_false>"
        listener {
          name = "<listener_name>"
          port = <port_number>
          internal_address_spec {
            subnet_id = "<subnet_ID>"
            ip_version = "<IP_version:_ipv4_or_ipv6>"
          }
        attached_target_group {
          target_group_id = "<target_group_ID>"
          healthcheck {
            name = "<health_check_name>"
              http_options {
                port = <port_number>
                path = "<URL_to_perform_health_checks_at>"
              }
          }
        }
      }
      ```

      Where:

      * `name`: Name of the network load balancer.
      * `type`: Type of the network load balancer. Use `internal` to create an internal network load balancer.
      * `deletion_protection`: Internal network load balancer deletion protection. You cannot delete a load balancer with this option enabled. If load balancer deletion protection is enabled, you can still delete its listeners and target groups. The default value is `false`.
      * `listener`: Listener parameters:
         * `name`: Name of the listener.
         * `port`: Port in the range of `1` to `32767` that the network load balancer will receive incoming traffic on.
         * `internal_address_spec`: Specification of the listener for the external load balancer:
            * `subnet_id`: Subnet.
            * `ip_version`: External IP address specification. Set the IP address version: `ipv4` or `ipv6`. The default value is `ipv4`.
      * `attached_target_group`: Description of the network load balancer's target group parameters:
         * `target_group_id`: Target group ID.
         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

      For more information on resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Create a network load balancer:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method and include the following information in the request:

   * ID of the folder where the network load balancer should be placed, in the `folderId` parameter.
   * Network load balancer name in the `name` parameter.
   * Network load balancer type in the `type` parameter. Use `internal` to create an internal network load balancer.
   * [Listener](../concepts/listener.md) specification in the `listenerSpecs` parameter.
   * [Target group](../concepts/target-resources.md) IDs and settings of its [resource health checks](../concepts/health-check.md) in the `attachedTargetGroups` parameter.

   You can get the target group IDs with a [list of target groups in the folder](target-group-list.md#list).

- API

   To create an internal network load balancer, use the [create](../api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../api-ref/grpc/network_load_balancer_service.md#Create) gRPC API call.

{% endlist %}

## Examples

### Creating an internal load balancer without a listener {#without-listener}

Create an internal network load balancer named `internal-lb-test-1` without a listener and target group.

{% list tabs %}

- CLI

   To create an internal load balancer without a listener, run the command:

   ```bash
   yc load-balancer network-load-balancer create internal-lb-test-1 \
      --type=internal
   ```

- {{ TF }}

   1. In the configuration file, describe the resource parameters without the `listener` and `attached_target_group` sections:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "internal-lb-test-1"
        type = "internal"
        deletion_protection = "true"
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
     "folderId": "<folder_ID>",
     "name": "internal-lb-test-1",
     "type": "INTERNAL"
   }
   ```

{% endlist %}

### Creating an internal load balancer with a listener and attached target group {#with-listener-and-target-group}

Create an internal network load balancer with a listener and attached target group with the following test specifications:

* Name: `internal-lb-test-2`.
* Listener parameters:
   * Name: `test-listener`.
   * Port: `80`.
   * Target port: `81`.
   * Protocol: `TCP`.
   * Subnet ID: `b0cp4drld130********`.
   * IP version: `ipv4`.
* Target group ID: `enpu2l7q9kth********`.
* Target group health check parameters:
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
   yc load-balancer network-load-balancer create internal-lb-test-2 \
      --type=internal \
      --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `internal-subnet-id=b0cp4drld130********,`
                `internal-ip-version=ipv4 \
      --target-group target-group-id=enpu2l7q9kth********,`
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
      resource "yandex_lb_network_load_balancer" "internal-lb-test" {
        name = "internal-lb-test-2"
        type = "internal"
        deletion_protection = "true"
        listener {
          name        = "test-listener"
          port        = 80
          target_port = 81
          protocol    = "tcp"
          internal_address_spec {
            subnet_id  = "b0cp4drld130********"
            ip_version = "ipv4"
          }
        }
        attached_target_group {
          target_group_id = "enpu2l7q9kth********"
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
     "folderId": "<folder_ID>",
     "name": "internal-lb-test-2",
     "type": "INTERNAL",
     "listenerSpecs": [
       {
         "name": "test-listener",
         "port": "80",
         "protocol": "TCP",
         "targetPort": "81",
         "internalAddressSpec": {
           "subnetId": "b0cp4drld130********",
           "ipVersion": "IPV4"
         }
       }
     ],
     "attachedTargetGroups": [
       {
         "targetGroupId": "enpu2l7q9kth********",
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
