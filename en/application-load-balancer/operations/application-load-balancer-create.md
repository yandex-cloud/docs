---
title: "How to create an L7 load balancer in {{ alb-full-name }}"
description: "Follow this guide to create an L7 load balancer."
---

# Creating an L7 load balancer

To create an [L7 load balancer](../concepts/application-load-balancer.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a load balancer.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
   1. Enter the load balancer name.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:
      1. [Network](../../vpc/concepts/network.md#network) whose [subnets](../../vpc/concepts/network.md#subnet) will house the load balancer nodes.
      1. Suitable [security groups](../concepts/application-load-balancer.md#security-groups):

         {% include [security-groups](../../_includes/application-load-balancer/security-groups.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set a limit on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling).

      The number of units will change automatically depending on the actual load on the load balancer and the limits you specified. The number of units affects the [load balancer pricing](../pricing.md).
   1. (Optional) Under **{{ ui-key.yacloud.alb.section_logs-settings }}**:
      1. Enable **{{ ui-key.yacloud.alb.label_log-requests }}**.
      1. Select the [{{ cloud-logging-full-name }}](../../logging/) [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
      1. Click **{{ ui-key.yacloud.alb.button_add-discard-rule }}** and set up its [parameters](../concepts/application-load-balancer.md#discard-logs-rules):
         * **{{ ui-key.yacloud.alb.label_discard-http-codes }}**: Add HTTP status codes.
         * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}**: Add classes of HTTP status codes.
         * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}**: Add gRPC codes.
         * **{{ ui-key.yacloud.alb.label_discard-percent }}**: Set the percentage of logs to discard.

         You can set multiple rules.

   1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select three subnets for the load balancer nodes and enable traffic to these subnets.

      {% include [subnets-required](../../_includes/application-load-balancer/subnets-required.md) %}

   1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**. Set the listener settings:
      1. Enter the listener name.
      1. (Optional) Enable **{{ ui-key.yacloud.alb.section_external-address-specs }}**. Set the **{{ ui-key.yacloud.alb.label_port }}** to `80` and the **{{ ui-key.yacloud.common.type }}** to:
         * `{{ ui-key.yacloud.alb.label_address-auto }}`.
         * `{{ ui-key.yacloud.alb.label_address-list }}`: Select an address from the drop-down list of the field that appears on the right.
      1. (Optional) Enable **{{ ui-key.yacloud.alb.section_internal-address-specs }}**. Specify **{{ ui-key.yacloud.alb.label_port }}** and select **{{ ui-key.yacloud.common.label_subnet }}** from the drop-down list.
      1. Under **{{ ui-key.yacloud.alb.section_common-address-specs }}**, select the listener type: `{{ ui-key.yacloud.alb.label_listener-type-http }}` or `{{ ui-key.yacloud.alb.label_listener-type-stream }}`.

         For `{{ ui-key.yacloud.alb.label_listener-type-http }}`, select:
         * Protocol: `{{ ui-key.yacloud.alb.label_proto-http-plain }}`, `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, or `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.
         * [HTTP router](http-router-create.md) from the drop-down list.

         For `{{ ui-key.yacloud.alb.label_listener-type-stream }}`, select a protocol:
         * `{{ ui-key.yacloud.alb.label_proto-stream-plain }}`: Select **{{ ui-key.yacloud.alb.label_backend-groups }}** from the drop-down list.
         * `{{ ui-key.yacloud.alb.label_proto-stream-tls }}`: Under **{{ ui-key.yacloud.alb.section_default-sni-match }}**, select **{{ ui-key.yacloud.alb.label_certificate }}** and **{{ ui-key.yacloud.alb.label_backend-groups }}** from the drop-down lists.
   1. Add more listeners if needed.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command to create an L7 load balancer:

      ```bash
      yc alb load-balancer create --help
      ```

   1. Run this command:

      ```bash
      yc alb load-balancer create <load_balancer_name> \
        --network-name <network_name> \
        --security-group-id <list_of_security_group_IDs> \
        --location subnet-name=<subnet_name>,zone=<availability_zone>
      ```

      Where:
      * `load_balancer_name`: Name of the new load balancer.
      * `--network-name`: Name of the network in which the load balancer is created.
      * `--security-group-id` (optional): List of one to five [security group](../concepts/application-load-balancer.md#security-groups) IDs separated by commas. If you omit this parameter, any traffic will be allowed for the load balancer.
      * `--location`: Subnet and availability zone. You can repeat the option multiple times to specify different availability zones and subnets.

      Result:

      ```text
      done (1m40s)
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje6********
        - zone_id: {{ region-id }}-d
          subnet_id: fo2ap2nrhjk9********
      log_group_id: eolul9ap0bv0********
      security_group_ids:
        - enpulh2tbrep********
        - enpg05a3ck35********
      created_at: "2021-04-26T12:12:13.624832586Z"
      ```

   1. (Optional) Set a limit on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling):

      {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

   1. (Optional) Set parameters for writing [logs](../logs-ref.md) to [{{ cloud-logging-full-name }}](../../logging/):
      1. View a description of the CLI command for enabling load balancer logging:

         ```bash
         yc alb load-balancer logging --help
         ```

      1. Link a log group to the load balancer and set up a [rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):

         ```bash
         yc alb load-balancer logging <load_balancer_name> \
           --log-group-id <log_group_ID> \
           --enable \
           --discard codes=[<HTTP_code>,<HTTP_code_class>,<gRPC_code>],percent=<percentage_of_logs_to_discard>
         ```

         Where:
         * `--log-group-id`: ID of the [log group](../../logging/concepts/log-group.md).
         * `--discard`: Rule for discarding logs. Rule parameters:
            * `codes`: HTTP status codes, classes of HTTP status codes, or gRPC codes.
            * `percent`: Percentage of logs to discard.

         You can set multiple rules.

         Result:

         ```text
         done (42s)
         id: ds76g83js9gf********
         name: test-load-balancer
         ...
         log_options:
           log_group_id: e23p9bfjvsgr********
           discard_rules:
             - http_codes:
                 - "200"
               http_code_intervals:
                 - HTTP_3XX
               grpc_codes:
                 - OK
               discard_percent: "90"
         ```

   1. Add a listener for an L7 load balancer:
      * HTTP listener:
         1. View a description of the CLI command for adding an HTTP listener for an L7 load balancer:

            ```bash
            yc alb load-balancer add-listener --help
            ```

         1. Add a listener by running the command:

            ```bash
            yc alb load-balancer add-listener <load_balancer_name> \
              --listener-name <listener_name> \
              --http-router-id <HTTP_router_ID> \
              --external-ipv4-endpoint port=<listener_port>
            ```

      * Stream listener:
         1. View a description of the CLI command for adding a Stream listener for an L7 load balancer:

            ```bash
            yc alb load-balancer add-stream-listener --help
            ```

         1. Add a listener by running the command:

            ```bash
            yc alb load-balancer add-stream-listener <load_balancer_name> \
              --listener-name=<listener_name> \
              --backend-group-id=<backend_group_ID> \
              --external-ipv4-endpoint port=<listener_port>
            ```

      The result of adding two listeners is:

      ```text
      done (42s)
      id: ds76g8b2op3f********
      name: test-load-balancer
      folder_id: b1gu6g9ielh6********
      status: ACTIVE
      network_id: enp0uulja5s3********
      listeners:
      - name: tslistener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 51.250.64.197
          ports:
          - "80"
        http:
          handler:
            http_router_id: ds7d7b14b3fs********
      - name: teststreamlistener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 51.250.64.197
          ports:
          - "443"
        stream:
          handler:
            backend_group_id: ds77tero4f5h********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: e9bs1hp7lgdl********
        - zone_id: {{ region-id }}-b
          subnet_id: e2le8i7hqa21********
        - zone_id: {{ region-id }}-d
          subnet_id: b0cgk1au6fn2********
      log_group_id: ckgs4u5km3u8********
      security_group_ids:
      - enp49ot04g63********
      created_at: "2022-04-04T02:12:40.160629110Z"
      log_options:
        log_group_id: e23p9bfjvsgr********
        discard_rules:
          - http_codes:
              - "200"
            http_code_intervals:
              - HTTP_3XX
            grpc_codes:
              - OK
            discard_percent: "90"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "<name_of_L7_load_balancer>"
        network_id  = "<network_ID>"
        security_group_ids = ["<list_of_security_group_IDs>"]

        allocation_policy {
          location {
            zone_id   = "<availability_zone>"
            subnet_id = "<subnet_ID>"
          }
        }

        listener {
          name = "<listener_name>"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [ 9000 ]
          }
          http {
            handler {
              http_router_id = "<HTTP_router_ID>"
            }
          }
        }

        log_options {
          log_group_id = "<log_group_ID>"
          discard_rule {
            http_codes          = ["<HTTP_code>"]
            http_code_intervals = ["<HTTP_code_class>"]
            grpc_codes          = ["<gRPC_code>"]
            discard_percent     = <percentage_of_logs_to_discard>
          }
        }
      }
      ```

      Where:
      * `name`: Name of the L7 load balancer. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `network_id`: ID of the network in which the load balancer is created.
      * `security_group_ids` (optional): List of one to five [security group](../concepts/application-load-balancer.md#security-groups) IDs separated by commas.
         If you omit this parameter, any traffic will be allowed for the load balancer.
      * `allocation_policy`: Description of the L7 load balancer's [node location](../../application-load-balancer/concepts/application-load-balancer.md#lb-location). Specify the availability zone and subnet IDs.
      * `listener`: Description of the L7 load balancer's [listener](../../application-load-balancer/concepts/application-load-balancer.md#listener) parameters:
         * `name`: Listener name. The name format is as follows:

            {% include [name-format](../../_includes/name-format.md) %}

         * `endpoint`: Description of the listener's addresses and ports. Set the external IPv4 address and port for receiving traffic. If the `external_ipv4_address` parameter is not set, a public IP address is assigned automatically.
         * `http`: Description of the listener's HTTP endpoint. Specify the HTTP router ID.
         * `log_options`: (Optional) Parameters for writing [logs](../logs-ref.md) to [{{ cloud-logging-full-name }}](../../logging/):
            * `log_group_id`: ID of the [log group](../../logging/concepts/log-group.md).
            * `discard_rule`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):
               * `http_codes`: HTTP status codes.
               * `http_code_intervals`: Classes of HTTP status codes.
               * `grpc_codes`: gRPC codes.
               * `discard_percent`: Percentage of logs to discard.

               You can set multiple rules.

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_load_balancer).
   1. Make sure the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

         ```bash
         yc alb load-balancer list
         ```

- API {#api}

   Use the [create](../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancer/Create](../api-ref/grpc/load_balancer_service.md#Create) gRPC API call.

{% endlist %}