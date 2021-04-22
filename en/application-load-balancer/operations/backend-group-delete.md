# Delete a backend group

To delete a backend group:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the backend group belongs to.

  1. Select **{{ alb-name }}**.

  1. In the left menu, select **Backend groups**.

  1. Select the backend group and click ![image](../../_assets/dots.svg).

  1. In the menu that opens, select **Delete**.

      To do this with multiple groups, select the groups to delete from the list and click **Delete** at the bottom of the screen.

  1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the command with the backend group ID or name specified:

  ```
  yc alb backend-group delete --id a5dg2cv4ngne8575fb1p
  ```

{% list tabs %}

