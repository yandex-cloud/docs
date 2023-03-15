# Create an L7 load balancer

To create an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a load balancer in.

   1. In the list of services, select **{{ alb-name }}**.

   1. Click **Create load balancer** and select **Manual**.

   1. Enter the name of your load balancer: `test-load-balancer`.

   1. Under **Network Settings**, select the network whose subnets will host the load balancer's nodes and the [appropriate security groups](../concepts/application-load-balancer.md#security-groups) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the load balancer).

   1. (Optional) In the **Autoscaling settings** section, set a limit on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling).

      The number of units will change automatically depending on the actual load on the load balancer and the limits set. The number of units affects the [load balancer pricing](../pricing.md).

   1. Under **Allocation**, select three subnets for the load balancer's nodes and enable traffic to these subnets.

   1. Click **Add listener** under **Listeners**. Set the listener settings:
      1. Enter the listener name: `test-listener`.
      1. (optional) Select the **Public IP address** option. Set the **Port** to `80` and the **Type** to
         * `Automatically`.
         * `List`: Select an address from the drop-down list of the field that appears on the right.
      1. (optional) Select the **Internal IP address** option. Specify the **Port** and select a subnet from the drop-down list in the **Subnet** field.
      1. Under **Receiving and processing traffic**, select the listener type: `HTTP` or `Stream`.

         For `HTTP`, select:

         * Protocol: `HTTP`, `HTTPS`, or `Redirect to HTTPS`.
         * [HTTP router](http-router-create.md) in the drop-down list.

         For `Stream`, select a protocol:

         * `Unencrypted`: Select **Backend groups** in the drop-down list.
         * `Encrypted`: Under **Main listener**, select **Certificates** and **Backend groups** from the drop-down lists.

   1. Add more listeners if needed.

   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create an L7 load balancer:
      ```bash
      yc alb load-balancer create --help
      ```

   1. Run the following command, specifying the network and subnets that will host the load balancer's nodes and the [appropriate security groups](../concepts/application-load-balancer.md#security-groups):
      ```bash
      yc alb load-balancer create <load_balancer_name> \
        --network-name <network_name> \
        --location subnet-name=<subnet_name>,zone=<availability_zone>
      ```

      You can use the `--location` option multiple times to specify different availability zones and subnets.

      Result:

      
      ```
      done (1m40s)
      id: a5d88ep483cmbfm63g9t
      name: test-balancer2
      folder_id: aoe197919j8elpeg1lkp
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d15178sa87k0
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



   1. (Optional) Set a limit on the number of [resource units](../concepts/application-load-balancer.md#lcu-scaling):

      {% include [autoscale-cli](../../_includes/application-load-balancer/autoscale-cli.md) %}

   1. Add a listener for an L7 load balancer:

      * HTTP listener:

         1. View a description of the CLI command for adding an HTTP listener for an L7 load balancer:

            ```
            yc alb load-balancer add-listener --help
            ```

         1. Add a listener by running the command:

            ```
            yc alb load-balancer add-listener <load balancer name> \
              --listener-name <listener name> \
              --http-router-id <HTTP router ID> \
              --external-ipv4-endpoint port=<listener port>
            ```

      * Stream listener:

         1. View a description of the CLI command for adding a Stream listener for an L7 load balancer:

            ```
            yc alb load-balancer add-stream-listener --help
            ```

         1. Add a listener by running the command:

            ```
            yc alb load-balancer add-stream-listener <load balancer name> \
              --listener-name=<listener name> \
              --backend-group-id=<backend group ID> \
              --external-ipv4-endpoint port=<listener port>
            ```

      Result of adding two listeners:

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

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "<L7 load balancer name>"
        network_id  = "<network ID>"

        allocation_policy {
          location {
            zone_id   = "<availability zone>"
            subnet_id = "<subnet ID>"
          }
        }

        listener {
          name = "<listener name>"
          endpoint {
            address {
              external_ipv4_address {
              }
            }
            ports = [ 9000 ]
          }
          http {
            handler {
              http_router_id = "<HTTP router ID>"
            }
          }
        }
      }
      ```

      Where:

      * `name`: Name of the L7 load balancer. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `network_id`: Network ID.
      * `allocation_policy`: Description of the L7 load balancer's [node location](../../application-load-balancer/concepts/application-load-balancer.md#lb-location). Specify the availability zone and subnet IDs.
      * `listener`: Description of the L7 load balancer's [listener](../../application-load-balancer/concepts/application-load-balancer.md#listener) parameters:
         * `name`: The name of the listener. Name format:

            {% include [name-format](../../_includes/name-format.md) %}

         * `endpoint`: Description of the listener's addresses and ports. Set the external IPv4 address and port for receiving traffic. If the `external_ipv4_address` parameter is not set, a public IP address is assigned automatically.
         * `http`: Description of the listener's HTTP endpoint. Specify the HTTP router ID.

      For more information about the `yandex_alb_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/alb_load_balancer).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Once you are done, all the resources you need will be created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc alb load-balancer list
         ```

{% endlist %}
