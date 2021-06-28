## Create target group

To create a target group:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where the target group will be created.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the left menu, select **Target groups**.
  1. Click **Create target group**.
  1. Enter a name for the target group: `test-target-group`.
  1. Select three VMs from different availability zones.
  1. Click **Create**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create target group command:

      ```
      yc alb target-group create --help
      ```

  1. Run the command, specifying the subnet name and the resource's internal IP address in the parameters:

     ```
     yc alb target-group create <target group name> \
     --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 1> \
     --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 2> \
     --target subnet-name=<subnet name>,ip-address=<internal IP address of VM 3> 
     ```

     Command execution result:

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

{% endlist %}

