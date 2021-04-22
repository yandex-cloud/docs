# Delete an HTTP router

To delete an HTTP router:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the HTTP router belongs to.

  1. Select **{{ alb-name }}**.

  1. Select the VM and click ![image](../../_assets/dots.svg).

  1. In the menu that opens, select **Delete**.

      To do this with multiple HTTP routers, select the routers to delete from the list and click **Delete** at the bottom of the screen.

  1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the command, indicating the ID or name of the HTTP router:

  ```
  yc alb http-router delete --id <HTTP router ID>
  ```

{% list tabs %}

