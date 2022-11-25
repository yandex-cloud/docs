# Create an {{ alb-name }} target group

Create VMs in the working folder by following the [instructions](../../compute/operations/index.md#vm-create).

To create a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your target group in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click **Create target group**.
   1. Enter a name for the target group: `test-target-group`.
   1. Select the VMs.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create target group command:
      ```
      yc alb target-group create --help
      ```

   1. Run the command, specifying the subnet name and the internal IP addresses of the VMs in the parameters:
      ```
      yc alb target-group create <target group name> \
        --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 1> \
        --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 2> \
        --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 3>
      ```

      Result:

      ```
      id: a5d751meibht4ev264pp
      name: test-target-group
      folder_id: aoerb349v3h4bupphtaf
      targets:
      - ip_address: 10.0.0.36
        subnet_id: bucp2nunecvqgobf7cve
      - ip_address: 10.1.0.8
        subnet_id: bltca464785h2eon18r9
      - ip_address: 10.2.0.12
        subnet_id: fo2tgfikh3hergif27iu
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      ```hcl
      resource "yandex_alb_target_group" "foo" {
        name           = "<target group name>"
      
        target {
          subnet_id    = "<subnet ID>"
          ip_address   = "<internal IP address of VM 1>"
        }
      
        target {
          subnet_id    = "<subnet ID>"
          ip_address   = "<internal IP address of VM 2>"
        }
      
        target {
          subnet_id    = "<subnet ID>"
          ip_address   = "<internal IP address of VM 3>"
        }
      }
      ```

      Where:

      * `yandex_alb_target_group` specifies the target group parameters:
        * `name`: Target group name.
        * `target`: Target parameters:
          * `subnet_id`: ID of the subnet hosting the VM. You can get a list of available subnets using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list`.
          * `ip_address`: VM's internal IP. You can get a list of internal IP addresses using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list-used-addresses --id <subnet ID>`.

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} creates all the required resources. You can check that the resources are there using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb target-group list
      ```

{% endlist %}
