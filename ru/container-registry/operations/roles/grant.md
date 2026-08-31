---
title: Как назначить роли на ресурс в {{ container-registry-full-name }}
description: Следуя данной инструкции, вы сможете назначить роли на ресурс.
---

# Назначить роль на ресурс

Чтобы предоставить доступ к [ресурсу](../../../iam/concepts/access-control/resources-with-access-control.md), назначьте субъекту [роль](../../../iam/concepts/access-control/roles.md) на сам ресурс или на ресурс, от которого наследуются права доступа, например на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud). Актуальный список ресурсов, на которые можно назначать роли, доступен в разделе [{#T}](../../security/index.md#resources).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно назначить роль на ресурс.
  1. [Перейдите]({{ link-console-main }}/link/container-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите [реестр](../../concepts/registry.md) или [репозиторий](../../concepts/repository.md) в нем.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы назначить роль на ресурс:

  ```bash
  yc container <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
    --role <роль> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `<ресурс>` — тип ресурса `registry` (реестр) или `repository` (репозиторий);
  * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль;
  * `--role` — [роль](../../security/index.md#service-roles), которую необходимо назначить;
  * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}
  
  **Пример**

  В примере ниже пользователю назначается роль `container-registry.admin` на реестр `my-first-registry`.

  ```bash
  yc container registry add-access-binding my-first-registry \
    --role container-registry.admin \
    --subject userAccount:ajeugsk5ubk6********
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
           "<тип_субъекта>:<идентификатор_субъекта>",
         ]
       }
       ```

       Где:
       * `registry_id` — идентификатор реестра, на который назначается роль. Чтобы узнать идентификатор реестра, [получите список реестров в каталоге](../registry/registry-list.md#registry-list).
       * `role` — [роль](../../security/index.md#service-roles), которую необходимо назначить.
       * `members` — список обозначений [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль.

           {% cut "Обозначения субъектов" %}

           {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

           {% endcut %}
     
     * Параметры ресурса `yandex_container_repository_iam_binding`, чтобы назначить роль на [репозиторий](../../concepts/repository.md):

       ```
       resource "yandex_container_repository_iam_binding" "имя_репозитория" {
         repository_id = "<идентификатор_репозитория>"
         role          = "<роль>"
       
         members = [
           "<тип_субъекта>:<идентификатор_субъекта>",
         ]
       }
       ```

       Где:
       * `repository_id` — идентификатор репозитория, на который назначается роль. Чтобы узнать идентификатор репозитория, [получите список репозиториев в каталоге](../repository/repository-list.md#repository-list).
       * `role` — роль, которую необходимо назначить.
       * `members` — список обозначений субъектов, которым назначается роль.

           {% cut "Обозначения субъектов" %}

           {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

           {% endcut %}

     Подробнее о параметрах ресурса `yandex_container_repository_iam_binding` в [документации провайдера]({{ tf-provider-resources-link }}/container_repository_iam_binding).
  
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

  Чтобы назначить роль на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md).

  Чтобы назначить роль на репозиторий, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Repository/updateAccessBindings.md) для ресурса [Repository](../../api-ref/Repository/index.md) или вызовом gRPC API [RepositoryService/UpdateAccessBindings](../../api-ref/grpc/Repository/updateAccessBindings.md).

  В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
