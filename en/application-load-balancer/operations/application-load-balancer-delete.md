---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Delete an L7 load balancer

To delete an L7 load balancer:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the load balancer belongs to.

  1. Select **{{ alb-name }}**.

  1. In the menu on the left, select **Load balancers**.

  1. Select the load balancer and click ![image](../../_assets/dots.svg).

  1. In the menu that opens, select **Delete**.

      To do this with multiple load balancers, select the load balancers to delete from the list and click **Delete** at the bottom of the screen.

  1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for removing a load balancer:

     ```
     yc alb load-balancer delete --help
     ```

  1. Run the command:

     ```
     yc alb load-balancer delete <ID or name of the load balancer>
     ```

     Command execution result:

     ```
     done (1m10s)
     ```

{% list tabs %}

