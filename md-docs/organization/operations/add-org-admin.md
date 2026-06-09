# Назначить пользователя администратором организации

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.

  1. Выберите пользователя, которого хотите назначить администратором. При необходимости воспользуйтесь строкой поиска.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../../iam/roles-reference.md#organization-manager-admin) `organization-manager.admin`.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. [Получите идентификатор пользователя](users-get.md).

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) с помощью команды:

      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject userAccount:<идентификатор_пользователя>
      ```

      Где: 
      
      * `--role` — идентификатор роли. Укажите роль `organization-manager.admin`.
      * `--subject` — идентификатор пользователя.

      Например, назначьте роль администратора для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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

      * `organization_id` — [идентификатор](organization-get-id.md) организации.
      * `role` — укажите роль `organization-manager.admin`. Для одной роли можно использовать только один `yandex_organization manager_organization_iam_binding`.
      * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
     
  После этого указанному пользователю будет назначена роль администратора организации. Проверить появление роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

  * Идентификатор [роли](../../iam/roles-reference.md#organization-manager-admin) `organization-manager.admin` в параметре `roleId` для REST API или `role_id` для gRPC API.
  * Идентификатор и тип пользователя в блоке `subject`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)