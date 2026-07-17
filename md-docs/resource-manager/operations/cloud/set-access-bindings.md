[Документация Yandex Cloud](../../../index.md) > [Yandex Resource Manager](../../index.md) > [Пошаговые инструкции](../index.md) > Облако > Настройка прав доступа

# Настройка прав доступа к облаку

{% note warning %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) Yandex Cloud разрешена [ролью](../../../iam/concepts/access-control/roles.md), ее выполнение может быть заблокировано, если для [организации](../../../organization/concepts/organization.md), [облака](../../concepts/resources-hierarchy.md#cloud) или [каталога](../../concepts/resources-hierarchy.md#folder) создана [политика авторизации](../../../iam/concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

Чтобы предоставить пользователю доступ к ресурсам в [облаке](../../concepts/resources-hierarchy.md#cloud), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.

## Назначить роль на облако {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) [выберите](switch-cloud.md) облако.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль из списка или воспользуйтесь поиском.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для назначения роли на облако:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

  1. Получите список доступных облаков:

      ```bash
      yc resource-manager cloud list
      ```

      Результат:

      ```text
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7******** | my-cloud |
      +----------------------+----------+
      ```

  1. Получите список доступных ролей:

      ```bash
      yc iam role list
      ```

      Результат:

      ```text
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

  1. Назначьте пользователю роль на облако. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<идентификатор_пользователя>
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
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
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль>"
        member   = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль. Обязательный параметр.
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

      Подробнее о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` в Terraform читайте в [документации провайдера](../../../terraform/resources/resourcemanager_cloud_iam_member.md).

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

      После этого будут назначены права доступа к облаку.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../api-ref/grpc/Cloud/updateAccessBindings.md).

  Вам понадобится идентификатор облака и идентификатор пользователя, которому назначается роль на облако.

  1. Узнайте идентификатор облака с помощью метода REST API [list](../../api-ref/Cloud/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
      ```

      Результат:

      ```text
      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7********",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
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

      ```text
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Назначьте пользователю роль на облако. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` и идентификатор пользователя:

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
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
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

  1. В [консоли управления](https://console.yandex.cloud) [выберите](switch-cloud.md) облако.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Назначить роли**.
  1. В окне **Настройка прав доступа** нажмите кнопку **Выбрать пользователя**.
  1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите кнопку **Добавить роль**.
  1. Выберите роль в облаке.
  1. Добавьте еще роль через кнопку **Добавить роль**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% note alert %}
  
  Команда `set-access-bindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc resource-manager cloud list-access-bindings <имя_или_идентификатор_облака>
      ```

  1. Чтобы назначить роль, выполните команду:

      ```bash
      yc resource-manager cloud set-access-bindings <имя_или_идентификатор_облака> \
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
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры прав доступа к облаку.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member1" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль_1>"
        member   = "userAccount:<идентификатор_пользователя>"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member2" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль_2>"
        member   = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль. Обязательный параметр.
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

      После этого будут назначены права доступа к облаку.

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
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
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

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызова gRPC API [CloudService/SetAccessBindings](../../api-ref/grpc/Cloud/setAccessBindings.md).

  {% note alert %}
  
  Метод `setAccessBindings` для назначения нескольких ролей полностью перезаписывает права доступа к ресурсу. Все текущие роли на ресурс будут удалены.
  
  {% endnote %}

{% endlist %}


## Доступ к облаку для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно [назначать](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) роли на любые облака и каталоги в рамках организации, к которой он принадлежит.

Разрешите сервисному аккаунту `test-sa` управлять облаком `my-cloud` и ресурсами в нем:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.

  Чтобы назначить сервисному аккаунту роль на облако:

  1. В [консоли управления](https://console.yandex.cloud) слева [выберите](switch-cloud.md) облако.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт из списка или воспользуйтесь поиском.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  1. Узнайте идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль сервисному аккаунту, используя его идентификатор:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role <роль> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить, например `resource-manager.clouds.owner`.
      * `--service-account-id` — идентификатор сервисного аккаунта. Также вы можете использовать параметр `--service-account-name` и указать имя сервисного аккаунта вместо идентификатора.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "<идентификатор_облака>"
        role     = "<роль>"
        member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Обязательный параметр.
      * `role` — назначаемая роль. Описание ролей можно найти в документации Yandex Identity and Access Management в [справочнике ролей Yandex Cloud](../../../iam/roles-reference.md). Обязательный параметр.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Для сервисного аккаунта укажите `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

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

      После этого будут назначены права доступа к облаку.

- API {#api}

  1. Узнайте идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<идентификатор_каталога>
      ```

      Результат:

      ```text
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

  1. Назначьте сервисному аккаунту роль на облако. В свойстве `subject` укажите тип `serviceAccount` и идентификатор сервисного аккаунта. В URL запроса в качестве ресурса укажите идентификатор облака:

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
                  "id": "<идентификатор_сервисного_аккаунта>",
                  "type": "serviceAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
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


## Что дальше {#what-is-next}

* [Создание каталога](../folder/create.md)
* [Настройка прав доступа к каталогу](../folder/set-access-bindings.md)
* [Иерархия ресурсов Yandex Cloud](../../concepts/resources-hierarchy.md)