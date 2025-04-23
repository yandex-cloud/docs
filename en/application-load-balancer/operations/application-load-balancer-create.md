---
title: How to create an L7 load balancer in {{ alb-full-name }}
description: In this tutorial, you will learn how to create an L7 load balancer.
---

# Creating an L7 load balancer

To create an [L7 load balancer](../concepts/application-load-balancer.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a load balancer.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. Specify the load balancer name.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:
     1. [Network](../../vpc/concepts/network.md#network) whose [subnets](../../vpc/concepts/network.md#subnet) will host load balancer nodes.
     1. Relevant [security groups](../concepts/application-load-balancer.md#security-groups):

        {% include [security-groups](../../_includes/application-load-balancer/security-groups.md) %}

        {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the load balancer node subnets in different [availability zones](../../overview/concepts/geo-scope.md) and enable their traffic.

      If you do not want to create a load balancer node in a specific availability zone, click ![xmark](../../_assets/console-icons/xmark.svg) next to it.


  1. Optionally, under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, enable or disable incoming traffic for each availability zone using **{{ ui-key.yacloud.alb.label_disable-traffic }}**.

  1. Optionally, under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set the [resource unit](../concepts/application-load-balancer.md#lcu-scaling) limit.

     Resource units will scale automatically depending on load balancer traffic and specified limits. The number of resource units used affects the [load balancer pricing](../pricing.md).
  1. Optionally, under **{{ ui-key.yacloud.alb.section_logs-settings }}**:
     1. Enable **{{ ui-key.yacloud.alb.label_log-requests }}**.
     1. Select the [{{ cloud-logging-full-name }}](../../logging/) [log group](../../logging/concepts/log-group.md) where you want to store load balancer logs.
     1. Click **{{ ui-key.yacloud.alb.button_add-discard-rule }}** and configure its [settings](../concepts/application-load-balancer.md#discard-logs-rules):
        * **{{ ui-key.yacloud.alb.label_discard-http-codes }}**: Add HTTP status codes.
        * **{{ ui-key.yacloud.alb.label_discard-http-code-intervals }}**: Add HTTP status code classes.
        * **{{ ui-key.yacloud.alb.label_discard-grpc-codes }}**: Add gRPC codes.
        * **{{ ui-key.yacloud.alb.label_discard-percent }}**: Set the log discard rate.

        You can add multiple rules.

  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and specify listener settings:
     1. Specify the listener name.
     1. Optionally, enable **{{ ui-key.yacloud.alb.section_external-address-specs }}**. Set **{{ ui-key.yacloud.alb.label_port }}** to `80` and select **{{ ui-key.yacloud.common.type }}**:
        * `{{ ui-key.yacloud.alb.label_address-auto }}`.
        * `{{ ui-key.yacloud.alb.label_address-list }}`: Select an address from the drop-down list that appears on the right.
     1. Optionally, enable **{{ ui-key.yacloud.alb.section_internal-address-specs }}**. Specify **{{ ui-key.yacloud.alb.label_port }}** and select **{{ ui-key.yacloud.common.label_subnet }}** from the drop-down list.
     1. Under **{{ ui-key.yacloud.alb.section_common-address-specs }}**, select the listener type: `{{ ui-key.yacloud.alb.label_listener-type-http }}` or `{{ ui-key.yacloud.alb.label_listener-type-stream }}`.

        For `{{ ui-key.yacloud.alb.label_listener-type-http }}`, select:
        * `Protocol`: `{{ ui-key.yacloud.alb.label_proto-http-plain }}`, `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, or `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.
        * [`HTTP router`](http-router-create.md): Select it from the drop-down list.

        For `{{ ui-key.yacloud.alb.label_listener-type-stream }}`, select a protocol:
        * `{{ ui-key.yacloud.alb.label_proto-stream-plain }}`: Select **{{ ui-key.yacloud.alb.label_backend-groups }}** from the drop-down list.
        * `{{ ui-key.yacloud.alb.label_proto-stream-tls }}`: Under **{{ ui-key.yacloud.alb.section_default-sni-match }}**, select **{{ ui-key.yacloud.alb.label_certificate }}** and **{{ ui-key.yacloud.alb.label_backend-groups }}** from the drop-down lists.
  1. Add more listeners if needed.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for creating an L7 load balancer:

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
     * `<load_balancer_name>`: New load balancer name.
     * `--network-name`: Name of the network containing the load balancer.
     * `--security-group-id`: Comma separated list of one to five [security group](../concepts/application-load-balancer.md#security-groups) IDs. This is an optional setting. If you skip it, the load balancer will accept all traffic.
     * `--location`: Subnet and availability zone. You can add this option multiple times to specify different availability zones and subnets.

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
     log_group_id: eolul9ap0bv0********
     security_group_ids:
       - enpulh2tbrep********
       - enpg05a3ck35********
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. Optionally, set the [resource unit](../concepts/application-load-balancer.md#lcu-scaling) limit:

     {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

  1. Optionally, configure [{{ cloud-logging-full-name }}](../../logging/) [settings](../logs-ref.md):
     1. See the description of the CLI command for enabling load balancer logging:

        ```bash
        yc alb load-balancer logging --help
        ```

     1. Specify the load balancer log group and set up a [log discard rule](../concepts/application-load-balancer.md#discard-logs-rules):

        ```bash
        yc alb load-balancer logging <load_balancer_name> \
          --log-group-id <log_group_ID> \
          --enable \
          --discard codes=[<HTTP_code>,<HTTP_code_class>,<gRPC_code>],percent=<discarded_log_percentage>
        ```

        Where:
        * `--log-group-id`: [Log group](../../logging/concepts/log-group.md) ID.
        * `--discard`: Log discard rule. Rule options:
          * `codes`: HTTP codes, HTTP code classes, or gRPC codes.
          * `percent`: Log discard rate.

        You can add multiple rules.

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

  1. Add a listener to an L7 load balancer:
     * HTTP listener.
       1. See the description of the CLI command for adding an HTTP listener to an L7 load balancer:

          ```bash
          yc alb load-balancer add-listener --help
          ```

       1. Add a listener by running this command:

          ```bash
          yc alb load-balancer add-listener <load_balancer_name> \
            --listener-name <listener_name> \
            --http-router-id <HTTP_router_ID> \
            --external-ipv4-endpoint port=<listener_port>
          ```

     * Stream listener.
       1. See the description of the CLI command for adding a Stream listener to an L7 load balancer:

          ```bash
          yc alb load-balancer add-stream-listener --help
          ```

       1. Add a listener by running this command:

          ```bash
          yc alb load-balancer add-stream-listener <load_balancer_name> \
            --listener-name=<listener_name> \
            --backend-group-id=<backend_group_ID> \
            --external-ipv4-endpoint port=<listener_port>
          ```

     The result of adding two listeners:
 
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

  1. In the configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "<L7_load_balancer_name>"
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
           discard_percent     = <discarded_log_percentage>
         }
       }
     }
     ```

     Where:
     * `name`: L7 load balancer name. Follow these naming requirements:

       {% include [name-format](../../_includes/name-format.md) %}

     * `network_id`: ID of the network that will host your load balancer.
     * `security_group_ids`: Comma separated list of one to five [security group](../concepts/application-load-balancer.md#security-groups) IDs. This is an optional setting.
         If you skip it, the load balancer will accept all traffic.
     * `allocation_policy`: L7 load balancer's [node location](../../application-load-balancer/concepts/application-load-balancer.md#lb-location). Specify the availability zones and subnet IDs.
     * `listener`: L7 load balancer's [listener](../../application-load-balancer/concepts/application-load-balancer.md#listener) settings:
        * `name`: Listener name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}

        * `endpoint`: Listener addresses and ports. Specify the external IPv4 address and port for receiving traffic. If the `external_ipv4_address` setting is not specified, a public IP address will be assigned automatically.
        * `http`: Listener HTTP endpoint description. Specify the HTTP router ID.
        * `log_options`: Optional [logging](../logs-ref.md) settings for [{{ cloud-logging-full-name }}](../../logging/):
          * `log_group_id`: [Log group](../../logging/concepts/log-group.md) ID.
          * `discard_rule`: [Log discard rule](../concepts/application-load-balancer.md#discard-logs-rules).
            * `http_codes`: HTTP codes.
            * `http_code_intervals`: HTTP code classes.
            * `grpc_codes`: gRPC codes.
            * `discard_percent`: Log discard rate.

            You can add multiple rules.

     For more information about `yandex_alb_load_balancer` properties in {{ TF }}, see [this]({{ tf-provider-resources-link }}/alb_load_balancer) {{ TF }} article.
  1. Make sure the configuration files are correct.
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If your configuration is correct, you will see a detailed list of new resources; otherwise, {{ TF }} will show configuration errors.
  1. Deploy your cloud resources.
     1. If your configuration is correct, run this command:

        ```bash
        terraform apply
        ```

     1. Type `yes` and press **Enter** to confirm changes.

        After that, your resources will appear in the specified folder. You can check your new resources and their settings in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

        ```bash
        yc alb load-balancer list
        ```

- API {#api}

  Use the [create](../api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancer/Create](../api-ref/grpc/LoadBalancer/create.md) gRPC API call.

{% endlist %}