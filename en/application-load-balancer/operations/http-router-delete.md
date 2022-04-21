# Delete an HTTP router

To delete an HTTP router:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the HTTP router belongs to.
   1. Select **{{ alb-name }}**.
   1. Select the router and click ![image](../../_assets/horizontal-ellipsis.svg).
   1. In the menu that opens, select **Delete**.

      To do this with multiple HTTP routers, select the routers to delete from the list and click **Delete** at the bottom of the screen.

   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for deleting an HTTP router:
      ```
      yc alb http-router delete --help
      ```

   1. Run the command, specifying the name of the HTTP router:
      ```
      yc alb http-router delete --name <HTTP router name>
      ```

      To check the deletion, get a list of HTTP routers by running the command:
      ```
      yc alb http-router list
      ```

{% endlist %}
