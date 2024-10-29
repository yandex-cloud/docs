---
title: Как просмотреть роли на ресурс в {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете просмотреть роли на ресурс.
---

# Просмотреть роли на ресурс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно просмотреть [роли](../../../iam/concepts/access-control/roles.md), назначенные на ресурс.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Найдите в списке нужного пользователя, группу или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Назначенные роли указаны в столбце **{{ ui-key.yacloud.common.resource-acl.label_bindings }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc container <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
  ```

  Где:
  * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
  * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, роли, назначенные на который, вы хотите посмотреть.

  **Пример**
  
  ```bash
  yc container registry list-access-bindings my-first-registry
  ```

  Результат:
  
  ```bash
  +--------------------------+---------------+----------------------+
  |         ROLE ID          | SUBJECT TYPE  |      SUBJECT ID      |
  +--------------------------+---------------+----------------------+
  | container-registry.admin | federatedUser | ajekv7lpqpgu******** |
  +--------------------------+---------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Registry/listAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/listAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Воспользуйтесь методом REST API [listAccessBindings](../../api-ref/Repository/listAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/listAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

{% endlist %}

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) {{ iam-full-name }}.
