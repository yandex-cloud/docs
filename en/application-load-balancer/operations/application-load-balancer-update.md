# Edit an L7 load balancer

To update the parameters of an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ alb-name }}**.
   1. Click on the name of the load balancer you need.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
   1. Edit the load balancer settings.
   1. Under **Listeners**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the desired listener and select **Edit**.
   1. Edit the listener settings and click **Save**.
   1. At the bottom of the page, click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating the load balancer parameters:

      ```
      yc alb load-balancer update --help
      ```

   1. Run the command, indicating the new load balancer parameters:

      ```
      yc alb load-balancer update <load balancer name> --new-name <new load balancer name>
      ```

      Result:

      
      ```
      id: a5d88ep483cmbfm63g9t
      name: test-balancer2-updated
      folder_id: aoe197919j8elpeg1lkp
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d15178sa87k0
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
            http_router_id: a5dv7tjdo9gt2pq5l906
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hvramg61g8
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje62sqvjq5b
        - zone_id: {{ region-id }}-c
          subnet_id: fo2ap2nrhjk9vpfdnno8
      log_group_id: eolul9ap0bv02i8bsp87
      created_at: "2021-04-26T12:12:13.624832586Z"
      ```



   1. Set new parameters for the listener:

      * HTTP listener:

         1. View a description of the CLI command for updating the parameters of an HTTP listener for an L7 load balancer:

            ```
            yc alb load-balancer update-listener --help
            ```

         1. Run the command, indicating the new listener parameters:

            ```
            yc alb load-balancer update-listener <load balancer name> \
              --listener-name <listener name> \
              --http-router-id <HTTP router ID> \
              --external-ipv4-endpoint port=<listener port>
            ```

      * Stream listener:

         1. View a description of the CLI command for updating the parameters of a Stream listener for an L7 load balancer:

            ```
            yc alb load-balancer update-stream-listener --help
            ```

         1. Run the command, indicating the new listener parameters:

            ```
            yc alb load-balancer update-stream-listener <load balancer name> \
              --listener-name=<listener name> \
              --backend-group-id=<backend group ID> \
              --external-ipv4-endpoint port=<listener port>
            ```

      Result of updating two listeners:

      ```
      done (42s)
      id: ds76g8b2op3fej12nab6
      name: test-load-balancer
      folder_id: b1gu6g9ielh690at5bm7
      status: ACTIVE
      network_id: enp0uulja5s3j1ftvfei
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
            http_router_id: ds7d7b14b3fsv7qjkvel
      - name: teststreamlistener
        endpoints:
        - addresses:
          - external_ipv4_address:
              address: 51.250.64.197
          ports:
          - "443"
        stream:
          handler:
            backend_group_id: ds77tero4f5h46l4e2gl
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: e9bs1hp7lgdl1g3n6ci1
        - zone_id: {{ region-id }}-b
          subnet_id: e2le8i7hqa216f6i6php
        - zone_id: {{ region-id }}-c
          subnet_id: b0cgk1au6fn203f3tqnf
      log_group_id: ckgs4u5km3u8j9f360md
      security_group_ids:
      - enp49ot04g63ih1scuap
      created_at: "2022-04-04T02:12:40.160629110Z"
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
      }
      ...
      ```

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_load_balancer).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the L7 load balancer using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc alb load-balancer get <L7 load balancer name>
      ```

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
      ```
      yc alb load-balancer remove-listener --help
      ```

   1. Run the command:
      ```
      yc alb load-balancer remove-listener <load balancer ID or name> \
        --listener-name=<listener name>
      ```

      Result:
      ```
      done (50s)
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_load_balancer).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the L7 load balancer using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc alb load-balancer get <L7 load balancer name>
      ```

{% endlist %}
