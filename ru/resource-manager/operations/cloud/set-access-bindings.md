# Настройка права доступа к облаку

Чтобы предоставить пользователю доступ ко всем ресурсам в облаке, назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.

## Назначить роль на облако {#access-to-user}

{% list tabs %}

- Консоль управления

  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Нажмите значок ![image](../../../_assets/plus-sign.svg) в блоке **Роли на облако <имя облака>**.
  1. Выберите необходимую роль из списка.

- CLI

  1. Посмотрите описание команды для назначения роли на облако:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

  1. Получите список доступных облаков:

      ```bash
      yc resource-manager cloud list
      ```

      Результат:

      ```bash
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7qca5onqs | my-cloud |
      +----------------------+----------+
      ```

  1. Получите список доступных [ролей](../../../iam/concepts/access-control/roles.md):

      ```bash
      yc iam role list
      ```

      Результат:

      ```bash
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

  1. Узнайте идентификатор пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или системной группе используйте [примеры](#examples) ниже.

      ```bash
      yc iam user-account get test-user
      ```

      Результат:

      ```bash
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

  1. Назначьте пользователю `test-user` роль `editor` на облако `my-cloud`. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<идентификатор пользователя>
      ```

- API

  Воспользуйтесь методом [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md). Вам понадобится идентификатор облака и идентификатор пользователя, которому назначается роль на облако.

  1. Узнайте идентификатор облака с помощью метода [list](../../api-ref/Cloud/list.md):

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
      ```
      
      Результат:
      
      ```bash
      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7qca5onqs",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
        }
       ]
      }
      ```

  1. Узнайте идентификатор пользователя по логину с помощью метода [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```
      
      Результат:
      
      ```bash
      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Назначьте пользователю роль `editor` на облако `my-cloud`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и идентификатор пользователя:

      ```bash
      curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<идентификатор пользователя>",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
      ```

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры прав доступа к облаку:
      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_binding` можно назначить только одну роль.
      * блок `members` — список пользователей, которым нужно назначить роль. Каждая запись может иметь одно из следующих значений:
        * `userAccount:<идентификатор пользователя>` — [идентификатор пользователя](../../../iam/operations/users/get.md).
        * `serviceAccount:<идентификатор сервисного аккаунта>` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
        * `federatedUser:<идентификатор федеративного аккаунта>` — [идентификатор федеративного аккаунта](../../../organization/users-get.md).

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "userAccount:<идентификатор пользователя>",
        ]
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_binding` в Terraform, см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_cloud_iam_binding).
  1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:
      
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}

## Примеры {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- CLI

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:

      ```bash
      yc resource-manager cloud list-access-binding my-cloud
      ```

  1. Например, назначьте роль нескольким пользователям:

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:<идентификатор первого пользователя>
        --access-binding role=viewer,subject=userAccount:<идентификатор второго пользователя>
      ```

- API

  Назначьте одному пользователю роль `editor`, а другому `viewer`:

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "<идентификатор первого пользователя>",
                  "type": "userAccount"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "<идентификатор второго пользователя>",
                  "type": "userAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md).

  {% note alert %}

  Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "<идентификатор первого пользователя>", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "<идентификатор второго пользователя>", "type": "userAccount" }
      }]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
  ```

- Terraform

  1. Опишите в конфигурационном файле параметры прав доступа к облаку. Назначьте одному пользователю роль `editor`, а другому `viewer`:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "userAccount:<идентификатор первого пользователя>",
        ]
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "viewer"
        members = [
          "userAccount:<идентификатор второго пользователя>",
        ]
      }
      ```

  1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:
      
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}

### Доступ к облаку для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно назначать роли только на облако, которому он принадлежит.

Разрешите сервисному аккаунту `test-sa` управлять облаком `my-cloud` и ресурсами в нем:

{% list tabs %}

- CLI

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```bash
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его идентификатор. В типе субъекта укажите `serviceAccount`:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject serviceAccount:<идентификатор сервисного аккаунта>
      ```

- API

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      ```

      Результат:

      ```bash
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

  1. Назначьте сервисному аккаунту `test-sa` роль `editor` на облако `my-cloud`. В свойстве `subject` укажите тип `serviceAccount` и идентификатор `test-sa`. В URL запроса в качестве ресурса укажите идентификатор `my-cloud`:

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "<идентификатор сервисного аккаунта>",
                  "type": "serviceAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

- Terraform

  1. Назначьте роль `editor` сервисному аккаунту: 

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "serviceAccount:<идентификатор сервисного аккаунта>",
        ]
      }
      ```

  1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:
      
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию об облаке `my-cloud` и ресурсах в нем:

{% list tabs %}

- CLI

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

  ```bash
  yc resource-manager cloud add-access-binding my-cloud \
    --role viewer \
    --subject system:allAuthenticatedUsers
  ```

- API

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В свойстве `subject` укажите тип `system`:

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

- Terraform

  1. Назначьте роль `viewer` системной группе `allAuthenticatedUsers`: 

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "viewer"
        members = [
          "system:allAuthenticatedUsers",
        ]
      }
      ```

  1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:
      
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
