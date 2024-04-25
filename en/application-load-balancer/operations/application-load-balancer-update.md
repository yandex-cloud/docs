---
title: "How to edit an L7 load balancer in {{ alb-full-name }}"
description: "Follow this guide to edit an L7 load balancer."
---

# Editing an L7 load balancer

To update the parameters of an L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click the name of the load balancer you need.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the required load balancer settings:

      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, update the [security groups](../concepts/application-load-balancer.md#security-groups):

         {% include [security-groups](../../_includes/application-load-balancer/security-groups.md) %}

      1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set a limit on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling).

      1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**:

         1. Change the {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
         1. Edit the [rules for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):

            * **{{ ui-key.yacloud.alb.label_discard-http-codes }}**: Update the HTTP status codes.
            * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}**: Update the classes of HTTP status codes.
            * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}**: Update the gRPC codes.
            * **{{ ui-key.yacloud.alb.label_discard-percent }}**: Update the percentage of logs to discard.

            To add another rule, click **{{ ui-key.yacloud.alb.button_add-discard-rule }}**.

      1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, change the parameters of the appropriate listeners.

   1. At the bottom of the page, click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating the load balancer parameters:

      ```bash
      yc alb load-balancer update --help
      ```

   1. Run the command, indicating the new load balancer parameters. For example, link [security groups](../concepts/application-load-balancer.md#security-groups) to the load balancer:

      ```bash
      yc alb load-balancer update <load_balancer_name> \
        --security-group-id <list_of_security_group_IDs>
      ```

      Where `--security-group-id` is a new list of one to five comma-separated [security group](../concepts/application-load-balancer.md#security-groups) IDs. If you omit this parameter, any traffic will be allowed for the load balancer.

      Result:

      
      ```bash
      id: a5d88ep483cm********
      name: test-balancer2-updated
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      listeners:
      - name: test-listener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 130.193.32.206
          ports:
          - "80"
        http:
          handler:
            http_router_id: a5dv7tjdo9gt********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
      log_group_id: eolul9ap0bv0********
      security_group_ids:
        - enpulh2tbrep********
        - enpg05a3ck35********
      created_at: "2021-04-26T12:12:13.624832586Z"
      ```



   1. (Optional) Update the parameters for writing [logs](../logs-ref.md) to [{{ cloud-logging-full-name }}](../../logging/):

      1. View a description of the CLI command for managing load balancer logging:

         ```bash
         yc alb load-balancer logging --help
         ```

      1. Add a new rule for discarding logs:

         ```bash
         yc alb load-balancer logging <load_balancer_name> \
           --log-group-id <log_group_ID> \
           --enable \
           --discard codes=[200,3XX,GRPC_OK],percent=90
         ```

         Where:

         * `--log-group-id`: ID of the [log group](../../logging/concepts/log-group.md).
         * `--discard`: [Rule for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules). Rule parameters:
            * `codes`: HTTP status codes, classes of HTTP status codes, or gRPC codes.
            * `percent`: Percentage of logs to discard.

         Result:

         ```bash
         done (42s)
         id: ds76g2zpgp3f********
         name: test-load-balancer
         folder_id: b1gug7dbelh********
         ...
         log_options:
           log_group_id: e23p9bcvh6gr********
           discard_rules:
             - http_codes:
                 - "200"
               http_code_intervals:
                 - HTTP_3XX
               grpc_codes:
                 - OK
               discard_percent: "90"
         ```

   1. Set new parameters for the listener:

      * HTTP listener:

         1. View a description of the CLI command for updating the parameters of an HTTP listener for an L7 load balancer:

            ```bash
            yc alb load-balancer update-listener --help
            ```

         1. Run the command, indicating the new listener parameters:

            ```bash
            yc alb load-balancer update-listener <load_balancer_name> \
              --listener-name <listener_name> \
              --http-router-id <HTTP_router_ID> \
              --external-ipv4-endpoint port=<listener_port>
            ```

      * Stream listener:

         1. View a description of the CLI command for updating the parameters of a Stream listener for an L7 load balancer:

            ```bash
            yc alb load-balancer update-stream-listener --help
            ```

         1. Run the command, indicating the new listener parameters:

            ```bash
            yc alb load-balancer update-stream-listener <load_balancer_name> \
              --listener-name=<listener_name> \
              --backend-group-id=<backend_group_id> \
              --external-ipv4-endpoint port=<listener_port>
            ```

      The result of updating two listeners is:

      ```bash
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

   1. (Optional) Set new limits on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling):

      {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and edit the fragment with the L7 load balancer description:

      ```hcl
      ...
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "my-load-balancer"
        network_id  = yandex_vpc_network.test-network.id

        allocation_policy {
          location {
            zone_id   = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.test-subnet.id
            security_group_ids = ["<list_of_security_group_IDs>"]
          }
        }

        listener {
          name = "my-listener"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [ 9000 ]
          }
          http {
            handler {
              http_router_id = yandex_alb_http_router.test-router.id
            }
          }
        }

        log_options {
          log_group_id = "<log_group_ID>"
          discard_rule {
            http_codes          = ["200"]
            http_code_intervals = ["HTTP_2XX"]
            grpc_codes          = ["GRPC_OK"]
            discard_percent     = 15
          }
        }
      }
      ...
      ```

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_load_balancer).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the L7 load balancer update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

- API {#api}

   Use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update) gRPC API call.

{% endlist %}

## Deleting a listener {#delete-listener}

To delete a listener for your L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer name and select **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the listener name and select **{{ ui-key.yacloud.common.delete }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI listener delete command:

      ```bash
      yc alb load-balancer remove-listener --help
      ```

   1. Run this command:

      ```bash
      yc alb load-balancer remove-listener <load_balancer_name_or_ID> \
        --listener-name=<listener_name>
      ```

      Result:

      ```text
      done (50s)
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Open the {{ TF }} configuration file and delete the `listener` section from the L7 load balancer description.

      ```hcl
      ...
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "my-load-balancer"
        network_id  = yandex_vpc_network.test-network.id

        allocation_policy {
          location {
            zone_id   = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.test-subnet.id
          }
        }

        listener {
          name = "my-listener"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [ 9000 ]
          }    
          http {
            handler {
              http_router_id = yandex_alb_http_router.test-router.id
            }
          }
        }    
      }
      ...
      ```

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_load_balancer).

   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the L7 load balancer using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb load-balancer get <L7_load_balancer_name>
      ```

- API {#api}

   Use the [removeListener](../api-ref/LoadBalancer/removeListener.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/RemoveListener](../api-ref/grpc/load_balancer_service.md#RemoveListener) gRPC API call.

{% endlist %}
