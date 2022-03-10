---
title: "How to remove a target group in a network balancer"
description: "Before deleting a target group, it must be disconnected from the network balancer. Once deleted, the target group cannot be restored. Open the Load Balancer section in the directory where you want to delete the target group. In the menu that appears, click the Delete button."
---

# Delete a target group

{% note alert %}

Before deleting a target group, detach it from the network load balancer.
You cannot restore a target group after it is deleted.

{% endnote %}

{% list tabs %}

- Management console
  
  To delete a [target group](../concepts/target-resources.md):
  
  1. Open the **Load Balancer** section in the folder you want to delete the target group from.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the target group to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.
  
- CLI
  
  If you don't have the {{ yandex-cloud }} command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's delete target group command:
  
     ```
     $ yc load-balancer target-group delete --help
     ```
  
  1. Get a list of target groups:
  
     ```
     $ yc load-balancer target-group list
     +----------------------+-------------------+-------+
     |          ID          |       NAME        |  ...  |
     +----------------------+-------------------+-------+
     ...
     | b7roi767je4c574iivrk | test-target-group |  ...  |
     ...
     +----------------------+-------------------+-------+
     ```
  
  1. Choose the `ID` or `NAME` of the target group to delete.
  
  1. Delete the target group from the default folder:
  
     ```
     $ yc load-balancer target-group delete b7roi767je4c574iivrk
     ```
  
- API
  
  You can delete target groups using the [delete](../api-ref/TargetGroup/delete.md) API method.
  
{% endlist %}

