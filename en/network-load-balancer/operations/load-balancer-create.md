# Create a network load balancer

{% note info %}

Before creating a network load balancer, [create](target-group-create.md) a target group to attach to it.

{% endnote %}

{% list tabs %}

- Management console

   To create a [network load balancer](../concepts/index.md).

   1. In the [management console]({{ link-console-main }}), select the folder where you need to create a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Click **Create a network load balancer**.
   1. Enter a name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Assign a public IP address to the load balancer. You can assign an address automatically or select one from the list of reserved addresses.
   1. Under **Listeners**, click **Add listener**.
   1. In the window that opens, set the listener parameters:

      * **Name**.
      * **Port** in the range of 1 to 32767 that the load balancer will receive incoming traffic on.
      * **Target port** in the range of 1 to 32767 that the load balancer will send traffic to.

   1. Click **Add**.
   1. Under **Target groups,** click **Add target group**.
   1. Select a target group or [create a new one](target-group-create.md):

      * Click **Create target group**.
      * Enter the name of the target group.

         {% include [name-format](../../_includes/name-format.md) %}

      * Select the VMs to add to the target group.
      * Click **Create**.

   1. (optional) Under **Health check**, click **Configure** and in the window that opens:

      * Enter the health check name.

         {% include [name-format](../../_includes/name-format.md) %}

      * Select the check type: **HTTP** or **TCP**.
      * If you chose HTTP, specify the URL to check in the **Path** field.
      * Specify a port number from the range 1-32767.
      * Specify the response timeout in seconds.
      * Specify the interval, in seconds, for sending health check requests.
      * Set the performance threshold, meaning the number of successful checks required in order to consider the VM ready to receive traffic.
      * Specify the failure threshold, which is the number of failed checks after which no traffic will be routed to the VM.
      * Click **Apply**.

   1. Click **Create**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a network load balancer:

      ```
      yc load-balancer network-load-balancer create --help
      ```

   1. To create a load balancer with a [listener](../concepts/listener.md), run the following command in the terminal:

      ```
      yc load-balancer network-load-balancer create \
        --region-id {{ region-id }} \
        --name test-load-balancer-2 \
        --listener name=test-listener,external-ip-version=ipv4,port=80
      ```

   1. Get the list of all load balancers to make sure that the load balancer was created:

      ```
      yc load-balancer network-load-balancer list
      ```

- API

   You can create an new load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      ```hcl
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<name of network load balancer>"
        listener {
          name = "<listener name>"
      	 port = <port number>
          external_address_spec {
            ip_version = "ipv4"
          }
        }
        attached_target_group {
          target_group_id = "<target group ID>"
          healthcheck {
            name = "<health check name>"
              http_options {
                port = <port number>
                path = "/ping"
              }
          }
        }
      }
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

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc load-balancer network-load-balancer get <name of network load balancer>
         ```

{% endlist %}

## Examples

### Creating a network load balancer without a listener {without-listener}

{% list tabs %}

- CLI

   To create a load balancer without a listener, run the following command in the terminal:

   ```
   yc load-balancer network-load-balancer create \
     --region-id {{ region-id }} \
     --name test-load-balancer-1
   ```

- {{ TF }}

   1. In the configuration file, describe the resource parameters without the `listener` section:

      {% cut "Example of creating a network load balancer without a listener using {{ TF }}" %}

      ```
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "my-network-load-balancer"
      }
      ```

      {% endcut %}

      For more information about resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc load-balancer network-load-balancer get <name of network load balancer>
         ```

{% endlist %}

### Creating a network load balancer with a listener and attached target group {with-listener-and-target-group}

{% list tabs %}

- CLI

   1. To create a load balancer with a [listener](../concepts/listener.md) and immediately connect a previously [created](target-group-create.md) target group to it, get the list of target groups:

      ```
      yc load-balancer target-group list
      ```

      Result:

      
      ```
      +----------------------+-------------------+---------------------+-------------+--------------+
      |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
      +----------------------+-------------------+---------------------+-------------+--------------+
      | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | {{ region-id }} |            1 |
      +----------------------+-------------------+---------------------+-------------+--------------+
      ```



   1. Run the following command using the target group ID in the `target-group-id` parameter:

      ```
      yc load-balancer network-load-balancer create \
        --region-id {{ region-id }} \
        --name test-load-balancer-3 \
        --listener name=test-listener,external-ip-version=ipv4,port=80 \
        --target-group target-group-id=b7rjtf12qdeehrj31hri,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
      ```

      Mind the `healthcheck-interval` and `healthcheck-timeout` parameter format: the values must be in `Ns` format.

- {{ TF }}

   1. To create a network load balancer with a [listener](../concepts/listener.md), open the {{ TF }} configuration file and add the `listener` section to the network load balancer's description. To attach a target group, add the `attached_target_group` section and specify the target group in the `target_group_id` field.

      {% cut "Example of creating a network load balancer with a listener and attached target group using Terraform" %}

      ```
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
      ```

      {% endcut %}

      For more information about resources that you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_network_load_balancer).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc load-balancer network-load-balancer get <name of network load balancer>
         ```

{% endlist %}
