# Create a target group

{% list tabs %}

- Management console

   To create a new [target group](../concepts/target-resources.md):

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a target group.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click **Create target group**.
   1. Enter the name of the target group.

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select the VMs to add to the target group.
   1. Click **Create**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create target group command:

      ```
      yc load-balancer target-group create --help
      ```

   1. Get a list of VMs:

      ```
      yc compute instance list
      ```

      Result:

      ```
      +----------------------+------------+---------------+---------+
      |          ID          |    NAME    |    ZONE ID    | STATUS  |
      +----------------------+------------+---------------+---------+
      ...
      | fhmajnpl7cvhl6v1s12i | test-vm-1  | {{ region-id }}-a | RUNNING |
      | fhmajv6f27n0a4a1sbml | test-vm-2  | {{ region-id }}-a | RUNNING |
      ...
      +----------------------+------------+---------------+---------+
      ```

   1. Choose the `ID` of the VM to add to a target group and get information about it:

      ```
      yc compute instance get fhmajnpl7cvhl6v1s12i
      ```

      Result:

      ```
        ...
        subnet_id: e9bhjah6j3k7e6v8t5fa
        primary_v4_address:
          address: 192.168.0.3
        ...
      ```

   1. Create a target group and add the appropriate VM to it as a target by specifying the `subnet-id` and `address` of the VM in the `--target` flag:

      ```
      yc load-balancer target-group create \
        --region-id {{ region-id }} \
        --name test-tg-1 \
        --target subnet-id=<subnet ID>,address=<internal IP address of resource>
      ```



- API

   You can create a new target group using the [create](../api-ref/TargetGroup/create.md) API method.

   Once the target group has been created, add targets that the load will be distributed across. You can use the [addTargets](../api-ref/TargetGroup/addTargets) method to add targets to a group.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `name`: Target group name.
      * `target` section: Target resource description:
         * `subnet_id`: ID of the subnet to which target objects are connected. All targets in the target group must be connected to the same subnet within the same availability zone. Required parameter.
         * `address`: Resource internal IP address. Required parameter.

      Example configuration file structure:

      {% if product == "yandex-cloud" %}

      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_lb_target_group" "foo" {
        name      = "my-target-group"

        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource>"
        }

        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource 2>"
        }
      }
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```hcl
      provider "yandex" {
        endpoint  = "{{ api-host }}:443"
        token     = "<static key of the service account>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "ru-central1-a"
      }

      resource "yandex_lb_target_group" "foo" {
        name      = "my-target-group"

        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource>"
        }

        target {
          subnet_id = "<subnet ID>"
          address   = "<internal IP address of resource 2>"
        }
      }
      ```

      For more information about the `yandex_lb_target_group` parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/lb_target_group).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      {% endif %}


      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}
