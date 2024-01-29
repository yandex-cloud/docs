---
title: "How to get an ID or email of a user in {{ org-full-name }}"
description: "Follow this guide to get an ID or email of a user."
---

# Getting the user ID or email

You can get the following information about an organization's registered users:
* ID
* Login
* Email
* Federation ID

{% note info %}

An ID or email can be received by users with the `organization-manager.admin` or `organization-manager.organizations.owner` role. To learn how to grant roles to a user, see [Roles](../security/index.md#admin).

{% endnote %}

{% list tabs group=instructions %}

- {{ org-name }} {#cloud-org}

   {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

   1. See the description of the command to get information about an organization's users:

      ```
      yc organization-manager user list --help
      ```

   1. Get user information by specifying the organization ID:

      ```
      yc organization-manager user list --organization-id bof33m********
      +----------------------+----------+------------------+-----------------------+
      |          ID          | USERNAME |      EMAIL       |     FEDERATION ID     |
      +----------------------+----------+------------------+-----------------------+
      | ajeebjmlsdk9******** | hatter   | hatter@{{yandex-domain}} | gyuiawudhiks********  |
      | bsdeoujmzsdk******** | alice    | alice@{{yandex-domain}}  |                       |
      +----------------------+----------+------------------+-----------------------+
      ```

- API {#api}

   Get user parameters with an [API call](../api-ref/User/listMembers.md).

{% endlist %}