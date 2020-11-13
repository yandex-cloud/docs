# Create an internal network load balancer

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

{% note info %}

The internal load balancer's listener is assigned a random IP address from the range of addresses of the selected subnet.

{% endnote %}

{% list tabs %}

- CLI

  If you don't have the {{ yandex-cloud }} command-line interface, [install it](../../cli/quickstart.md#install).

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Before creating a load balancer, [create](target-group-create.md) a target group to attach to it.

  1. View a description of the CLI command to create a network load balancer:

     ```
     $ yc load-balancer network-load-balancer create --help
     ```

  1. To create an internal load balancer with a [listener](../concepts/listener.md), run the following command:

     ```
     $ yc load-balancer network-load-balancer create \
     --name internal-lb-test \
     --type internal \
     --region-id ru-central1 \
     --listener name=test-listener,port=80,internal-subnet-id=<subnet ID>
     ```

  1. Get the list of all load balancers to make sure that the load balancer was created:

     ```
     $ yc load-balancer network-load-balancer list
     ```

- API

  You can create an internal load balancer using the [create](../api-ref/NetworkLoadBalancer/create.md) API method.

- Terraform

  {% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create an internal network load balancer with a listener:

  1. In the configuration file, describe the parameters of resources that you want to create:
     * `name`: The name of the network load balancer.
     * `type`: The type of the network load balancer. Use `internal` to create an internal network load balancer.
     * `listener`: The listener parameters.
       * `name`: The name of the listener.
       * `port`: The port to receive traffic.
       * `intenal_address_spec`: The specification of the internal load balancer's listener.
         * `subnet_id`: The subnet ID.

     Example configuration file structure:

     ```
     provider "yandex" {
         token = "<OAuth or static key of service account>"
         folder_id = "<folder ID>"
         zone      = "ru-central1-a"
       }
     
     resource "yandex_lb_network_load_balancer" "internal-lb-test" {
       name = "internal-lb-test"
       type = "internal"
     
       listener {
         name = "my-listener"
         port = 8080
         internal_address_spec {
           subnet_id = "<Subnet ID>"
         }
       }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.
     1. In the command line, go to the directory where you created the configuration file.
     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```
     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

## Examples

### Creating an internal load balancer without a listener {#without-listener}

{% list tabs %}

- CLI

  To create an internal load balancer without a listener, run the command:

  ```
  $ yc load-balancer network-load-balancer create \
  --name internal-lb-test-1 \
  --type internal \
  --region-id ru-central1
  ```

{% endlist %}

### Creating an internal load balancer with a listener and attached target group {#with-listener-and-target-group}

{% list tabs %}

- CLI

  1. To create an internal load balancer with a [listener](../concepts/listener.md) and immediately attach a target group to it, get the list of target groups:

     ```
     $ yc load-balancer target-group list
     +----------------------+------------------+---------------------+-------------+--------------+
     |          ID          |       NAME       |       CREATED       |  REGION ID  | TARGET COUNT |
     +----------------------+------------------+---------------------+-------------+--------------+
     | b7rv80bfibkph3ekqqle | test-internal-tg | 2020-08-09 07:49:18 | ru-central1 |            3 |
     +----------------------+------------------+---------------------+-------------+--------------+
     ```

  1. Run the command using the target group ID in the `target-group-id` parameter:

     ```
     $ load-balancer network-load-balancer create \
     --name internal-lb-test-3 \
     --type internal \
     --region-id ru-central1 \
     --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj \
     --target-group target-group-id=b7rv80bfibkph3ekqqle,healthcheck-name=http,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
     ```

     Note the format of the `healthcheck-interval` and `healthcheck-timeout` parameters: specify their values as `Ns`, where `N` is the value in seconds.

{% endlist %}

