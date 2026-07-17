---
title: Как назначить пользователя администратором организации в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете назначить пользователя администратором организации в {{ org-full-name }}.
---

# Назначить пользователя администратором организации

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Выберите пользователя, которого хотите назначить администратором. При необходимости воспользуйтесь строкой поиска.
  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../iam/roles-reference.md#organization-manager-admin) `organization-manager.admin`.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите идентификатор пользователя](users-get.md).
  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) с помощью команды:

      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --user-account-id <идентификатор_пользователя>
      ```

      Где:

      * `--role` — идентификатор роли. Укажите роль `organization-manager.admin`.
      * `--user-account-id` — идентификатор пользователя. Также вы можете использовать параметр `--user-yandex-login` и указать логин пользователя вместо идентификатора.

      Например, назначьте роль администратора для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --user-account-id aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых [ролей](../../iam/concepts/access-control/roles.md):

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "org_admin_role" {
        organization_id = "<идентификатор_организации>"
        role            = "organization-manager.admin"
        member          = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](./organization-get-id.md) организации.
      * `role` — укажите роль `organization-manager.admin`. Для одной роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_organizationmanager_organization_iam_binding` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого указанному пользователю будет назначена роль администратора организации. Проверить назначение роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

   Чтобы назначить пользователю роль администратора организации, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
