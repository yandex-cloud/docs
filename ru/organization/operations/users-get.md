---
title: Как получить информацию о пользователе в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о пользователе организации в {{ org-full-name }}.
---

# Получить информацию о пользователе

{% note info %}

Получить идентификатор или почту пользователей может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#add-role).

{% endnote %}

## Пользователи с аккаунтом на Яндексе и федеративные пользователи {#yandex-and-federated} 

Чтобы получить информацию о пользователе [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративном](../../iam/concepts/users/accounts.md#saml-federation) пользователе:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды получения информации о пользователях организации:

      ```bash
      yc organization-manager user list --help
      ```

  1. Чтобы получить информацию о пользователях организации, выполните команду, указав [идентификатор](./organization-get-id.md) этой организации:

      ```bash
      yc organization-manager user list \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      +----------------------+----------+--------------------+----------------------+-----------------------+
      |          ID          | USERNAME |       EMAIL        |    FEDERATION ID     | LAST AUTHENTICATED AT |
      +----------------------+----------+--------------------+----------------------+-----------------------+
      | ajeebjmlsdk9******** | hatter   | hatter@{{yandex-domain}}   |                      | 2025-09-06T19:10:00Z  |
      | bsdeoujmzsdk******** | alice    | alice@mydomain.com | bpfsuecgv39i******** | 2025-06-04T09:23:00Z  |
      +----------------------+----------+--------------------+----------------------+-----------------------+
      ```

- API {#api}

  Чтобы получить информацию о пользователях организации, воспользуйтесь методом REST API [listMembers](../api-ref/User/listMembers.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/ListMembers](../api-ref/grpc/User/listMembers.md).

{% endlist %}

## Локальные пользователи {#local} 


{% include [note-preview](../../_includes/note-preview.md) %}

Чтобы получить информацию о [локальном](../../iam/concepts/users/accounts.md#local) пользователе:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [users-info](../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о пользователе [пула](../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user get --help
     ```
  1. {% include [cli-list-userpools](../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы получить информацию о нужном пользователе, выполните команду, указав его идентификатор:

      ```bash
      yc organization-manager idp user get <идентификатор_пользователя>
      ```

      Результат:

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

  Чтобы получить информацию о пользователях организации, воспользуйтесь методом REST API [get](../idp/api-ref/User/get.md) для ресурса [User](../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Get](../idp/api-ref/grpc/User/get.md).

{% endlist %}