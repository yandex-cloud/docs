---
title: How to get a list of users in a {{ org-full-name }} pool
description: Follow this guide to get a list of users in an {{ org-name }} pool.
---

# Getting a list of users in a pool


{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../concepts/user-pools.md).
  1. Go to the **Members** tab. You will se the list of all pool users.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of users in the [pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user list --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp user list --userpool-id <pool_ID>
      ```

      Where `--userpool-id` is the ID of the pool whose list of users you want to get.

- API {#api}

  Use the [User.List](../../idp/api-ref/User/list.md) REST API method for the [User](../../idp/api-ref/User/index.md) resource or the [UserService/List](../../idp/api-ref/grpc/User/list.md) gRPC API call.

{% endlist %}