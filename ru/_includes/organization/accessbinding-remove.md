
{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием [группы](../../organization/concepts/groups.md).
  
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

  1. Чтобы отозвать определенные роли:

      1. В строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.

      1. Нажмите ![image](../../_assets/console-icons/xmark.svg) напротив ролей, которые вы хотите отозвать.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  1. Чтобы отозвать все роли, в строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_components.acl.action.revoke-access }}** и подтвердите действие.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для отзыва роли:

       ```bash
       yc organization-manager group remove-access-binding --help
       ```

   1. Получите список групп пользователей вместе с идентификаторами этих групп:

       ```bash
       yc organization-manager group list \
         --organization-id <идентификатор_организации>
       ```

   1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, у которых отзываете роль.
   1. С помощью команды `yc organization-manager group remove-access-binding` отзовите роль у объекта:

         ```bash
         yc organization-manager group remove-access-binding \
           --id <идентификатор_группы> \
           --role <роль> \
           --user-account-id <идентификатор_пользователя> \
           --federation-users <идентификатор_пользователя> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --subject group:<идентификатор_группы>
         ```

         Где:

         * `--id` — идентификатор группы пользователей.
         * `--role` — идентификатор роли.
         
         Идентификатор объекта, у которого отзывается роль:
         
         * `--user-account-id` — идентификатор аккаунта на Яндексе.
         * `--federation-users` — идентификатор федеративного пользователя.
         * `--service-account-id` — идентификатор сервисного аккаунта.
         * `--subject group` — идентификатор группы.

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  Чтобы отозвать роль у пользователя, сервисного аккаунта или группы пользователей:

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с ресурсом `yandex_organizationmanager_group_iam_binding`, соответствующим роли, которую хотите отозвать.

      ```hcl
      resource "yandex_organizationmanager_group_iam_binding" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        members  = [
          "<тип_субъекта>:<идентификатор_субъекта>",
        ]
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
   
  После этого роль будет отозвана у указанного субъекта. Проверить отсутствие роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

   Воспользуйтесь методом [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `REMOVE` в параметре `accessBindingDeltas[].action`, чтобы отозвать роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, у кого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}
