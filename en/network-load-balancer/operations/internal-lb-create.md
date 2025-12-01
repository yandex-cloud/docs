---
title: How to create an internal network load balancer
description: Follow this guide to create an internal network load balancer.
---

# Create an internal network load balancer

{% note info %}

To create an [internal network load balancer](../concepts/nlb-types.md), you need the `load-balancer.privateAdmin` [role](../security/index.md#load-balancer-private-admin).

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

To create an internal network load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the load balancer. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}** field, select `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`. 
  1. Optionally, in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_advanced }}** field, enable load balancer protection from deletion.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**, add a [listener](../concepts/listener.md):
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
      1. In the window that opens, specify these listener settings:
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}** where the load balancer will route traffic.
          * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select the method through which the listener will get the IP address the load balancer will receive traffic on:

              * `{{ ui-key.yacloud.common.label_auto }}`: For the listener to automatically get a free IP address from the selected subnet range.
              * `{{ ui-key.yacloud.common.label_list }}`: To manually reserve a particular IP address for the listener in the subnet you select.
              
                  In the **{{ ui-key.yacloud.component.internal-v4-address-field.label_internal-address-title }}** field that opens, select a previously reserved IP address or click **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}** to reserve a new one. In the window that opens, specify the parameters of the reserved IP address:

                  * **{{ ui-key.yacloud.common.name }}**.
                  * **{{ ui-key.yacloud.vpc.addresses.popup-create_field_internal-v4-address }}**: Specify a free IP address in the subnet range selected for the listener.
                  * Optionally, in the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}** field, enable deletion protection for the reserved IP address.
                  * Click **{{ ui-key.yacloud.common.create }}**.
          * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}** field, select `{{ ui-key.yacloud.common.label_tcp }}` or `{{ ui-key.yacloud.common.label_udp }}`.

              {% note info %}

              By default, the listener uses TCP. To use UDP, [contact technical support]({{ link-console-support }}).

              {% endnote %}

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** where the listener will listen for incoming traffic. The possible values range from `1` to `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** to which the load balancer will redirect traffic. The possible values range from `1` to `32767`.
      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, add a [target group](../concepts/target-resources.md):
      1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
      1. Select a target group or [create a new one](target-group-create.md):
          * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
          * In the window that opens, enter a target group name.
          * Add VMs to the target group.
          * Click **{{ ui-key.yacloud.common.create }}**.
      1. Optionally, under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}**, click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. In the window that opens, specify the [resource health check](../concepts/health-check.md) settings:
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**.
          * Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**, choose one of the options:
          
              * `{{ ui-key.yacloud.common.label_http }}`. Additionally, in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field, specify the path for health checks.
              * `{{ ui-key.yacloud.common.label_tcp }}`.
              * `{{ ui-key.yacloud.common.label_http2 }}`. Additionally, in the **{{ ui-key.yacloud.compute.group.overview.label_host }}** and **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** fields, specify the host address and path for health checks.
              * `{{ ui-key.yacloud.common.label_https }}`. Additionally, in the **{{ ui-key.yacloud.compute.group.overview.label_host }}** and **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** fields, specify the host address and path for health checks.
              * `{{ ui-key.yacloud.common.label_grpc }}`. Additionally, in the **{{ ui-key.yacloud.compute.group.overview.label_service-name }}** and **{{ ui-key.yacloud.compute.group.overview.label_authority }}** fields, specify the details of your gRPC service.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**: Port number for health checks. The possible values range from `1` to `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}**: Response timeout in seconds.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}**: Health check interval in seconds.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}**: Number of successful checks required to consider the VM ready to receive traffic.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}**: Number of failed checks before traffic is no longer routed to the VM.
	    1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Before you create a load balancer, make sure to [create a target group](target-group-create.md) for it.

  1. See the description of the CLI command for creating a network load balancer:

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
                   `internal-ip-version=<IP_address_version>,`
                   `internal-address=<listener_IP_address> \
        --target-group target-group-id=<target_group_ID>,`
                       `healthcheck-name=<health_check_name>,`
                       `healthcheck-interval=<health_check_interval>s,`
                       `healthcheck-timeout=<health_check_timeout>s,`
                       `healthcheck-unhealthythreshold=<number_of_failed_checks_to_get_Unhealthy_status>,`
                       `healthcheck-healthythreshold=<number_of_successful_checks_to_get_Healthy_status>,`
                       `healthcheck-tcp-port=<TCP_port>,`
                       `healthcheck-http-port=<HTTP_port>,`
                       `healthcheck-http-path=<URL>
     ```

     Where:

     * `--type`: Load balancer type.
     * `--listener`: Listener settings:
         * `name`: Listener name.
         * `port`: Port on which the load balancer will listen to incoming traffic. The possible values range from `1` to `32767`.
         * `target-port`: Port to which the load balancer will redirect traffic. The possible values range from `1` to `32767`.
         * `protocol`: Protocol the listener will use, `tcp` or `udp`.
         * `internal-subnet-id`: Subnet ID.
         * `internal-ip-version`: Internal IP address version, `ipv4` or `ipv6`.
         * `internal-address`: Listener IP address not occupied by other resources and belonging to the subnet range specified in the `internal-subnet-id` property.

             If the `internal-address` property is not specified, the internal load balancer listener gets a random IP address from the selected [subnet](../../vpc/concepts/network.md#subnet) range.

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

     For more information about the `yc load-balancer network-load-balancer create` command, see the [{{ yandex-cloud }} CLI reference](../../cli/cli-ref/load-balancer/cli-ref/network-load-balancer/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create an internal load balancer with a [listener](../concepts/listener.md) and a [target group](../concepts/target-resources.md):

  1. Describe the network load balancer settings in the configuration file.

     Here is the configuration file example:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<load_balancer_name>"
       type = "internal"
       deletion_protection = "<deletion_protection>"
       listener {
         name = "<listener_name>"
         port = <port_number>
         internal_address_spec {
           subnet_id  = "<subnet_ID>"
           ip_version = "<IP_address_version>"
           address    = "<listener_IP_address>"
         }
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
     * `type`: Type of the network load balancer. Use `internal` to create an internal load balancer.
     * `deletion_protection`: Deletion protection for the internal network load balancer. You cannot delete a load balancer with this option enabled. This does not apply to its listeners or target groups. The default value is `false`.
     * `listener`: Listener settings:
       * `name`: Listener name.
       * `port`: Port number (ranging from `1` to `32767`) on which the load balancer will listen to incoming traffic.
       * `internal_address_spec`: Specification of the internal load balancer's listener:
         * `subnet_id`: Subnet ID.
         * `ip_version`: External IP address specification. Specify the IP address version, `ipv4` or `ipv6`. The default value is `ipv4`.
         * `address`: Listener IP address not occupied by other resources and belonging to the subnet range specified in the `subnet_id` field.

             If the `address` field value is not specified, the internal load balancer listener gets a random IP address from the selected [subnet](../../vpc/concepts/network.md#subnet) range.
     * `attached_target_group`: Description of the network load balancer's target group settings:
        * `target_group_id`: Target group ID.

          {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

        * `healthcheck`: Health check settings. Specify a name, a port number ranging from `1` to `32767`, and a path for health checks.

     For more information about the resources you can create with {{ TF }}, see [this article]({{ tf-provider-link }}/resources/lb_network_load_balancer).

  1. Create a network load balancer:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To create an internal network load balancer, use the [create](../api-ref/NetworkLoadBalancer/create.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Create](../api-ref/grpc/NetworkLoadBalancer/create.md) gRPC API call.

{% endlist %}

## Examples

### Creating an internal load balancer without a listener {#without-listener}

Create an internal network load balancer named `internal-lb-test-1` without a listener and a target group.

{% list tabs group=instructions %}

- CLI {#cli}

  To create an internal load balancer without a listener, run this command:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-1 \
     --type=internal
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the load balancer settings, skipping the `listener` and `attached_target_group` sections:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "internal-lb-test-1"
       type = "internal"
       deletion_protection = "true"
     ```

     For more information about the resources you can create with {{ TF }}, see [this article]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method, providing the following in the request body:

  ```api
  {
    "folderId": "<folder_ID>",
    "name": "internal-lb-test-1",
    "type": "INTERNAL"
  }
  ```

{% endlist %}

### Creating an internal load balancer with a listener and attached target group {#with-listener-and-target-group}

Create an internal network load balancer with a listener and attached target group with the following test settings:

* Name: `internal-lb-test-2`
* Listener settings:
    * Name: `test-listener`
    * Port: `80`
    * Target port: `81`
    * Protocol: `TCP`
    * Subnet ID: `b0cp4drld130********`
    * IP address version: `ipv4`
    * Listener IP address: `192.168.1.25`
* Target group ID: `enpu2l7q9kth********`
* Target group health check settings:
    * Name: `http`
    * Health check interval: `2` seconds
    * Response timeout: `1` second
    * Unhealthy threshold: `2`
    * Healthy threshold: `2`
    * Port for HTTP health checks: `80`
    * URL for health checks: `/`

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-2 \
     --type=internal \
     --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `internal-subnet-id=b0cp4drld130********,`
                `internal-ip-version=ipv4,`
                `internal-address=192.168.1.25 \
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

  1. In the configuration file, describe the load balancer, including the `listener` and `attached_target_group` sections:

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
           address    = "192.168.1.25"
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

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a network load balancer.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Use the [create](../api-ref/NetworkLoadBalancer/create.md) API method, providing the following in the request body:

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
          "ipVersion": "IPV4",
          "address": "192.168.1.25"
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
