[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Пошаговые инструкции](../index.md) > Сервисные аккаунты > Настройка прав доступа к сервисному аккаунту

# Настройка прав доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [Назначение роли сервисному аккаунту](assign-role-for-sa.md).

{% note info %}

Чтобы назначить роль на сервисный аккаунт, нужна роль `iam.serviceAccounts.admin`.

{% endnote %}


## Назначить роль на сервисный аккаунт {#assign-role-to-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите **Назначить роли**.
  1. В окне **Выдача доступа** в поле **Кому выдать доступ** выберите субъект или воспользуйтесь поиском.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для назначения роли на сервисный аккаунт как на ресурс:

      ```bash
      yc iam service-account add-access-binding --help
      ```

  1. Узнайте идентификатор [роли](../../concepts/access-control/roles.md):

      ```bash
      yc iam role list
      ```

      Результат:

      ```text
      +-------------------------------------+-------------+
      |                 ID                  | DESCRIPTION |
      +-------------------------------------+-------------+
      | access-transparency.admin           |             |
      | access-transparency.billingProvider |             |
      | access-transparency.editor          |             |
      | ...                                 |             |
      ```

  1. Назначьте субъекту роль на сервисный аккаунт:

      ```bash
      yc iam service-account add-access-binding <имя_или_идентификатор_сервисного_аккаунта> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить.
      * `--subject` — обозначение [субъекта](../../concepts/access-control/index.md#subject), которому назначается роль.

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле ресурс с ролью на организацию.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        role               = "<роль>"
        members            = ["<субъект_1>","<субъект_2>,...,<субъект_n>"]
      }
      ```

      Где:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.
      * `members` — обозначения [субъектов](../../concepts/access-control/index.md#subject), которым назначается роль.

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

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/resources/iam_service_account_iam_binding.md).

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Назначьте роль.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md). Вам понадобится идентификатор сервисного аккаунта и идентификатор субъекта, которому назначается роль на сервисный аккаунт.

  1. Узнайте идентификатор сервисного аккаунта с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=<идентификатор_каталога>
      ```

      Результат:

      ```json
      {
      "serviceAccounts": [
          {
          "id": "aje6o61dvog2********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-10-19T13:26:29Z",
          "name": "my-robot"
          }
          ...
      ]
      }
      ```

  1. Назначьте субъекту роль на сервисный аккаунт, в свойстве `action` укажите `ADD`:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "<роль>",
                "subject": {
                    "id": "<идентификатор_субъекта>",
                    "type": "<тип_субъекта>"
        }}}]}' \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/<идентификатор_сервисного_аккаунта>:updateAccessBindings
      ```

      Где:

      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../concepts/access-control/index.md#subject), которому назначается роль.

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

      * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.

{% endlist %}


## Примеры {#examples}

* [Настроить доступ пользователя к сервисному аккаунту](#user-access).
* [Назначить несколько ролей](#multiple-roles).
* [Настроить доступ сервисного аккаунта к другому сервисному аккаунту](#access-to-sa).


### Настроить доступ пользователя к сервисному аккаунту {#user-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
  1. Перейдите на вкладку **Права доступа**.
  1. Нажмите **Назначить роли**.
  1. В окне **Выдача доступа** в поле **Кому выдать доступ** выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Назначьте пользователю `test-user` роль `editor` на сервисный аккаунт `my-robot`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --user-yandex-login test-user
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje6o61dvog2********"
        role               = "editor"
        members            = ["userAccount:gfei8n54hmfh********",]
      }
      ```

      Где:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.
      * `members` — список пользователей, которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>`.

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/resources/iam_service_account_iam_binding.md).

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Назначьте роль.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md). Вам понадобится идентификатор сервисного аккаунта и идентификатор пользователя, которому назначается роль на сервисный аккаунт.

  1. Узнайте идентификатор сервисного аккаунта с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Результат:

      ```json
      {
      "serviceAccounts": [
          {
          "id": "aje6o61dvog2********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-10-19T13:26:29Z",
          "name": "my-robot"
          }
          ...
      ]
      }
      ```

  1. Узнайте идентификатор пользователя по логину с помощью метода REST API [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md):
      
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

  1. Назначьте пользователю роль `editor` на сервисный аккаунт `my-robot`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и идентификатор пользователя:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "gfei8n54hmfh********",
                    "type": "userAccount"
        }}}]}' \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}

### Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

    {% note alert %}

    Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}

    1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:
    
        ```bash
        yc iam service-account list-access-bindings my-robot
        ```

    1. Назначьте роль нескольким пользователям:

        ```bash
        yc iam service-account set-access-bindings my-robot \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
          --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы назначить несколько ролей на сервисный аккаунт, созданный с помощью Terraform:

  1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.

          {% note info %}

          Для каждой роли можно использовать только один ресурс `yandex_iam_service_account_iam_binding`.

          {% endnote %}

      * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      {% cut "Пример назначения нескольких ролей на сервисный аккаунт с помощью Terraform" %}

      ```hcl
      ...
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje82upckiqh********"
        role               = "admin"
        members = [
          "userAccount:aje82upckiqh********",
        ]
      }
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam2" {
        service_account_id = "aje82upckiqh********"
        role               = "viewer"
        members = [
          "userAccount:aje82upckiqh********",
        ]
      }
      ...
      ```

      {% endcut %}

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/resources/iam_service_account_iam_binding.md).
 
  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Назначьте роль.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      Проверить изменение каталога можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

    Назначьте одному пользователю роль `editor`, а другому `viewer`:

    ```bash
    curl \
      --request POST \
      --header 'Content-Type: application/json' \
      --header "Authorization: Bearer <IAM-токен>" \
      --data '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "gfei8n54hmfh********",
                  "type": "userAccount"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "helj89sfj80a********",
                  "type": "userAccount"
      }}}]}' \
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
    ```

    Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../api-ref/grpc/ServiceAccount/setAccessBindings.md).

    {% note alert %}

    Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}

    ```bash
    curl \
      --request POST \
      --header 'Content-Type: application/json' \
      --header "Authorization: Bearer <IAM-токен>" \
      --data '{
      "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "ajei8n54hmfh********", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80a********", "type": "userAccount" }
      }]}' \
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2********:setAccessBindings
    ```

{% endlist %}


### Настроить доступ сервисного аккаунта к другому сервисному аккаунту {#access-to-sa}

Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      | aje6o61dvog2******** | my-robot |                  |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его идентификатор:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --service-account-id ajebqtreob2d********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы разрешить сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`, созданным при помощи Terraform:

  1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.
      * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      {% cut "Пример разрешения сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot` с помощью Terraform" %}

      ```hcl
      ...
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje82upckiqh********"
        role               = "admin"
        members = [
          "serviceAccount:aje82upckiqh********",
        ]
      }
      ...
      ```

      {% endcut %}

      Подробнее о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/resources/iam_service_account_iam_binding.md).

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Назначьте роль.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      Проверить изменение каталога можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Результат:

      ```
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        },
        {
         "id": "aje6o61dvog2********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-15T18:01:25Z",
         "name": "my-robot"
        }
       ]
      }
      ```

  1. Назначьте сервисному аккаунту `test-sa` роль `editor` на другой сервисный аккаунт `my-robot`. В свойстве `subject` укажите тип `serviceAccount` и идентификатор `test-sa`. В URL запроса в качестве ресурса укажите идентификатор `my-robot`:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "ajebqtreob2d********",
                    "type": "serviceAccount"
        }}}]}' \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}


## Полезные ссылки {#see-also}

* [Использование имперсонации](impersonate-sa.md)