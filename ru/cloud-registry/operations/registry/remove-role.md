---
title: Как отозвать роли на реестр в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете отозвать роли на реестр.
---

# Отозвать роль на реестр

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. [Перейдите]({{ link-console-main }}/link/cloud-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Выберите реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Выберите пользователя в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Просмотрите назначенные роли:

     ```bash
     yc cloud-registry registry list-access-bindings <имя_или_идентификатор_реестра>
     ```

  1. Отзовите роль:

     ```bash
     yc cloud-registry registry remove-access-binding <имя_или_идентификатор_реестра> \
       --role <роль> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — [роль](../../security/index.md#service-roles), которую необходимо отозвать.
     * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

         {% cut "Обозначения субъектов" %}

         {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

         {% endcut %}

    Чтобы отозвать все роли на реестр и сразу назначить новые, используйте команду `yc cloud-registry registry set-access-bindings`.
     
     **Пример**

     В примере ниже у пользователя отзывается роль `cloud-registry.admin` на реестр `my-first-registry`.
     
     ```bash
     yc cloud-registry registry remove-access-binding my-first-registry \
       --role cloud-registry.admin \
       --user-account-id ajeugsk5ubk6********
     ```

     Результат:

     ```text
     done (9s)
     ```

- API {#api}

  [Просмотрите](list-role.md#api) роли, назначенные на реестр.
  
  Чтобы отозвать роли, назначенные на реестр, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Registry/updateAccessBindings.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateAccessBindings](../../api-ref/grpc/Registry/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}

Подробнее об отзыве ролей читайте в [документации](../../../iam/operations/roles/revoke.md) {{ iam-full-name }}.
