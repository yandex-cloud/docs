# Edit an L7 load balancer

To edit an L7 load balancer:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the load balancer belongs to.
  1. Select **{{ alb-name }}**.
  1. Click on the name of the load balancer you need.
  1. Click **Edit**.
  1. Edit the load balancer parameters, for example, rename the load balancer.
  1. At the bottom of the page, click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to update a load balancer:

     ```
     yc alb load-balancer update --help
     ```

  1. Run the command, indicating the new load balancer parameters:

     ```
     yc alb load-balancer update <load balancer name> --new-name <new load balancer name>
     ```

{% endlist %}

