---
title: Как предоставить доступ к SAML-приложению в {{ org-full-name }}
description: Из этой статьи вы узнаете, как настроить доступ к SAML-приложению в {{ org-full-name }}.
---

# Настроить доступ к SAML-приложению в {{ org-full-name }}


Чтобы предоставить доступ к [SAML-приложению](../../concepts/applications/saml.md), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [app-set-access-bindings-ui](../../../_includes/organization/app-set-access-bindings-ui.md) %}

- CLI {#cli}

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для назначения ролей на SAML-приложение:

      ```bash
      yc organization-manager idp application saml application set-access-bindings --help
      ```

   1. Получите список SAML-приложений и их идентификаторы:

      ```bash
      yc organization-manager idp application saml application list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список SAML-приложений.

   1. Получите идентификатор [пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы, которым нужно предоставить доступ к SAML-приложению.
   1. С помощью команды `yc organization-manager idp application saml application set-access-bindings` назначьте роли:

      ```bash
      yc organization-manager idp application saml application set-access-bindings \
        --id <идентификатор_приложения> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор SAML-приложения, к которому нужно предоставить доступ.
      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager idp application saml application set-access-bindings \
        --id <идентификатор_приложения> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

  Воспользуйтесь методом REST API [Application.SetAccessBindings](../../idp/application/saml/api-ref/Application/setAccessBindings.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/SetAccessBindings](../../idp/application/saml/api-ref/grpc/Application/setAccessBindings.md).

  Передайте в запросе:

  * Роль в параметре `accessBindings[].roleId`.
  * Идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль на SAML-приложение, в параметре `accessBindings[].subject.id`.
  * Тип субъекта, которому назначается роль на SAML-приложение, в параметре `accessBindings[].subject.type`.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}