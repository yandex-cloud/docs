# Editing L7 load balancer

To update the parameters of an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ alb-name }}**.
   1. Click the name of the load balancer you need.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
   1. Edit the load balancer settings.
   1. Under **Listeners**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the desired listener and select **Edit**.
   1. Edit the listener settings and click **Save**.
   1. (Optional) Under **Log settings**:

      1. Change the {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md) to write the load balancer logs to.
      1. Edit the [rules for discarding logs](../concepts/application-load-balancer.md#discard-logs-rules):

         * **HTTP codes**: Update the HTTP status codes.
         * **HTTP code classes**: Update the classes of HTTP status codes.
         * **gRPC codes**: Update the gRPC codes.
         * **Share of discarded logs**: Update the percentage of logs to discard.

         To add another rule, click **Add discard rule**.
   1. At the bottom of the page, click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating the load balancer parameters:

      ```bash
      yc alb load-balancer update --help
      ```

   1. Run the command, indicating the new load balancer parameters:

      ```bash
      yc alb load-balancer update <load_balancer_name> --new-name <new_load_balancer_name>
      ```

      Result:

      
      ```yaml
      id: a5d88ep483cmbfm.....
      name: test-balancer2-updated
      folder_id: aoe197919j8elpe.....
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d15178s.....
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
            http_router_id: a5dv7tjdo9gt2pq.....
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hvram.....
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje62sq.....
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9vpf.....
      log_group_id: eolul9ap0bv02i8.....
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
            * `percent`: Percentage of logs to be discarded.

         Result:

         ```yaml
         done (42s)
         id: ds76g2zpgp3fej1.....
         name: test-load-balancer
         folder_id: b1gug7dbelh690.....
         ...
         log_options:
           log_group_id: e23p9bcvh6gra3t.....
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

      Result of updating two listeners:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      status: ACTIVE
      network_id: enp0uulja5s3j1f.....
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
            http_router_id: ds7d7b14b3fsv7q.....
      - name: teststreamlistener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 51.250.64.197
          ports:
          - "443"
        stream:
          handler:
            backend_group_id: ds77tero4f5h46l.....
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: e9bs1hp7lgdl1g3.....
        - zone_id: {{ region-id }}-b
          subnet_id: e2le8i7hqa216f6.....
        - zone_id: {{ region-id }}-c
          subnet_id: b0cgk1au6fn203f.....
      log_group_id: ckgs4u5km3u8j9f.....
      security_group_ids:
      - enp49ot04g63ih1.....
      created_at: "2022-04-04T02:12:40.160629110Z"
      log_options:
        log_group_id: e23p9bfjvsgra3t.....
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

- {{ TF }}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/alb_load_balancer).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the L7 load balancer using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

- API

   Use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update) gRPC API call.

{% endlist %}

## Deleting a listener {#delete-listener}

To delete a listener for your L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ alb-name }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the load balancer name and select **Edit**.
   1. Under **Listeners**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the listener name and select **Delete**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI listener delete command:

      ```bash
      yc alb load-balancer remove-listener --help
      ```

   1. Run the following command:

      ```bash
      yc alb load-balancer remove-listener <load balancer ID or name> \
        --listener-name=<listener name>
      ```

      Result:

      ```text
      done (50s)
      ```

- {{ TF }}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/alb_load_balancer).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the L7 load balancer using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb load-balancer get <L7 load balancer name>
      ```

- API

   Use the [removeListener](../api-ref/LoadBalancer/removeListener.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/RemoveListener](../api-ref/grpc/load_balancer_service.md#RemoveListener) gRPC API call.

{% endlist %}
