---
title: How to create an internal network load balancer
description: Follow this guide to create an internal network load balancer.
---

# Create an internal network load balancer

{% note info %}

To create an internal network load balancer, you need the `load-balancer.privateAdmin` role.

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

{% note info %}

The internal load balancer's listener is assigned a random IP address from the range belonging to the selected [subnet](../../vpc/concepts/network.md#subnet).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To create an [internal network load balancer](../concepts/nlb-types.md):
  1. In the [management console]({{ link-console-main }}), select the folder to create a load balancer in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Enter a name. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Select `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}` as your load balancer type. 
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, add a [listener](../concepts/listener.md):
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
      1. In the window that opens, set the listener parameters:
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}** the load balancer will redirect traffic in.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}` or `{{ ui-key.yacloud.common.label_udp }}`.

            {% note info %}

            By default, the listener uses TCP. To use UDP, [submit a request to technical support]({{ link-console-support }}).

            {% endnote %}

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** where the listener will listen for incoming traffic. The values range from `1` to `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** the load balancer will redirect traffic to. The values range from `1` to `32767`.
      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** add a [target group](../concepts/target-resources.md):
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
      1. Select a target group or [create a new one](target-group-create.md):
          * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
          * In the window that opens, enter a target group name.
          * Add VMs to the target group.
          * Click **{{ ui-key.yacloud.common.create }}**.
      1. Optionally, under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. In the window that opens, specify the [resource health check](../concepts/health-check.md) settings:
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`. For health checks to use HTTP, specify the URL to check in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** for health checks. The values range from `1` to `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}**: Response timeout in seconds.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}**: Health check interval in seconds.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}**: Number of successful checks required to consider a virtual machine ready to receive traffic.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}**: Number of failed checks after which no traffic will be routed to a virtual machine.
	    1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
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
                  `protocol=<protocol>,`
                  `internal-subnet-id=<subnet_ID>,`
                  `internal-ip-version=<IP_address_version> \
        --target-group target-group-id=<target_group_ID>,`
                      `healthcheck-name=<health_check_name>,`
                      `healthcheck-interval=<interval_between_checks>s,`
                      `healthcheck-timeout=<health_check_timeout>s,`
                      `healthcheck-unhealthythreshold=<number_of_failed_checks_to_get_Unhealthy_status>,`
                      `healthcheck-healthythreshold=<number_of_successful_checks_to_get_Healthy_status>,`
                      `healthcheck-tcp-port=<TCP_port>,`
                      `healthcheck-http-port=<HTTP_port>,`
                      `healthcheck-http-path=<URL>
     ```

     Where:

     * `--type`: Load balancer type.
     * `--listener`: Listener properties:
         * `name`: Listener name.
         * `port`: Port where the load balancer will accept incoming traffic. The values range from `1` to `32767`.
         * `target-port`: Port to which the load balancer will redirect traffic. The values range from `1` to `32767`.
         * `protocol`: Protocol the listener will use, `tcp` or `udp`.
         * `internal-subnet-id`: Subnet ID.
         * `internal-ip-version`: Internal IP address version, `ipv4` or `ipv6`.

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create an internal load balancer with a [listener](../concepts/listener.md) and a [target group](../concepts/target-resources.md):

  1. Describe the parameters of the network load balancer resource in a configuration file:

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<load_balancer_name>"
       type = "internal"
       deletion_protection = "<deletion_protection>"
       listener {
         name = "<listener_name>"
         port = <port_number>
         internal_address_spec {
           subnet_id = "<subnet_ID>"
           ip_version = "<IP_address_version>"
         }
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
     }
     ```

     Where:

     * `name`: Name of the network load balancer.
     * `type`: Type of the network load balancer. Use `internal` to create an internal balancer.
     * `deletion_protection`: Deletion protection for the internal network load balancer. You cannot delete a load balancer with this option enabled. If load balancer deletion protection is enabled, you can still delete its listeners and target groups. The default value is `false`.
     * `listener`: Listener properties:
       * `name`: Listener name.
       * `port`: Port number (ranging from `1` to `32767`) on which the network load balancer will receive incoming traffic.
       * `internal_address_spec`: Specification of the listener for the external load balancer:
         * `subnet_id`: Subnet ID.
         * `ip_version`: External IP address specification. Specify the IP address version, `ipv4` or `ipv6`. The default value is `ipv4`.
     * `attached_target_group`: Description of the network load balancer's target group parameters:
        * `target_group_id`: Target group ID.

          {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

        * `healthcheck`: Health check parameters. Enter a name, a port number ranging from `1` to `32767`, and a path for health checks.

     For more information about the resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

  1. Create a network load balancer:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  To create an internal network load balancer, use the [create](../api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call.

{% endlist %}

## Examples

### Creating an internal load balancer without a listener {#without-listener}

Create an internal network load balancer named `internal-lb-test-1` without a listener and target group.

{% list tabs group=instructions %}

- CLI {#cli}

  To create an internal load balancer without a listener, run the command:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-1 \
     --type=internal
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the resource parameters without the `listener` and `attached_target_group` sections:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "internal-lb-test-1"
       type = "internal"
       deletion_protection = "true"
     ```

     For more information about the resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

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
    * IP address version: `ipv4`.
* Target group ID: `enpu2l7q9kth********`.
* Target group health check parameters:
    * Name: `http`.
    * Health check interval: `2` seconds.
    * Response timeout: `1` second.
    * Unhealthy threshold: `2`.
    * Healthy threshold: `2`.
    * Port for HTTP health checks: `80`.
    * URL for health checks: `/`.

{% list tabs group=instructions %}

- CLI {#cli}

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

- {{ TF }} {#tf}

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

     For more information about the resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

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
