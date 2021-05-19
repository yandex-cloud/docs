# Edit a target group

You can add or remove VMs from a target group.

## Add a VM to a target group {#add-targets}

To add a VM to a target group:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the target group belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **Target group** section.
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
     --target subnet-name=<subnet name>,ip-address=<internal IP address of the VM>
     ```

     Command execution result:

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

{% endlist %}

## Remove a VM from a target group {#remove-targets}

To remove a VM from a target group:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the target group belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **Target group** section.
  1. Click on the name of the group you need.
  1. Click **Edit**.
  1. Select the VM and click ![image](../../_assets/dots.svg).
  1. In the menu that opens, select **Delete**.
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
     remove-targets --target subnet-name=<subnet name>,ip-address=<internal IP address of the VM>
     ```

     Command execution result:

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

{% endlist %}

