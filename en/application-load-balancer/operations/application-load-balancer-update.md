---
title: How to edit an L7 load balancer in {{ alb-full-name }}
description: In this tutorial, you will learn how to edit an L7 load balancer.
---

# Editing an L7 load balancer

To change L7 load balancer settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click the name of the load balancer you need.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the load balancer settings:

      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, change the [security groups](../concepts/application-load-balancer.md#security-groups):

          {% include [security-groups](../../_includes/application-load-balancer/security-groups.md) %}

          {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

      1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, enable or disable incoming traffic for each availability zone using the **{{ ui-key.yacloud.alb.label_disable-traffic }}** option.

      1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set the [resource unit](../concepts/application-load-balancer.md#lcu-scaling) limit.

      1. Under **{{ ui-key.yacloud.alb.section_logs-settings }}**:

          1. Change the {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) storing your load balancer logs.
          1. Edit [log discard rules](../concepts/application-load-balancer.md#discard-logs-rules):
    
              * **{{ ui-key.yacloud.alb.label_discard-http-codes }}**: Update the HTTP status codes.
              * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}**: Update the HTTP status code classes.
              * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}**: Update the gRPC codes.
              * **{{ ui-key.yacloud.alb.label_discard-percent }}**: Update the log discard rate.
    
              To add another rule, click **{{ ui-key.yacloud.alb.button_add-discard-rule }}**.
    
      1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, change listener settings.

  1. At the bottom of the page, click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating load balancer settings:

     ```bash
     yc alb load-balancer update --help
     ```

  1. Run this command with new load balancer settings specified. For example, specify the load balancer [security groups](../concepts/application-load-balancer.md#security-groups):

     ```bash
     yc alb load-balancer update <load_balancer_name> \
       --security-group-id <list_of_security_group_IDs>
     ```

     Where `--security-group-id` is a comma separated list of one to five new [security group](../concepts/application-load-balancer.md#security-groups) IDs. If you skip it, the load balancer will accept all traffic.

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

  1. Optionally, update the [{{ cloud-logging-full-name }}](../../logging/) [logging](../logs-ref.md) settings:

      1. See the description of the CLI command for managing load balancer logging:

          ```bash
          yc alb load-balancer logging --help
          ```

      1. Add a new log discard rule:

          ```bash
          yc alb load-balancer logging <load_balancer_name> \
            --log-group-id <log_group_ID> \
            --enable \
            --discard codes=[200,3XX,GRPC_OK],percent=90
          ```

          Where:

          * `--log-group-id`: [Log group](../../logging/concepts/log-group.md) ID.
          * `--discard`: [Log discard rule](../concepts/application-load-balancer.md#discard-logs-rules). Rule options:
            * `codes`: HTTP codes, HTTP code classes, or gRPC codes.
            * `percent`: Log discard rate.

          Result:

          ```text
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

  1. Specify new listener settings:

     * HTTP listener:

       1. See the description of the CLI command for updating L7 load balancer HTTP listener settings:

          ```bash
          yc alb load-balancer update-listener --help
          ```

       1. Run this command with new listener settings specified:

          ```bash
          yc alb load-balancer update-listener <load_balancer_name> \
            --listener-name <listener_name> \
            --http-router-id <HTTP_router_ID> \
            --external-ipv4-endpoint port=<listener_port>
          ```

     * Stream listener:

       1. See the description of the CLI command for updating the L7 load balancer Stream listener settings:

          ```bash
          yc alb load-balancer update-stream-listener --help
          ```

       1. Run this command with new listener settings specified:

          ```bash
          yc alb load-balancer update-stream-listener <load_balancer_name> \
            --listener-name=<listener_name> \
            --backend-group-id=<backend_group_ID> \
            --external-ipv4-endpoint port=<listener_port>
          ```

     The result of updating two listeners:

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

  1. Optinally, update the [resource unit](../concepts/application-load-balancer.md#lcu-scaling) limit:

     {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment describing the L7 load balancer:

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

     For more information about `yandex_alb_load_balancer` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_load_balancer).

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

     You will see a detailed list of new resources. No changes will be made at this step. If the configuration contains errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm changes.

     You can check whether the L7 load balancer configuration was updated correctly in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb load-balancer get <load_balancer_name>
     ```

- API {#api}

  Use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md) gRPC API call.

{% endlist %}

## Deleting a listener {#delete-listener}

To delete a listener from your L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer you need, then select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, next to the listener you want to delete, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a listener:

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

     For more information about `yandex_alb_load_balancer` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_load_balancer).

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

     You will see a detailed list of new resources. No changes will be made at this step. If the configuration contains errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm changes.

     You can check whether the L7 load balancer configuration was updated correctly in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb load-balancer get <L7_load_balancer_name>
     ```

- API {#api}

  Use the [removeListener](../api-ref/LoadBalancer/removeListener.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/RemoveListener](../api-ref/grpc/LoadBalancer/removeListener.md) gRPC API call.

{% endlist %}
