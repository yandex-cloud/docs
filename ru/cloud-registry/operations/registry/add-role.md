---
title: Как назначить роли на реестр в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете назначить роли на реестр.
---

# Назначить роль на реестр

{% note info %}

Рекомендуем назначать роли публичной группе `All users` только на Docker-реестры — для остальных форматов корректная работа не гарантируется.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы назначить роль на реестр:

  * пользователю:

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --user-account-id <идентификатор_пользователя>
    ```

  * [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

  * всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers) `All authenticated users`):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --allAuthenticatedUsers
    ```

  * всем пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md#allUsers) `All users`):

    ```bash
    yc cloud-registry registry add-access-binding <имя_или_идентификатор_реестра> \
      --role <роль> \
      --allUsers
    ```

    Где `<роль>` — [роль](../../security/index.md#service-roles), которую необходимо назначить.

  Чтобы отозвать все роли на реестр и сразу назначить новые, используйте команду `yc cloud-registry registry set-access-bindings`.
  
  **Пример**

  В примере ниже пользователю назначается роль `cloud-registry.admin` на реестр `my-first-registry`.

  ```bash
  yc cloud-registry registry add-access-binding my-first-registry \
    --role cloud-registry.admin \
    --user-account-id ajeugsk5ubk6********
  ```

  Результат:

  ```text
  done (4s)
  ```
- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

{% endlist %}

Подробнее о назначении ролей читайте в [документации](../../../iam/operations/roles/grant.md) {{ iam-full-name }}.
