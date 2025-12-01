---
title: How to get information about an OIDC app in {{ org-full-name }}
description: Follow this guide to get information about an OIDC app in {{ org-name }}.
---

# Getting information about an OIDC app in {{ org-full-name }}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Click the row with the [OIDC app](../../concepts/applications.md#oidc) you want to get info about.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about the [OIDC app](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application get --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp application oauth application get <app_ID>
     ```

     Result:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-22T11:53:21.689383Z"
     ```

- API {#api}

  Use the [Application.Get](../../idp/application/oauth/api-ref/Application/get.md) REST API method for the [Application](../../idp/application/oauth/api-ref/Application/index.md) resource or the [ApplicationService/Get](../../idp/application/oauth/api-ref/grpc/Application/get.md) gRPC API call.

{% endlist %}