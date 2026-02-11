---
title: How to get information about a user in {{ org-full-name }}
description: Follow this guide to get information about an organization user in {{ org-full-name }}.
---

# Getting user info

{% note info %}

Only users with the `organization-manager.admin` or `organization-manager.organizations.owner` role can get a user ID or email. To learn how to grant a role to a user, see the [Roles](../security/index.md#add-role) section.

{% endnote %}

## Yandex account users and federated users {#yandex-and-federated} 

To get information about a [Yandex account](../../iam/concepts/users/accounts.md#passport) user or a [federated](../../iam/concepts/users/accounts.md#saml-federation) user:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the command to get information about an organization's users:

      ```bash
      yc organization-manager user list --help
      ```

  1. To get information about organization users, run the command below and specify the organization [ID](./organization-get-id.md):

      ```bash
      yc organization-manager user list \
        --organization-id <organization_ID>
      ```

      Result:

      ```text
      +----------------------+----------+--------------------+----------------------+-----------------------+
      |          ID          | USERNAME |       EMAIL        |    FEDERATION ID     | LAST AUTHENTICATED AT |
      +----------------------+----------+--------------------+----------------------+-----------------------+
      | ajeebjmlsdk9******** | hatter   | hatter@{{ yandex-domain }}   |                      | 2025-09-06T19:10:00Z  |
      | bsdeoujmzsdk******** | alice    | alice@mydomain.com | bpfsuecgv39i******** | 2025-06-04T09:23:00Z  |
      +----------------------+----------+--------------------+----------------------+-----------------------+
      ```

- API {#api}

  To get information about organization users, use the [listMembers](../api-ref/User/listMembers.md) REST API method for the [User](../api-ref/User/index.md) resource or the [UserService/ListMembers](../api-ref/grpc/User/listMembers.md) gRPC API call.

{% endlist %}

{% include notitle [fed-user-data-after-login-notice](../../_includes/organization/fed-user-data-after-login-notice.md) %}

## Local users {#local} 


To get information about a [local](../../iam/concepts/users/accounts.md#local) user:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting [pool](../concepts/user-pools.md) user info:

     ```bash
     yc organization-manager idp user get --help
     ```
  1. {% include [cli-list-userpools](../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../_includes/organization/cli-userpool-list-users.md) %}
  1. To get information about a specific user, run the command below and specify the user ID:

      ```bash
      yc organization-manager idp user get <user_ID>
      ```

      Result:

      ```text
      id: aje0j5mts02t********
      userpool_id: ek0o6g0irskn********
      status: SUSPENDED
      username: test-user2@test.ru.idp.yandexcloud.net
      full_name: User 2
      given_name: Mad
      family_name: Hatter
      email: testuser@test.com
      phone_number: "+74991234567"
      created_at: "2025-07-16T11:18:57.679246Z"
      updated_at: "2025-10-13T08:14:23.764152Z"
      ```

- API {#api}

  To get information about organization users, use the [get](../idp/api-ref/User/get.md) REST API method for the [User](../idp/api-ref/User/index.md) resource or the [UserService/Get](../idp/api-ref/grpc/User/get.md) gRPC API call.

{% endlist %}