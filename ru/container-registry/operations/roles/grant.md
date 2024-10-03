---
title: Как назначить роли на ресурс в {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете назначить роли на ресурс.
---

# Назначить роль на ресурс

Чтобы предоставить доступ к [ресурсу](../../../iam/concepts/access-control/resources-with-access-control.md), назначьте субъекту [роль](../../../iam/concepts/access-control/roles.md) на сам ресурс или на ресурс, от которого наследуются права доступа, например на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud). Актуальный список ресурсов, на которые можно назначать роли, доступен в разделе [{#T}](../../security/index.md#resources).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно назначить роль на ресурс.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы назначить роль на ресурс:

  * пользователю:

    ```bash
    yc container <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
      --role <роль> \
      --user-account-id <идентификатор_пользователя>
    ```

  * [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md):

    ```bash
    yc container <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
      --role <роль> \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

  * всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

    ```bash
    yc container <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
      --role <роль> \
      --all-authenticated-users
    ```

    Где:
    * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
    * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль;
    * `<роль>` — [роль](../../security/index.md#service-roles), которую необходимо назначить.
  
  **Пример**

  В примере ниже пользователю назначается роль `container-registry.admin` на реестр `my-first-registry`.

  ```bash
  yc container registry add-access-binding my-first-registry \
    --role container-registry.admin \
    --user-account-id ajeugsk5ubk6********
  ```

  Результат:

  ```text
  done (4s)
  ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле:
     * Параметры ресурса `yandex_container_registry_iam_binding`, чтобы назначить роль на [реестр](../../concepts/registry.md):

       ```
       resource "yandex_container_registry_iam_binding" "имя_реестра" {
         registry_id = "<идентификатор_реестра>"
         role        = "<роль>"
       
         members = [
           "userAccount:<идентификатор_пользователя>",
         ]
       }
       ```

       Где:
       * `registry_id` — идентификатор реестра, на который назначается роль. Чтобы узнать идентификатор реестра, [получите список реестров в каталоге](../registry/registry-list.md#registry-list).
       * `role` — [роль](../../security/index.md#service-roles), которую необходимо назначить.
       * `members` — идентификатор пользователя, группы или сервисного аккаунта, которому назначается роль.
     
     * Параметры ресурса `yandex_container_repository_iam_binding`, чтобы назначить роль на [репозиторий](../../concepts/repository.md):

       ```
       resource "yandex_container_repository_iam_binding" "имя_репозитория" {
         repository_id = "<идентификатор_репозитория>"
         role          = "<роль>"
       
         members = [
           "serviceAccount:<идентификатор_сервисного_аккаунта>",
         ]
       }
       ```

       Где:
       * `repository_id` — идентификатор репозитория, на который назначается роль. Чтобы узнать идентификатор репозитория, [получите список репозиториев в каталоге](../repository/repository-list.md#repository-list).
       * `role` — роль, которую необходимо назначить.
       * `members` — идентификатор пользователя, группы или сервисного аккаунта, которому назначается роль.

     Более подробную информацию о ресурсе `yandex_container_repository_iam_binding`, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_repository_iam_binding).
  
  1. {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить назначение роли можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     * Для реестра:

       ```bash
       yc container registry list-access-bindings <имя_или_идентификатор_реестра>
       ```

     * Для репозитория:

       ```bash
       yc container repository list-access-bindings <имя_или_идентификатор_репозитория>
       ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/registry_service.md#UpdateAccessBindings).

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/repository_service.md#UpdateAccessBindings).

{% endlist %}
