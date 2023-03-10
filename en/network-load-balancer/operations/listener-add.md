# Adding a listener to a network load balancer

{% list tabs %}

- Management console

   To add a [listener](../concepts/listener.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you need to add a listener to a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to add a listener to, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Add listener**.
   1. In the window that opens:

      * Specify a port in the range of 1 to 32767 that the listener will receive incoming traffic on.
      * Specify a target port in the range of 1 to 32767 that the load balancer will send traffic to.
      * Click **Add**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a listener to a network load balancer:

   1. Get the list of load balancers:

      
      ```
      yc load-balancer network-load-balancer list
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      | c58r8boim8qfkcqtuioj | test-load-balancer | {{ region-id }} | EXTERNAL |              0 |                        | INACTIVE |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+

      ```



   1. Add the listener by entering the name, port, and IP address version:

      ```
      yc load-balancer network-load-balancer add-listener c580id04kvumgn7ssfh1 \
        --listener name=test-listener,port=80,external-ip-version=ipv4
      .....done
      id: c58r8boim8qfkcqtuioj
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2019-04-01T09:29:25Z"
      name: test-load-balancer
      region_id: {{ region-id }}
      status: INACTIVE
      type: EXTERNAL
      listeners:
      - name: test-listener
        address: <listener IP address>
        port: "80"
        protocol: TCP
      ```

- API

   You can add a listener using the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and add the `listener` section to the network load balancer description.

      ```hcl
      ...
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "my-network-load-balancer"
        listener {
          name = "my-listener"
      	 port = 9000
          external_address_spec {
            ip_version = "ipv4"
          }
        }
        attached_target_group {
          target_group_id = "${yandex_lb_target_group.my-target-group.id}"
          healthcheck {
            name = "http"
              http_options {
                port = 9000
                path = "/ping"
              }
          }
        }
      }
      ...
      ```

      Where:

      * `name`: The name of the network load balancer. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `listener`: Description of the network load balancer's [listener](../concepts/listener.md) parameters:
         * `name`: The name of the listener. Name format:

            {% include [name-format](../../_includes/name-format.md) %}

         * `Port`: A port in the range of 1 to 32767 that the network load balancer will receive incoming traffic on.
         * `external_address_spec`: External IP address specification. Set the IP address version (ipv4 or ipv6). Defaults to ipv4.
      * `attached_target_group`: A description of the network load balancer's target group parameters:
         * `target_group_id`: Target group ID.
         * `healthcheck`: Health check parameters. Enter a name, a port number ranging from 1 to 32767, and a path for health checks.

      For more information about the `yandex_lb_network_load_balancer` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the network load balancer using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc load-balancer network-load-balancer get <name of network load balancer>
      ```

{% endlist %}

## Examples

### Adding a listener to an internal network load balancer {#internal-listener}

{% list tabs %}

- CLI

   Run the command, indicating the listener name, port, subnet ID, and internal address from the range of subnet addresses:

   ```
   yc load-balancer network-load-balancer add-listener b7rc2h753djb3a5dej1i \
     --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj,internal-address=10.10.0.14
   ```

- {{ TF }}

   1. Open the {{ TF }} configuration file and add the `listener` section to the internal network load balancer description.

      {% cut "Example of adding a listener to an internal network load balancer using {{ TF }}" %}

      ```
      resource "yandex_lb_network_load_balancer" "internal-lb-test" {
        name = "internal-lb-test"
        type = "internal"
        listener {
          name = "my-listener"
      	     port = 9000
          internal_address_spec {
            subnet_id  = "b0cp4drld130kuprafls"
            ip_version = "ipv4"
          }
        }
      }
      ```

      {% endcut %}

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc load-balancer network-load-balancer get <name of internal network load balancer>
         ```

{% endlist %}
