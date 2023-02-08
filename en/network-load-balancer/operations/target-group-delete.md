---
title: "Deleting a target group in the load balancer"
description: "Before deleting a target group, detach it from the network load balancer. You cannot restore a target group after it is deleted. Open the Load Balancer section in the folder you want to delete the target group from. In the menu that opens, click Delete."
---

#  Delete a {{ network-load-balancer-name }} target group

{% note alert %}

Before deleting a target group, detach it from the network load balancer. You cannot restore a target group after it is deleted.

{% endnote %}

{% list tabs %}

- Management console

   To delete a [target group](../concepts/target-resources.md):
   1. In the [management console]({{ link-console-main }}), select the folder to delete a target group from.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/trgroups.svg) **Target groups**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the target group to delete.
   1. In the menu that opens, select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete target group command:

      ```bash
      yc load-balancer target-group delete --help
      ```

   1. Get a list of target groups:

      ```bash
      yc load-balancer target-group list
      ```

      Result:

      ```bash
      +----------------------+-------------------+-----+
      |          ID          |       NAME        | ... |
      +----------------------+-------------------+-----+
      ...
      | b7roi767je4c574iivrk | test-target-group | ... |
      ...
      +----------------------+-------------------+-----+
      ```

   1. Select the `ID` or `NAME` of the target group.
   1. Delete the target group from the default folder:

      ```bash
      yc load-balancer target-group delete b7roi767je4c574iivrk
      ```

- API

   You can delete target groups using the [delete](../api-ref/TargetGroup/delete.md) API method.

{% endlist %}