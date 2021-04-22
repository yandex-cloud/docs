# Delete a target group

To delete a target group:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the target group belongs to.

  1. Select **{{ alb-name }}**.

  1. In the left menu, select **Target groups**.

  1. Select the target group and click ![image](../../_assets/dots.svg).

  1. In the menu that opens, select **Delete**.

      To do this with multiple groups, select the groups to delete from the list and click **Delete** at the bottom of the screen.

  1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the command:

  ```
  yc alb target-group delete <target group name or ID>
  ```

{% endlist %}

