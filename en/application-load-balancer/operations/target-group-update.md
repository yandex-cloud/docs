# Edit a target group

You can add or remove VMs from a target group.

## Add a VM to a target group {#add-targets}

To add a VM to a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the target group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click on the name of the group you need.
   1. Click **Add targets**.
   1. Select the appropriate VMs and click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for adding resources to target groups:
      ```
      yc alb target-group add-targets --help
      ```

   1. Run the command, specifying the target group name, subnet name, and internal IP address of the VM:
      ```
      yc alb target-group --name <target group name> add-targets \
        --target subnet-name=<subnet name>,ip-address=<VM's internal IP address>
      ```

      Result:
      ```
      done (1s)
      id: a5daisped2unjsnbjhhl
      name: test-tg
      folder_id: aoe197919j8elpeg1lkp
      targets:
      - ip_address: 10.130.0.28
        subnet_id: buc4gsmpj8hvramg61g8
      - ip_address: 10.128.0.34
        subnet_id: fo2ap2nrhjk9vpfdnno8
      - ip_address: 10.129.0.30
        subnet_id: blt6pcatjje62sqvjq5b
      - ip_address: 10.128.0.32
        subnet_id: blt6pca13je62sqvjq5b
      created_at: "2021-02-11T11:16:27.770674538Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and add the `target` section with target parameters to the fragment describing the target group:

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
      
        target {
          subnet_id    = "<subnet ID>"
          ip_address   = "<internal IP address of VM 4>"
        }
      }
      ```

      Where `yandex_alb_target_group` specifies the target group parameters:
      * `name`: Target group name.
      * `target`: Target parameters:
        * `subnet_id`: ID of the subnet hosting the VM. You can get a list of available subnets using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list`.
        * `ip_address`: VM's internal IP. You can get a list of internal IP addresses using the [CLI](../../cli/quickstart.md) command: `yc vpc subnet list-used-addresses --id <subnet ID>`.

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify that the target group has been updated in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb target-group get --name <target group name>
      ```

{% endlist %}

## Remove a VM from a target group {#remove-targets}

To remove a VM from a target group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the target group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click on the name of the group you need.
   1. Select the VM and click **Delete** at the bottom of the screen.
   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for removing resources from a target group:
      ```
      yc alb target-group remove-targets --help
      ```

   1. Run the following command with the target group name, subnet name, and internal IP address of the VM:
      ```
      yc alb target-group --name <target group name> \
      remove-targets --target subnet-name=<subnet name>,ip-address=<VM's internal IP address>
      ```

      Result:
      ```
      done (1s)
      id: a5daisped2unjsnbjhhl
      name: test-tg
      folder_id: aoe197919j8elpeg1lkp
      targets:
      - ip_address: 10.130.0.28
        subnet_id: buc4gsmpj8hvramg61g8
      - ip_address: 10.128.0.34
        subnet_id: fo2ap2nrhjk9vpfdnno8
      - ip_address: 10.129.0.30
        subnet_id: blt6pcatjje62sqvjq5b
      created_at: "2021-02-11T11:16:27.770674538Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and delete the `target` section with the IP address of the VM to be removed in the fragment describing the target group:

      Sample target group description in the {{ TF }} configuration:

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

      For more information about the `yandex_alb_target_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-targetgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify that the target group has been updated in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb target-group get --name <target group name>
      ```

{% endlist %}
