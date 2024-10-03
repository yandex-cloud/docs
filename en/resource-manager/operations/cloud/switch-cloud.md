---
title: Tutorial on switching over to a different cloud in {{ resmgr-full-name }}
description: In this tutorial, you'll learn how to switch over to another cloud in {{ resmgr-full-name }}.
---

# Switch clouds


{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate cloud or folder in the list on the left.

      ![image](../../../_assets/resource-manager/switch-cloud-n-n.png)


- CLI {#cli}

   There are two ways to choose the cloud that is used in the CLI by default:
   * Select a cloud when [creating a profile](../../../cli/operations/profile/profile-create.md);
   * Change the `cloud-id` parameter in the profile configuration.

   To change the `cloud-id` parameter for the current profile:

   1. See the description of the command to change configuration parameters:

      ```
      yc config set --help
      ```

   1. Find out the ID of the cloud you want to use. To do this, get a list of available clouds:

      ```
      yc resource-manager cloud list
      +----------------------+----------------------+-------------------------------+
      |          ID          |         NAME         |          DESCRIPTION          |
      +----------------------+----------------------+-------------------------------+
      | b1gg8sgd16g7******** | cloud-b1gg8s******** | ...                           |
      | b1gjqgj3hhvj******** | cloud-b1gjqg******** | ...                           |
      +----------------------+----------------------+-------------------------------+
      ```

      {% note info %}

      If the list contains only one cloud, it means you don't have access to any other clouds. To access the cloud, ask the [owner](../../concepts/resources-hierarchy.md#owner) to [add](../../../iam/operations/users/create.md) you to it.

      {% endnote %}

   1. Specify the ID of the cloud to be used by default:

      ```
      yc config set cloud-id b1gjqgj3hhvj********
      ```

- API {#api}

   Currently, you cannot switch to another cloud using the API.

{% endlist %}
