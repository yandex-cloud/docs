# Edit a backend group

{% list tabs %}

- Management console

  To edit a backend group:

  1. In the [management console]({{ link-console-main }}), select the folder that the backend group belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **Backend groups** section.
  1. Click on the name of the group you need.
  1. Click **Edit**.
  1. Edit the group settings.
  1. At the bottom of the page, click **Save changes**.

- CLI

  To edit a backend group:

  1. View a description of the CLI command to edit an HTTP router:

     ```
     yc alb backend-group update-http-backend --help
     ```

  1. Run the command, indicating the new backend group parameters:

     ```
     yc alb backend-group update-http-backend <backend group name> \
     --new-name=<new name of the backend group>
     ```

{% endlist %}

## Remove a backend from a group {#delete-backend}

{% list tabs %}

- Management console

   To remove a backend from a group:
   
   1. In the [management console]({{ link-console-main }}), select the folder that the backend belongs to.
   1. Select **{{ alb-name }}**.
   1. Open the **Backend groups** section.
   1. Click on the name of the group you need.
   1. Select the backend and click ![image](../../_assets/dots.svg).
   1. In the menu that opens, select **Delete**.
   1. Confirm the deletion.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run the command indicating the name or ID of the backend group where you want to remove a backend from and the name of the removed backend:

  ```
  yc application-load-balancer backend-group \
  delete-http-backend --backend-group-name=test-backend-group \
  --name=backend1
  ```

{% endlist %}

