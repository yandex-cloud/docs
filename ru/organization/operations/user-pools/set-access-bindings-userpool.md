---
title: Как предоставить доступ к пулу пользователей в {{ org-full-name }}
description: Из этой статьи вы узнаете, как настроить доступ к пулу пользователей в {{ org-full-name }}.
---

# Настроить доступ к пулу пользователей


Чтобы предоставить доступ к [пулу](../../concepts/user-pools.md), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите пул пользователей.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.UserpoolPageLayout.title_userpool_acl_5rdMM }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к пулу пользователей.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль. При необходимости добавьте другие роли.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для назначения ролей на [пул пользователей](../../concepts/user-pools.md):

      ```bash
      yc organization-manager idp userpool set-access-bindings --help
      ```

   1. Получите список пулов пользователей и их идентификаторы:

      ```bash
      yc organization-manager idp userpool list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список пулов пользователей.

   1. Получите идентификатор [пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы, которым нужно предоставить доступ к пулу пользователей.
   1. С помощью команды `yc organization-manager idp userpool set-access-bindings` назначьте роли:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <идентификатор_пула> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор пула пользователей, к которому нужно предоставить доступ.
      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <идентификатор_пула> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

  Воспользуйтесь методом REST API [Userpool.SetAccessBindings](../../idp/api-ref/Userpool/setAccessBindings.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/SetAccessBindings](../../idp/api-ref/grpc/Userpool/setAccessBindings.md).

  Передайте в запросе:

  * Роль в параметре `accessBindings[].roleId`.
  * Идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль на пул пользователей, в параметре `accessBindings[].subject.id`.
  * Тип субъекта, которому назначается роль на пул пользователей, в параметре `accessBindings[].subject.type`.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}
