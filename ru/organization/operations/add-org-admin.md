---
title: Как назначить пользователя администратором организации в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете назначить пользователя администратором организации.
---

# Назначить пользователя администратором организации

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Выберите пользователя, которого хотите назначить администратором. При необходимости воспользуйтесь строкой поиска.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.role.add }}** и выберите одну из [ролей](../../iam/concepts/access-control/roles.md):

      * `organization-manager.admin`.
      * `organization-manager.organizations.owner`.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Получите идентификатор пользователя](../operations/users-get.md).

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) с помощью команды:

      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject userAccount:<идентификатор_пользователя>
      ```

      Где: 
      
      * `--role` — идентификатор роли. Укажите одну из ролей: `organization-manager.admin` или `organization-manager.organizations.owner`.
      * `--subject` — идентификатор пользователя.

      Например, назначьте роль администратора для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых [ролей](../../iam/concepts/access-control/roles.md):

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "org_admin_role" {
        organization_id = "<идентификатор_организации>"
        role = "<идентификатор_роли>"
        members = [
          "userAccount:<идентификатор_пользователя>",
        ]
      }
      ```

      Где:

      * `organization_id` — [идентификатор](./organization-get-id.md) организации.
      * `role` — укажите одну из ролей: `organization-manager.admin` или `organization-manager.organizations.owner`. Для каждой роли можно использовать только один `yandex_organization manager_organization_iam_binding`.
      * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
     
  После этого указанному пользователю будет назначена роль администратора организации. Проверить появление роли можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

  * Идентификатор [роли](../../iam/concepts/access-control/roles.md) `organization-manager.admin` или `organization-manager.organizations.owner` в параметре `roleId` для REST API или `role_id` для gRPC API.
  * Идентификатор и тип пользователя в блоке `subject`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
