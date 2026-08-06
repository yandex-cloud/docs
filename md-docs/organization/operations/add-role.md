[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление доступом > Назначить роль пользователю

# Назначить роль пользователю

Назначать роли в Yandex Identity Hub могут [администраторы и владельцы организации](add-org-admin.md). Вы можете назначать пользователям не только роли для управления организацией, но и роли для доступа к ресурсам облаков, подключенных к вашей организации.

О том, какие роли доступны в Yandex Cloud и какие разрешения в них входят, читайте в документации Yandex Identity and Access Management в разделе [Справочник ролей Yandex Cloud](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.
  
  1. Если у нужного пользователя уже есть хотя бы одна роль, в строке с этим пользователем нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **Назначить роли**.
  
      Если нужного пользователя нет в списке, в правом верхнем углу страницы нажмите кнопку **Назначить роли**. В открывшемся окне выберите пользователя из списка или воспользуйтесь строкой поиска.
  
  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить пользователю. Вы можете назначить несколько ролей.
  
      Описание доступных ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md).
  
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Назначьте роль с помощью команды:

      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --user-account-id <идентификатор_пользователя>
      ```

      Где:

      * `--role` — идентификатор роли.
      * `--user-account-id` — идентификатор пользователя. Также вы можете использовать параметр `--user-yandex-login` и указать логин пользователя вместо идентификатора.

      Например, назначьте пользователю роль администратора на организацию с идентификатором `b1gmit33ngp3********`:

      ```bash
      yc organization-manager organization add-access-binding b1gmit33ngp3******** \
        --role resource-manager.admin \
        --user-account-id aje6o61dvog2********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла для назначения роли на организацию:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<идентификатор_организации>"
        role            = "<идентификатор_роли>"
        member          = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](organization-get-id.md) организации.
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора — `<тип_субъекта>:<идентификатор>`. Возможные обозначения субъектов:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` ||
          || `group`          | `group:<идентификатор_группы>` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `system:allUsers`
          
          (группа `All users`) ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_organizationmanager_organization_iam_binding` читайте в [документации провайдера](../../terraform/resources/organizationmanager_organization_iam_binding.md).

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

  После этого указанному пользователю будут назначены роли в организации. Проверить назначение роли можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

- API {#api}

  Чтобы назначить роль пользователю на организацию, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md).

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` или `federatedUser` и идентификатор пользователя:

      **body.json:**

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<идентификатор_роли>",
            "subject": {
              "id": "<идентификатор_пользователя>",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

      Где:

      * Значение `ADD` в параметре `accessBindingDeltas[].action` указывает, что роль нужно добавить.
      * `accessBindingDeltas[].accessBinding.roleId` — идентификатор роли, которую нужно назначить.
      * `accessBindingDeltas[].accessBinding.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindingDeltas[].accessBinding.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:
          
          #|
          || **subject.type** | **subject.id** ||
          || `userAccount`    | `<идентификатор_пользователя>` ||
          || `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
          || `federatedUser`  | `<идентификатор_пользователя>` ||
          || `group`          | `<идентификатор_группы>` ||
          || `system`         | `allAuthenticatedUsers`
          
          (группа `All authenticated users`) ||
          || ^                | `allUsers`
          
          (группа `All users`) ||
          || ^                | `group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) ||
          || ^                | `group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) ||
          || ^                | `group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) ||
          |#

          {% endcut %}

  1. Назначьте роль. Например, для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-токен>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

Аналогичным образом можно [назначить роль](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) на организацию сервисному аккаунту.

#### Полезные ссылки {#see-also}

* [Настройка прав доступа к сервисному аккаунту](../../iam/operations/sa/set-access-bindings.md)
* [Настройка прав доступа к облаку](../../resource-manager/operations/cloud/set-access-bindings.md)
* [Настройка прав доступа к каталогу](../../resource-manager/operations/folder/set-access-bindings.md)