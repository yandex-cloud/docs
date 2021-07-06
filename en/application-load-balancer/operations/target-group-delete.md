---
title: "How to remove a target group in the application load balancer"
description: "To delete a target group, in the management console, select the directory that the target group belongs to. Select the Application Load Balancer service. In the left menu, select Target groups. Select the target group and click the select icon. In the menu that opens, select Delete. To do this action with several groups, select the ones you need in the list and click the Delete button at the bottom of the screen. "
---

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

  1. See the description of the CLI's delete target group command:

     ```
     yc alb target-group delete --help
     ```

  1. Run the command:

     ```
     yc alb target-group delete <target group name or ID>
     ```

     To check the deletion, get a list of target groups by running the command:

     ```
     yc alb target-group list
     ```

{% endlist %}

