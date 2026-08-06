[Документация Yandex Cloud](../../../index.md) > [Yandex Resource Manager](../../index.md) > [Пошаговые инструкции](../index.md) > Каталог > Настройка прав доступа

# Настройка прав доступа к каталогу

{% note warning %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) Yandex Cloud разрешена [ролью](../../../iam/concepts/access-control/roles.md), ее выполнение может быть заблокировано, если для [организации](../../../organization/concepts/organization.md), [облака](../../concepts/resources-hierarchy.md#cloud) или [каталога](../../concepts/resources-hierarchy.md#folder) создана [политика авторизации](../../../iam/concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

Чтобы предоставить пользователю доступ к ресурсам в [каталоге](../../concepts/resources-hierarchy.md#folder), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на этот каталог.

{% note info %}

Для доступа пользователя к [консоли управления](https://console.yandex.cloud), назначьте ему роль на [облако](../../../organization/security/index.md#access-binding-cloud). Для безопасности вы можете назначить одну из ролей с минимальными привилегиями, например `resource-manager.clouds.member`, но также можно назначить и другие роли, если вы знаете, какие права вы хотите предоставить приглашенным пользователям.

Чтобы дать эти права сразу всем пользователям в организации, назначьте роль [системной группе](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`. При работе с CLI, API или Terraform назначение дополнительных ролей не требуется.

{% endnote %}

## Назначить роль на каталог {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../concepts/resources-hierarchy.md#folder).
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для назначения роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Получите список доступных каталогов:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha******** | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

  1. Получите список доступных ролей:

      ```bash
      yc iam role list
      ```

      Результат:


      ```
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

  1. Узнайте идентификатор пользователя по логину или адресу электронной почты.

      ```bash
      yc iam user-account get test-user
      ```

      Результат:

      ```text
      id: gfei8n54hmfh********
      yandex_passport_user_account:
        login: test-user
        default_email: test-user@yandex.ru
      ```

  1. Назначьте пользователю роль на каталог. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfh********
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить.
      * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
          || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) | `--all-authenticated-users` ||
          || ^                | `system:allUsers`
          
          (группа `All users`) | — ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) | `--organization-users` ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) | `--federation-users` ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) | — ||
          |#

          {% endcut %}

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#cloud-or-folder).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
      * `role` — роль, которую нужно назначить. В одном ресурсе `yandex_resourcemanager_folder_iam_member` можно назначить только одну роль.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      Подробнее о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в Terraform читайте в [документации провайдера](../../../terraform/resources/resourcemanager_folder_iam_member.md).

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

      После этого будут назначены права доступа к каталогу.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../api-ref/grpc/Folder/updateAccessBindings.md). Вам понадобится идентификатор каталога и идентификатор пользователя, которому назначается роль на каталог.

  1. Узнайте идентификатор каталога с помощью метода REST API [list](../../api-ref/Folder/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=<идентификатор_облака>
      ```

      Результат:

      ```json
      {
       "folders": [
        {
         "id": "b1g66mft1vop********",
         "cloudId": "b1gd129pp9ha********",
         "createdAt": "2018-10-17T12:44:31Z",
         "name": "my-folder",
         "status": "ACTIVE"
        }
       ]
      }
      ```

  1. Узнайте идентификатор пользователя по логину с помощью метода REST API [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Результат:

      ```json
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Назначьте пользователю роль на каталог. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` и идентификатор пользователя:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{
          "accessBindingDeltas": [
            {
              "action": "ADD",
              "accessBinding": {
                "roleId": "<роль>",
                "subject": {
                  "id": "<идентификатор_пользователя>",
                  "type": "userAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings
      ```

      Где:

      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../concepts/resources-hierarchy.md#folder).
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
  1. Выполните предыдущее действие необходимое количество раз, чтобы добавить все нужные роли.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
      ```

  1. Чтобы назначить роль, выполните команду:

      ```bash
      yc resource-manager folder set-access-bindings <имя_или_идентификатор_каталога> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

      Для каждой роли передайте отдельный параметр `--access-binding`. Например:

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры прав доступа к каталогу.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member1" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<роль_1>"
        member    = "userAccount:<идентификатор_пользователя>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member2" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<роль_2>"
        member    = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
      * `role` — роль, которую нужно назначить. В одном ресурсе `yandex_resourcemanager_folder_iam_member` можно назначить только одну роль.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

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

      После этого будут назначены права доступа к каталогу.

- API {#api}

  Назначьте роли пользователям:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
      "accessBindingDeltas": [
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<роль_1>",
            "subject": {
              "id": "<идентификатор_пользователя>",
              "type": "userAccount"
            }
          }
        },
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<роль_2>",
            "subject": {
              "id": "<идентификатор_пользователя>",
              "type": "userAccount"
            }
          }
        }
      ]
    }' \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings
  ```

  Где:

  * `roleId` — назначаемая роль.
  * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

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

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызова gRPC API [FolderService/SetAccessBindings](../../api-ref/grpc/Folder/setAccessBindings.md).

  {% note alert %}
  
  Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

{% endlist %}


## Доступ к каталогу для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно [назначать](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) роли на любые облака и каталоги в рамках организации, к которой он принадлежит.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../concepts/resources-hierarchy.md#folder).
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт из списка или воспользуйтесь поиском.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль в каталоге.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
  1. Узнайте идентификатор сервисного аккаунта по его имени:
  
      ```bash
      yc iam service-account get <имя_сервисного_аккаунта>
      ```
  
      Результат:
  
      ```text
      id: aje6o61dvog2********
      folder_id: b1gvmob95yys********
      created_at: "2018-10-15T18:01:25Z"
      name: my-robot
      ```
  
      Если вы не знаете имя сервисного аккаунта, получите список сервисных аккаунтов с их идентификаторами:
  
      ```bash
      yc iam service-account list
      ```
  
      Результат:
      
      ```bash
      +----------------------+------------------+-----------------+
      |          ID          |       NAME       |   DESCRIPTION   |
      +----------------------+------------------+-----------------+
      | aje6o61dvog2******** | my-robot         | my description  |
      +----------------------+------------------+-----------------+
      ```
  
  1. Назначьте роль сервисному аккаунту, используя его идентификатор:
  
      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role <роль> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```
  
  
      Где:
  
      * `--role` — идентификатор роли, которую нужно назначить.
      * `--service-account-id` — идентификатор сервисного аккаунта. Также вы можете использовать параметр `--service-account-name` и указать логин пользователя вместо идентификатора.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Назначьте роль `editor` сервисному аккаунту:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "serviceAccount:<идентификатор_сервисного_аккаунта>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md).
      * `role` — роль, которую нужно назначить.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Для сервисного аккаунта укажите `serviceAccount:<идентификатор_сервисного_аккаунта>`.

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

      После этого будут назначены права доступа к каталогу.

- API {#api}

  Чтобы назначить сервисному аккаунту роль на облако или каталог, воспользуйтесь методом REST API `updateAccessBindings` для ресурса [Cloud](../../api-ref/Cloud/index.md) или [Folder](../../api-ref/Folder/index.md):
  
  1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md).
  1. [Узнайте](get-id.md) ID каталога с сервисными аккаунтами.
  1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен для аутентификации в API Yandex Cloud.
  1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:
  
      ```bash
      export FOLDER_ID=<идентификатор_каталога>
      export IAM_TOKEN=<IAM-токен>
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```
  
      Результат:
  
  
      ```json
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "my-robot",
         "description": "my description"
        }
       ]
      }
      ```
  
  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`:
  
      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<роль>",
            "subject": {
              "id": "<идентификатор_сервисного_аккаунта>",
              "type": "serviceAccount"
            }
          }
        }]
      }
      ```
  
      Где:
  
      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.
  
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
  
  1. Назначьте роль сервисному аккаунту. Например, на каталог с идентификатором `b1gvmob95yys********`:
     
     ```bash
     export FOLDER_ID=b1gvmob95yys********
     export IAM_TOKEN=CggaAT********
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data '@body.json' \
       "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
     ```

{% endlist %}

## Доступ к каталогу для федеративного пользователя {#access-to-federated-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Назначение роли происходит так же, как назначение роли пользователю с аккаунтом на Яндексе. Рядом с именем пользователя будет указано имя федерации, к которой он относится.

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../concepts/resources-hierarchy.md#folder).
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  1. Выберите роль из [справочника ролей Yandex Cloud](../../../iam/roles-reference.md).
  1. [Получите идентификатор пользователя](../../../organization/operations/users-get.md).
  1. Назначьте роль с помощью команды:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
          --role <идентификатор_роли> \
          --subject federatedUser:<идентификатор_пользователя>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или идентификатор каталога.
      * `--role` — идентификатор роли, например `editor`.
      * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [Yandex Cloud CLI](../../../cli/index.md) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:
          
          #|
          || **Тип субъекта** | **Обозначение субъекта** | **Параметр Yandex Cloud CLI** ||
          || `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
          || `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
          || `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
          || `group`          | `group:<идентификатор_группы>` | `--group-members` ||
          || `system`         | `system:allAuthenticatedUsers`
          
          (группа `All authenticated users`) | `--all-authenticated-users` ||
          || ^                | `system:allUsers`
          
          (группа `All users`) | — ||
          || ^                | `system:group:organization:<идентификатор_организации>:users`
          
          (группа `All users in organization X`) | `--organization-users` ||
          || ^                | `system:group:federation:<идентификатор_федерации>:users`
          
          (группа `All users in federation N`) | `--federation-users` ||
          || ^                | `system:group:userpool:<идентификатор_пула>:users`
          
          (группа `All users in userpool P`) | — ||
          |#

          {% endcut %}

      Например, назначьте федеративному пользователю с идентификатором `aje6o61dvog2********` роль `editor` на каталог `my-folder`:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject federatedUser:aje6o61dvog2********
      ```

{% endlist %}


## Что дальше {#what-is-next}

* [Изменение каталога](update.md)
* [Иерархия ресурсов Yandex Cloud](../../concepts/resources-hierarchy.md)