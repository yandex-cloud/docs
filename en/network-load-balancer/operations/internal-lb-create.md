# Create an internal network load balancer

{% if product == "yandex-cloud" %}

{% note warning %}

Internal load balancer will become [generally available](../../overview/concepts/launch-stages.md) and [paid](../pricing.md) on August 12th, 2022.

{% endnote %}

{% endif %}

{% note info %}

The internal load balancer's listener is assigned a random IP address from the range of addresses of the selected subnet.

{% endnote %}

{% list tabs %}

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Before creating a load balancer, [create](target-group-create.md) a target group to attach to it.

   1. View a description of the CLI command to create a network load balancer:

      ```
      yc load-balancer network-load-balancer create --help
      ```

   1. To create an internal load balancer with a [listener](../concepts/listener.md), run the following command:

      ```
      yc load-balancer network-load-balancer create \
        --name internal-lb-test \
        --type internal \
        --region-id {{ region-id }} \
        --listener name=test-listener,port=80,internal-subnet-id=<subnet ID>,internal-address=<internal IP address from subnet address range>
      ```

   1. Get the list of all load balancers to make sure that the load balancer was created:

      ```
      yc load-balancer network-load-balancer list
      ```

- API

   You can create an internal load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create an internal network load balancer with a listener:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `name`: The name of the network load balancer.
      * `type`: The type of the network load balancer. Use internal to create an `internal` network load balancer.
      * `listener`: The listener parameters.
         * `name`: The name of the listener.
         * `port`: The port to receive traffic.
         * `internal_address_spec`: The specification of the internal load balancer's listener.
            * `address`: Internal IP address from the range of the selected subnet.
            * `subnet_id`: The subnet..

      Example configuration file structure:

      {% if product == "yandex-cloud" %}

      ```hcl
      provider "yandex" {
          token     = "<OAuth or static key of service account>"
          folder_id = "<folder ID>"
          zone      = "{{ region-id }}-a"
        }

      resource "yandex_lb_network_load_balancer" "internal-lb-test" {
        name = "internal-lb-test"
        type = "internal"

        listener {
          name = "my-listener"
          port = 8080
          internal_address_spec {
            address   = "<internal IP address>"
            subnet_id = "<subnet ID>"
          }
        }
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```hcl
      provider "yandex" {
          token     = "<OAuth or static key of service account>"
          folder_id = "<folder ID>"
          zone      = "{{ region-id }}-a"
        }

      resource "yandex_lb_network_load_balancer" "internal-lb-test" {
        name = "internal-lb-test"
        type = "internal"

        listener {
          name = "my-listener"
          port = 8080
          internal_address_spec {
            address   = "<internal IP address>"
            subnet_id = "<subnet ID>"
          }
        }
      ```

  {% endif %}

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

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
      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

## Examples

### Creating an internal load balancer without a listener {#without-listener}

{% list tabs %}

- CLI

   To create an internal load balancer without a listener, run the command:

   ```
   yc load-balancer network-load-balancer create \
     --name internal-lb-test-1 \
     --type internal \
     --region-id {{ region-id }}
   ```

- {{ TF }}

   1. In the configuration file, describe the resource parameters without the `listener` section:

      {% cut "Example of creating an internal network load balancer without a listener using {{ TF }}" %}

      ```
      resource "yandex_lb_network_load_balancer" "internal-lb-test" {
        name = "internal-lb-test"
        type = "internal"
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
         yc load-balancer network-load-balancer get <name of internal network load balancer>
         ```

{% endlist %}

### Creating an internal load balancer with a listener and attached target group {#with-listener-and-target-group}

{% list tabs %}

- CLI

   1. To create an internal load balancer with a [listener](../concepts/listener.md) and immediately attach a target group to it, get the list of target groups:

      ```
      yc load-balancer target-group list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```
      +----------------------+------------------+---------------------+-------------+--------------+
      |          ID          |       NAME       |       CREATED       |  REGION ID  | TARGET COUNT |
      +----------------------+------------------+---------------------+-------------+--------------+
      | b7rv80bfibkph3ekqqle | test-internal-tg | 2020-08-09 07:49:18 | {{ region-id }} |            3 |
      +----------------------+------------------+---------------------+-------------+--------------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      +----------------------+------------------+---------------------+-----------+--------------+
      |          ID          |       NAME       |       CREATED       | REGION ID | TARGET COUNT |
      +----------------------+------------------+---------------------+-----------+--------------+
      | b7rv80bfibkph3ekqqle | test-internal-tg | 2020-08-09 07:49:18 | il1       |            3 |
      +----------------------+------------------+---------------------+-----------+--------------+
      ```

      {% endif %}

   1. Run the command:

      ```
      yc load-balancer network-load-balancer create \
        --name internal-lb-test-3 \
        --type internal \
        --region-id {{ region-id }} \
        --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj,internal-address=10.10.0.14 \
        --target-group target-group-id=b7rv80bfibkph3ekqqle,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
      ```

      Where `target-group-id` is the target group ID.

      Note the format of the `healthcheck-interval` and `healthcheck-timeout` parameters: specify their values as `Ns`, where `N` is the value in seconds.

- {{ TF }}

   1. To create an internal network load balancer with a [listener](../concepts/listener.md), open the {{ TF }} configuration file and add the `listener` section to the internal network load balancer's description. To attach a target group, add the `attached_target_group` section and specify the target group in the `target_group_id` field.

      {% cut "Example of creating an internal network load balancer with a listener and attached target group using {{ TF }}" %}

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
         yc load-balancer network-load-balancer get <name of internal network load balancer>
         ```

{% endlist %}
