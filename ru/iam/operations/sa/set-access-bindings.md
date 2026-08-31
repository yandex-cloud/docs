# Настройка прав доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [{#T}](assign-role-for-sa.md).

{% note info %}

Чтобы назначить роль на сервисный аккаунт, нужна роль `iam.serviceAccounts.admin`.

{% endnote %}


## Назначить роль на сервисный аккаунт {#assign-role-to-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите **{{ ui-key.yacloud.shared.iam.action_assign-roles_8vkmR }}**.
  1. В окне **{{ ui-key.yacloud_components.acl.label.title }}** в поле **{{ ui-key.yacloud_components.acl.label.subject }}** выберите субъект или воспользуйтесь поиском.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль.
  1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле ресурс с ролью на организацию.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        role               = "<роль>"
        members            = ["<тип_субъекта_1>:<идентификатор_субъекта_1>",
                              "<тип_субъекта_2>:<идентификатор_субъекта_2>",
                              ...,
                              "<тип_субъекта_n>:<идентификатор_субъекта_n>"]
      }
      ```

      Где:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.
      * `members` — обозначения [субъектов](../../concepts/access-control/index.md#subject), которым назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Назначьте роль.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md). Вам понадобится идентификатор сервисного аккаунта и идентификатор субъекта, которому назначается роль на сервисный аккаунт.

  1. Узнайте идентификатор сервисного аккаунта с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=<идентификатор_каталога>
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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/<идентификатор_сервисного_аккаунта>:updateAccessBindings
      ```

      Где:

      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

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

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите **{{ ui-key.yacloud.shared.iam.action_assign-roles_8vkmR }}**.
  1. В окне **{{ ui-key.yacloud_components.acl.label.title }}** в поле **{{ ui-key.yacloud_components.acl.label.subject }}** выберите пользователя из списка или воспользуйтесь поиском по пользователям.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль.
  1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Назначьте пользователю `test-user` роль `editor` на сервисный аккаунт `my-robot`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --user-yandex-login test-user
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

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

      Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Назначьте роль.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md). Вам понадобится идентификатор сервисного аккаунта и идентификатор пользователя, которому назначается роль на сервисный аккаунт.

  1. Узнайте идентификатор сервисного аккаунта с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}

### Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить несколько ролей на сервисный аккаунт, созданный с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.

          {% note info %}

          Для каждой роли можно использовать только один ресурс `yandex_iam_service_account_iam_binding`.

          {% endnote %}

      * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      {% cut "Пример назначения нескольких ролей на сервисный аккаунт с помощью {{ TF }}" %}

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

      Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).
 
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Назначьте роль.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:setAccessBindings
    ```

{% endlist %}


### Настроить доступ сервисного аккаунта к другому сервисному аккаунту {#access-to-sa}

Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы разрешить сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`, созданным при помощи {{ TF }}:

  1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

      * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
      * `role` — назначаемая роль.
      * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      {% cut "Пример разрешения сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot` с помощью {{ TF }}" %}

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

      Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Назначьте роль.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager service-account list-access-bindings <имя_или_идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}


## Полезные ссылки {#see-also}

* [{#T}](./impersonate-sa.md)