# Настройка прав доступа к каталогу

Чтобы предоставить пользователю доступ к ресурсам в [каталоге](../../concepts/resources-hierarchy.md#folder), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на этот каталог.

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

## Назначить роль на каталог {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды для назначения роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Выберите каталог, например `my-folder`:

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

  1. Выберите [роль](../../../iam/concepts/access-control/roles.md):

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

  1. Назначьте пользователю `test-user` роль `editor` на каталог `my-folder`. В субъекте укажите тип `userAccount` и ID пользователя:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfh********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить роль на каталог, созданный с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_member`.

       {% endnote %}

     * `member` — пользователь, которому будет присвоена роль. Обязательный параметр. Может иметь одно из следующих значений:
       * `userAccount:<идентификатор_пользователя>` — [ID пользователя](../../../iam/operations/users/get.md).
       * `serviceAccount:<идентификатор_сервисного_аккаунта>` — [ID сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `federatedUser:<идентификатор_пользовательского_аккаунта>` — [ID пользовательского аккаунта](../../../organization/operations/users-get.md).
       * `system:group:organization:<идентификатор_организации>:users` — идентификатор [организации](../../../organization/quickstart.md), чтобы назначить роль [системной группе](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`.
       * `system:group:federation:<идентификатор_федерации>:users` — идентификатор [федерации удостоверений](../../../organization/concepts/add-federation.md), чтобы назначить роль [системной группе](../../../iam/concepts/access-control/system-group.md#allFederationUsers) `All users in federation N`.

     {% cut "Пример назначения роли на каталог с помощью {{ TF }}" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор_каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"
       role      = "editor"
       member    = "userAccount:<login@yandex.ru>"
     }
     ...
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
     ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../api-ref/grpc/Folder/updateAccessBindings.md). Вам понадобится ID каталога и ID пользователя, которому назначается роль на каталог.

  1. Узнайте ID каталога с помощью метода REST API [list](../../api-ref/Folder/list.md):
      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=b1gg8sgd16g7********
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

  1. Узнайте ID пользователя по логину с помощью метода REST API [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):
      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
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

  1. Назначьте пользователю роль `editor` на каталог `my-folder`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и ID пользователя:

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
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:updateAccessBindings
      ```

{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:
      ```bash
      yc resource-manager folder list-access-bindings my-folder
      ```
  1. Например, назначьте роль нескольким пользователям:

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить несколько ролей на каталог, созданный с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_member`.

       {% endnote %}

     * `member` — пользователь, которому будет присвоена роль. Чтобы добавить пользователя в список, создайте запись в формате `userAccount:<идентификатор_пользователя>`, где `<идентификатор_пользователя>` — email-адрес аккаунта Яндекс (например, `ivan@yandex.ru`). Обязательный параметр.

     {% cut "Пример назначения роли на каталог с помощью {{ TF }}" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор_каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "editor"
       member    = "userAccount:<login1@yandex.ru>"
     }
     resource "yandex_resourcemanager_folder_iam_member" "operator" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "operator"
       member    = "userAccount:<login1@yandex.ru>"
     }
     ...
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
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
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызова gRPC API [FolderService/SetAccessBindings](../../api-ref/grpc/Folder/setAccessBindings.md).

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
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:setAccessBindings
  ```

{% endlist %}


## Доступ к каталогу для сервисного аккаунта {#access-to-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Не создавайте ресурс совместно с ресурсом `yandex_resourcemanager_folder_iam_policy`. Они будут конфликтовать.

  {% endnote %}

  Чтобы назначить роль для сервисного аккаунта на каталог, созданный с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры роли каталога:

     * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_resourcemanager_folder_iam_member`.

       {% endnote %}

     * `member` — пользователь, которому будет присвоена роль. Чтобы добавить пользователя в список, создайте запись в формате `serviceAccount:<идентификатор_сервисного_аккаунта>`, где `<идентификатор_сервисного_аккаунта>` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md). Вы можете перечислить несколько сервисных аккаунтов. Обязательный параметр.

     {% cut "Пример назначения роли на каталог с помощью {{ TF }}" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<идентификатор_каталога>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "editor"
       member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
     }
     ...
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
     ```

- API {#api}

  {% include [grant-role-for-sa-to-folder-via-api](../../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

## Доступ к каталогу для федеративного пользователя {#access-to-federated-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Назначение роли происходит так же, как назначение роли пользователю с аккаунтом на Яндексе. Рядом с именем пользователя будет указано имя федерации, к которой он относится.

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  1. Выберите роль из [справочника ролей {{ yandex-cloud }}](../../../iam/roles-reference.md).
  1. [Получите идентификатор пользователя](../../../iam/operations/users/get.md).
  1. Назначьте роль с помощью команды:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
          --role <идентификатор_роли> \
          --subject federatedUser:<идентификатор_пользователя>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или идентификатор каталога.
      * `--role` — идентификатор роли, например `editor`.
      * `--subject` — идентификатор аккаунта пользователя, которому назначается роль.

      Например, назначьте федеративному пользователю с идентификатором `aje6o61dvog2********` роль `editor` на каталог `my-folder`:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject federatedUser:aje6o61dvog2********
      ```

{% endlist %}


## Что дальше {#what-is-next}

* [{#T}](update.md)
* [{#T}](../../concepts/resources-hierarchy.md)
