# Edit a backend group

To change the backend group parameters:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder that the backend group belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **Backend groups** section.
  1. Click on the name of the group you need.
  1. Click **Edit**.
  1. Edit the group settings.
  1. At the bottom of the page, click **Save changes**.

- CLI

  1. View a description of the CLI command for changing the backend group parameters:

     ```
     yc alb backend-group update-http-backend --help
     ```

  1. Run the command:

     ```
     yc alb backend-group update-http-backend \
     --backend-group-name <backend group name> \
     --name <backend name> \
     --weight <backend weight>
     ```

     Command execution result:

     ```
     done (1s)
     id: a5d3e9ko2qf0tbk0s27b
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     http:
       backends:
       - name: backend1
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5dvd82vl14khpjdv87d
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     created_at: "2021-02-14T13:37:17.846064589Z"
     ```

{% endlist %}

## Remove a backend from a group {#delete-backend}

To remove a backend from a group:

{% list tabs %}

- Management console

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

  1. View a description of the CLI command for removing a backend from a group:

     ```
     yc application-load-balancer delete-http-backend --help
     ```

  1. Run the command:

     ```
     yc alb backend-group delete-http-backend --backend-group-name=<backend group name> \
     --name=<name of the backend to be deleted>
     ```

     Command execution result:

     ```
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

{% endlist %}

