# Edit a target group

You can add or remove VMs from the target group.

## Add VMs to a target group {#add-targets}

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

  Run the command with the target group name, subnet ID, and internal IP address of the VM:

  ```
  yc alb target-group --name test-tg add-targets --target subnet-name=sg-subnet,ip-address=10.0.0.24
  ```

{% endlist %}

## Remove VMs from the target group {#remove-targets}

To remove a VM from a target group:

{% list tabs %}

- Management console

  To edit a target group:
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

  Run the following command with the target group name, subnet name, and internal IP address of the VM:

  ```
  yc alb target-group --name test-tg \
  remove-targets --target subnet-name=<subnet name>,ip-address=<internal IP address of the VM>
  ```

{% endlist %}

