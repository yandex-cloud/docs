# Настройка прав доступа к каталогу

Чтобы предоставить пользователю доступ ко всем ресурсам в каталоге, назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на этот каталог.

## Назначить роль на каталог {#access-to-user}

{% list tabs %}

- Консоль управления

  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Выберите каталог в блоке **Роли в каталогах** и нажмите значок ![image](../../../_assets/plus-sign.svg).
  1. Выберите необходимую роль из списка.

- CLI

  1. Посмотрите описание команды для назначения роли на каталог:

      ```
      $ yc resource-manager folder add-access-binding --help
      ```

  2. Выберите каталог, например `my-folder`:

      ```
      $ yc resource-manager folder list
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

  3. Выберите [роль](../../../iam/concepts/access-control/roles.md):

      ```
      $ yc iam role list
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```
  4. Узнайте ID пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или группе пользователей, воспользуйтесь [примерами](#examples) ниже.

      ```
      $ yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```
  5. Назначьте пользователю `test-user` роль `editor` на каталог `my-folder`. В субъекте укажите тип `userAccount` и ID пользователя:

      ```
      $ yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API

  Воспользуйтесь методом [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md). Вам понадобится ID каталога и ID пользователя, которому назначается роль на каталог.

  1. Узнайте ID каталога с помощью метода [list](../../api-ref/Folder/list.md):
      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs

      {
       "folders": [
        {
         "id": "b1g66mft1vopnevbn57j",
         "cloudId": "b1gd129pp9ha0vnvf5g7",
         "createdAt": "2018-10-17T12:44:31Z",
         "name": "my-folder",
         "status": "ACTIVE"
        }
       ]
      }
      ```
  2. Узнайте ID пользователя по логину с помощью метода [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):
      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```
  3. Назначьте пользователю роль `editor` на каталог `my-folder`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и ID пользователя:

      ```bash
      $ curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить роль на каталог, созданный с помощью Terraform:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.
       
       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_binding`.

       {% endnote %}

     * `members` — список пользователей, которым будет присвоена роль. Обязательный параметр. Каждая запись может иметь одно из следующих значений:
       * `userAccount:<ID пользователя>` — [ID пользователя](../../../iam/operations/users/get.md).
       * `serviceAccount:<ID сервисного аккаунта>` — [ID сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `federatedUser:<ID федеративного аккаунта>` — [ID федеративного аккаунта](../../../organization/users-get.md). 

     {% cut "Пример назначения роли на каталог с помощью Terraform" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_binding" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"

       role = "editor"

       members = [
         "userAccount:<login@yandex.ru>",
       ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_binding` в Terraform, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).
  
  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя каталога>|<ID каталога>
     ```

{% endlist %}

## Примеры {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- Консоль управления

  Воспользуйтесь инструкцией в [начале раздела](#access-to-user) и назначьте пользователю несколько ролей.

  Чтобы назначить роль другому пользователю, выберите пользователя на вкладке [Пользователи и роли]({{ link-console-access-management }}) и нажмите кнопку **Настроить роли**.

- CLI

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
      ```
      $ yc resource-manager folder list-access-bindings my-folder
      ```
  2. Например, назначьте роль нескольким пользователям:
      ```
      $ yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API

  Назначьте одному пользователю роль `editor`, а другому `viewer`:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "gfei8n54hmfhuk5nogse",
                  "type": "userAccount"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "helj89sfj80aj24nugsz",
                  "type": "userAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/Folder/setAccessBindings.md).

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
          "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
      }]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
  ```

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить несколько ролей на каталог, созданный с помощью Terraform:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_binding`.

       {% endnote %}

     * `members` — список пользователей, которым будет присвоена роль. Чтобы добавить пользователя в список, создайте запись в формате `userAccount:<ID пользователя>`, где `<ID пользователя>` — email-адрес аккаунта Яндекс (например, `ivan@yandex.ru`). Обязательный параметр.

     {% cut "Пример назначения роли на каталог с помощью Terraform" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_binding" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

       role = "editor"

       members = [
         "userAccount:<login1@yandex.ru>"
       ]
     }
     resource "yandex_resourcemanager_folder_iam_binding" "operator" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

       role = "operator"

       members = [
         "userAccount:<login1@yandex.ru>"
       ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_binding` в Terraform, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).
  
  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя каталога>|<ID каталога>
     ```

{% endlist %}


### Доступ к каталогу для сервисного аккаунта {#access-to-sa}

Через консоль управления сервисному аккаунту можно назначить роль только на каталог, в котором он был создан. Чтобы назначить ему роль на другой ресурс, используйте CLI или API.

Разрешите сервисному аккаунту управлять каталогом и ресурсами в нем:

{% list tabs %}

- Консоль управления

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- API

  {% include [grant-role-for-sa-to-folder-via-api](../../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}
  
  Чтобы назначить роль для сервисного аккаунта на каталог, созданный с помощью Terraform:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_binding`.

       {% endnote %}

     * `members` — список пользователей, которым будет присвоена роль. Чтобы добавить пользователя в список, создайте запись в формате `serviceAccount:<ID сервисного аккаунта>`, где `<ID сервисного аккаунта>` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md). Вы можете перечислить несколько сервисных аккаунтов. Обязательный параметр.

     {% cut "Пример назначения роли на каталог с помощью Terraform" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_binding" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

       role = "editor"

       members = [
         "serviceAccount:<идентификатор сервисного аккаунта>"
       ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_binding` в Terraform, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).
  
  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя каталога>|<ID каталога>
     ```

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-all.md) %}


#### Что дальше {#what-is-next}

* [{#T}](update.md)
* [{#T}](../../concepts/resources-hierarchy.md)
