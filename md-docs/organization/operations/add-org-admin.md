[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление доступом > Назначить пользователя администратором организации

# Назначить пользователя администратором организации

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.

  1. Справа сверху нажмите кнопку **Назначить роли**.

  1. Выберите пользователя, которого хотите назначить администратором. При необходимости воспользуйтесь строкой поиска.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/roles-reference.md#organization-manager-admin) `organization-manager.admin`.

  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../terraform/index.md).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
     
  После этого указанному пользователю будет назначена роль администратора организации. Проверить появление роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

  * Идентификатор [роли](../../iam/roles-reference.md#organization-manager-admin) `organization-manager.admin` в параметре `roleId` для REST API или `role_id` для gRPC API.
  * Идентификатор и тип пользователя в блоке `subject`.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Настройка прав доступа к сервисному аккаунту](../../iam/operations/sa/set-access-bindings.md)
* [Настройка прав доступа к облаку](../../resource-manager/operations/cloud/set-access-bindings.md)
* [Настройка прав доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md)