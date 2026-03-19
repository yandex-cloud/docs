---
title: Как просмотреть роли на реестр в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете просмотреть роли, назначенные на реестр.
---

# Просмотреть роли, назначенные на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Найдите в списке нужного пользователя, группу или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Назначенные роли будут указаны в столбце **{{ ui-key.yacloud_components.acl.resource-acl.label_bindings }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc cloud-registry registry list-access-bindings <имя_или_идентификатор_реестра>
  ```

  **Пример**
  
  ```bash
  yc cloud-registry registry list-access-bindings my-first-registry
  ```

  Результат:
  
  ```bash
  +----------------------+---------------+----------------------+
  |       ROLE ID        | SUBJECT TYPE  |      SUBJECT ID      |
  +----------------------+---------------+----------------------+
  | cloud-registry.admin | federatedUser | ajekv7lpqpgu******** |
  +----------------------+---------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListAccessBindings](../../api-ref/grpc/Registry/listAccessBindings.md).

{% endlist %}

Подробнее о просмотре назначенных ролей читайте в [документации](../../../iam/operations/roles/get-assigned-roles.md) {{ iam-full-name }}.
