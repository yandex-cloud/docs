# Настройка прав доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [{#T}](assign-role-for-sa.md).

## Назначить роль на сервисный аккаунт {#assign-role-to-sa}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
    1. Перейдите на вкладку **Сервисные аккаунты**.
    1. Выберите сервисный аккаунт и нажмите на строку с его именем.
    1. Перейдите на вкладку **Права доступа**.
    1. Нажмите кнопку **Назначить роли**.
    1. В окне **Настройка прав доступа** нажмите кнопку **Выбрать пользователя**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку **Добавить роль**.
    1. Выберите роль.
    1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для назначения роли на сервисный аккаунт как на ресурс:

        ```bash
        yc iam service-account add-access-binding --help
        ```

    1. Выберите сервисный аккаунт, например `my-robot`:

        ```bash
        yc iam service-account list
        ```

        Результат:

        ```
        +----------------------+----------+------------------+
        |          ID          |   NAME   |   DESCRIPTION    |
        +----------------------+----------+------------------+
        | ajebqtreob2dpblin8pe | test-sa  | test-description |
        | aje6o61dvog2h6g9a33s | my-robot |                  |
        +----------------------+----------+------------------+
        ```

    1. Выберите [роль](../../concepts/access-control/roles.md):

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

{% if product == "yandex-cloud" %}
    1. Узнайте ID пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или группе пользователей, воспользуйтесь [примерами](#examples) ниже.

        ```bash
        yc iam user-account get test-user
        ```

        Результат:

        ```
        id: gfei8n54hmfhuk5nogse
        yandex_passport_user_account:
            login: test-user
            default_email: test-user@yandex.ru
        ```
{% endif %}
{% if product == "cloud-il" %}
    1. [Получите ID пользователя](../users/get.md).
{% endif %}

    1. Назначьте пользователю {% if product == "yandex-cloud" %}`test-user`{% endif %} роль `editor` на сервисный аккаунт `my-robot`. В субъекте укажите тип {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} и ID пользователя:

{% if product == "yandex-cloud" %}
        ```bash
        yc iam service-account add-access-binding my-robot \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
        ```
{% endif %}
{% if product == "cloud-il" %}
        ```bash
        yc iam service-account add-access-binding my-robot \
          --role editor \
          --subject federatedUser:<ID пользователя>
        ```
{% endif %}

- API

    Воспользуйтесь методом [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md). Вам понадобится ID сервисного аккаунта и ID пользователя, которому назначается роль на сервисный аккаунт.

    1. Узнайте ID сервисного аккаунта с помощью метода [list](../../api-ref/ServiceAccount/list.md):

        ```bash
        curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
        ```

        Результат:

        ```
        {
        "serviceAccounts": [
            {
            "id": "aje6o61dvog2h6g9a33s",
            "folderId": "b1gvmob95yysaplct532",
            "createdAt": "2018-10-19T13:26:29Z",
            "name": "my-robot"
            }
            ...
        ]
        }
        ```

{% if product == "yandex-cloud" %}
    1. Узнайте ID пользователя по логину с помощью метода [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md):
        
        ```bash
        curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
        ```

        Результат:

        ```
        {
        "id": "gfei8n54hmfhuk5nogse",
        "yandexPassportUserAccount": {
            "login": "test-user",
            "defaultEmail": "test-user@yandex.ru"
        }
        }
        ```

{% endif %}
{% if product == "cloud-il" %}

    1. [Получите ID пользователя](../users/get.md).

{% endif %}

    1. Назначьте пользователю роль `editor` на сервисный аккаунт `my-robot`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} и ID пользователя:

        {% if product == "yandex-cloud" %}
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
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
        ```
        {% endif %}
        {% if product == "cloud-il" %}
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
                      "id": "<ID пользователя>",
                      "type": "federatedUser"
          }}}]}' \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
        ```
        {% endif %}

- {{ TF }}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

       * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
       * `role` — назначаемая роль. Обязательный параметр.
       * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде {% if product == "yandex-cloud" %}`userAccount:<идентификатор пользователя>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<идентификатор пользователя>`{% endif %} или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

       Пример структуры конфигурационного файла:

       ```
       resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
         service_account_id = "<идентификатор сервисного аккаунта>"
         role               = "<роль>"
         members            = [
           "federatedUser:<идентификатор пользователя>",
         ]
       }
       ```

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).

    1. Проверьте корректность конфигурационных файлов.

       1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
       1. Выполните проверку с помощью команды:

          ```
          terraform plan
          ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

       1. Если в конфигурации нет ошибок, выполните команду:

          ```
          terraform apply
          ```

       1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

       После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить создание ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

       ```
       yc resource-manager service-account list-access-bindings <имя сервисного аккаунта>|<идентификатор сервисного аккаунта>
       ```

{% endlist %}

## Примеры {#examples}

* [{#T}](#multiple-roles).
* [{#T}](#access-to-sa).
* [{#T}](#access-to-all).

### Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- CLI

    Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

    {% note alert %}

    Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}

    1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
    
        ```bash
        yc iam service-account list-access-bindings my-robot
        ```

    1. Например, назначьте роль нескольким пользователям:
{% if product == "yandex-cloud" %}

        ```bash
        yc iam service-account set-access-bindings my-robot \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse \
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
        ```

{% endif %}
{% if product == "cloud-il" %}

        ```bash
        yc iam service-account set-access-bindings my-robot \
          --access-binding role=editor,subject=federatedUser:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=federatedUser:helj89sfj80aj24nugsz
        ```

{% endif %}
- API

    Назначьте одному пользователю роль `editor`, а другому `viewer`:
{% if product == "yandex-cloud" %}

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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
    ```

{% endif %}
{% if product == "cloud-il" %}

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
                    "id": "gfei8n54hmfhuk5nogse",
                    "type": "federatedUser"
                }
            }
        },{
            "action": "ADD",
            "accessBinding": {
                "roleId": "viewer",
                "subject": {
                    "id": "helj89sfj80aj24nugsz",
                    "type": "federatedUser"
        }}}]}' \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
    ```

{% endif %}
    Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md).

    {% note alert %}

    Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

    {% endnote %}
{% if product == "yandex-cloud" %}

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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:setAccessBindings
    ```

{% endif %}
{% if product == "cloud-il" %}

    ```bash
    curl -X POST \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer <IAM-TOKEN>" \
        -d '{
        "accessBindings": [{
            "roleId": "editor",
            "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "federatedUser" }
        },{
            "roleId": "viewer",
            "subject": { "id": "helj89sfj80aj24nugsz", "type": "federatedUser" }
        }]}' \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:setAccessBindings
    ```

{% endif %}
- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы назначить несколько ролей на сервисный аккаунт, созданный с помощью {{ TF }}:

    1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

       * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
       * `role` — назначаемая роль. Обязательный параметр.

       {% note info %}

       Для каждой роли можно использовать только один ресурс `yandex_iam_service_account_iam_binding`.

       {% endnote %}

       * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде {% if product == "yandex-cloud" %}`userAccount:<идентификатор пользователя>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<идентификатор пользователя>`{% endif %} или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

     {% cut "Пример назначения нескольких ролей на сервисный аккаунт с помощью {{ TF }}" %}
{% if product == "yandex-cloud" %}

     ```hcl
     ...
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "admin"
       members = [
         "userAccount:aje82upckiqhi3943ekr",
       ]
     }
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam2" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "viewer"
       members = [
         "userAccount:aje82upckiqhi3943ekr",
       ]
     }
     ...
     ```
    
{% endif %}
{% if product == "cloud-il" %}

     ```hcl
     ...
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "admin"
       members = [
         "federatedUser:aje82upckiqhi3943ekr",
       ]
     }
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam2" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "viewer"
       members = [
         "federatedUser:aje82upckiqhi3943ekr",
       ]
     }
     ...
     ```
   
{% endif %}
     {% endcut %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).
  
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
     yc resource-manager service-account list-access-bindings <имя сервисного аккаунта>|<идентификатор сервисного аккаунта>
     ```

{% endlist %}


### Доступ сервисного аккаунта к другому сервисному аккаунту {#access-to-sa}

Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

{% list tabs %}

- CLI

  1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      | aje6o61dvog2h6g9a33s | my-robot |                  |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его ID. В типе субъекта укажите `serviceAccount`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject serviceAccount:ajebqtreob2dpblin8pe
      ```

- API

  1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      ```

      Результат:

      ```
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        },
        {
         "id": "aje6o61dvog2h6g9a33s",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-15T18:01:25Z",
         "name": "my-robot"
        }
       ]
      }
      ```

  1. Назначьте сервисному аккаунту `test-sa` роль `editor` на другой сервисный аккаунт `my-robot`. В свойстве `subject` укажите тип `serviceAccount` и ID `test-sa`. В URL запроса в качестве ресурса укажите ID `my-robot`:

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
                      "id": "ajebqtreob2dpblin8pe",
                      "type": "serviceAccount"
          }}}]}' \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
      ```


- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы разрешить сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`, созданным при помощи {{ TF }}:

    1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

       * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
       * `role` — назначаемая роль. Обязательный параметр.
       * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде {% if product == "yandex-cloud" %}`userAccount:<идентификатор пользователя>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<идентификатор пользователя>`{% endif %} или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

     {% cut "Пример разрешения сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot` с помощью {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "admin"
       members = [
         "serviceAccount:aje82upckiqhi3943ekr",
       ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).
  
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
     yc resource-manager service-account list-access-bindings <имя сервисного аккаунта>|<идентификатор сервисного аккаунта>
     ```

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`:

{% list tabs %}

- CLI

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

  ```bash
  yc iam service-account add-access-binding my-robot \
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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
  ```

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы разрешить любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`:

    1. Добавьте в конфигурационный файл параметры ресурса и укажите роль пользователей для доступа к сервисному аккаунту:

       * `service_account_id` — идентификатор сервисного аккаунта, к которому нужно настроить доступ.
       * `role` — назначаемая роль. Обязательный параметр.
       * `members` — список пользователей и сервисных аккаунтов, которым назначается роль. Указывается в виде {% if product == "yandex-cloud" %}`userAccount:<идентификатор пользователя>`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} или `serviceAccount:<идентификатор сервисного аккаунта>`. Обязательный параметр.

     {% cut "Пример разрешения любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`" %}

     ```hcl
     ...
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "viewer"
       members = [
         "system:allUsers",
       ]
     }
     ...
     ```
    
     {% endcut %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_iam_binding).
  
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
     yc resource-manager service-account list-access-bindings <имя сервисного аккаунта>|<идентификатор сервисного аккаунта>
     ```

{% endlist %}
