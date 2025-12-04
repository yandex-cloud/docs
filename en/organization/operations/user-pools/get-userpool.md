---
title: How to get information about a user pool in {{ org-full-name }}
description: Follow this guide to get information about a user pool in {{ org-name }}.
---

# Getting information about a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the required pool from the [user pool](../../concepts/user-pools.md) list.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting information about a [user pool](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool get --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp userpool get <pool_ID>
     ```

- API {#api}

  Use the [Userpool.Get](../../idp/api-ref/Userpool/get.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/Get](../../idp/api-ref/grpc/Userpool/get.md) gRPC API call.

{% endlist %}