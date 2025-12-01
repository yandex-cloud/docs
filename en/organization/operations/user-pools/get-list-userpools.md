---
title: Getting a list of user pools in {{ org-full-name }}
description: Follow this guide to get a list of user pools in an {{ org-name }}.
---

# Getting a list of user pools


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  
     This will display all [user pools](../../concepts/user-pools.md) available in your organization.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of [user pools](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool list --help
     ```

  1. Run this command:

      ```bash
      yc organization-manager idp userpool list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of user pools for.

- API {#api}

  Use the [Userpool.List](../../idp/api-ref/Userpool/list.md) REST API method for the [Userpool](../../idp/api-ref/Userpool/index.md) resource or the [UserpoolService/List](../../idp/api-ref/grpc/Userpool/list.md) gRPC API call.

{% endlist %}