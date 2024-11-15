# Настройте облако

При регистрации в {{ yandex-cloud }} для пользователя будет создано _облако_ — отдельное рабочее пространство, для которого этот пользователь будет назначен владельцем. В облаке будет создан каталог `default` и сеть `default`.

Владелец может создавать в этом облаке новые каталоги и ресурсы, а также управлять правами доступа к ним.

## Создайте каталог

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-folder](../../_includes/create-folder.md) %}

- CLI {#cli}

  1. Посмотрите описание команды создания каталога:

      ```
      yc resource-manager folder create --help
      ```

  1. Создайте новый каталог:

      * с именем и без описания:
          
          ```
          yc resource-manager folder create \
              --name new-folder
          ```

          Требования к имени каталога:

          {% include [name-format](../../_includes/name-format.md) %}

      * с именем и описанием:

          ```
          yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API {#api}

  Чтобы создать каталог, воспользуйтесь методом [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md).

{% endlist %}

## Измените каталог {#change-folder}

Через консоль управления можно изменить только имя каталога. Чтобы изменить его описание, используйте CLI или API.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите каталог на [стартовой странице]({{ link-console-main }}) консоли управления. На этой странице отображаются каталоги для выбранного облака. Если необходимо, [переключитесь на другое облако](../../resource-manager/operations/cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Введите новое имя каталога.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders.popup-edit_button_save }}**.

- CLI {#cli}

  1. Посмотрите описание команды изменения каталога:

      ```
      yc resource-manager folder update --help
      ```
  1. Если вы знаете идентификатор или имя каталога, переходите к следующему шагу. Если нет, то узнайте это одним из способов:

      * Получите список каталогов:

          ```
          $ yc resource-manager folder list
          +----------------------+--------------------+--------+--------+-------------+
          |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
          +----------------------+--------------------+--------+--------+-------------+
          | b1gppulhhm2aaufq9eug | yet-another-folder |        | ACTIVE |             |
          | b1gvmob95yysaplct532 | default            |        | ACTIVE |             |
          +----------------------+--------------------+--------+--------+-------------+
          ```

      * Если вы знаете идентификатор ресурса, который принадлежит нужному каталогу, получите идентификатор каталога из информации об этом ресурсе:

          ```
          yc <SERVICE-NAME> <RESOURCE> get <RESOURCE-ID>
          ```

          где:
          * `<SERVICE-NAME>` — имя сервиса, например `compute`.
          * `<RESOURCE>` — категория ресурса, например `instance`.
          * `<RESOURCE-ID>` — идентификатор ресурса.

          Например, виртуальная машина `fhmp74bfis2aim728p2a` принадлежит каталогу `b1gpvjd9ir42nsng55ck`:

          ```
          yc compute instance get fhmp74bfis2ais728p2a
          id: fhmp74bfis2ais728p2a
          folder_id: b1gpvjd9ia42nsng55ck
          ...
          ```
  1. Измените параметры каталога, например имя и описание. Вы можете указать изменяемый каталог по имени или идентификатору.

      ```
      yc resource-manager folder update default \
          --new-name myfolder \
          --description "this is my default-folder"
      ```

      Команда переименует каталог `default` в `myfolder` и обновит его описание.

      Требования к имени каталога:

      {% include [name-format](../../_includes/name-format.md) %}



- API {#api}

  Чтобы изменить каталог, воспользуйтесь методом [update](../../resource-manager/api-ref/Folder/update.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md).
  
{% endlist %}

## Назначьте роли на каталог {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке слева выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
  1. Перейдите на вкладку [{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}]({{ link-console-iam-users }}).
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив нужного пользователя и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_billing.common.resource-acl.button_assign-binding }}**.
  1. В открывшемся окне нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимую роль из списка.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Посмотрите описание команды для назначения роли на каталог:

      ```
      yc resource-manager folder add-access-binding --help
      ```

  1. Выберите каталог, например `my-folder`:

      ```
      yc resource-manager folder list
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

  1. Выберите [роль](../../iam/concepts/access-control/roles.md):

      ```
      yc iam role list
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```
  1. Узнайте ID пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или группе пользователей, воспользуйтесь [примерами](#examples) ниже.

      ```
      yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```
  1. Назначьте пользователю `test-user` роль `editor` на каталог `my-folder`. В субъекте укажите тип `userAccount` и ID пользователя:

      ```
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API {#api}

  Воспользуйтесь методом [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md). Вам понадобится ID каталога и ID пользователя, которому назначается роль на каталог.

  1. Узнайте ID каталога с помощью метода [list](../../resource-manager/api-ref/Folder/list.md):
      ```bash
      curl \
        --header "Authorization: Bearer <IAM-TOKEN>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs

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
      
  1. Узнайте ID пользователя по логину с помощью метода [getByLogin](../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):
      
      ```bash
      curl \
          --header "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

      {
       "id": "gfei8n54hmfhuk5nogse",
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
          --header "Authorization: Bearer <IAM-TOKEN>" \
          --data '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

{% endlist %}

## Назначьте несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Назначьте пользователю несколько ролей по [инструкции выше](#access-to-user).

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
      
      ```
      yc resource-manager folder list-access-binding my-folder
      ```
      
  1. Например, назначьте роль нескольким пользователям:
      
      ```
      yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API {#api}

  Назначьте одному пользователю роль `editor`, а другому `viewer`:

  ```bash
  curl \
      --request POST \
      --header 'Content-Type: application/json' \
      --header "Authorization: Bearer <IAM-TOKEN>" \
      --data '{
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
      https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md).

  {% note alert %}

  Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  ```bash
  curl \
      --request POST \
      --header 'Content-Type: application/json' \
      --header "Authorization: Bearer <IAM-TOKEN>" \
      --data '{
      "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
      }]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
  ```

{% endlist %}

## Дайте доступ к каталогу для сервисного аккаунта {#access-to-sa}

Вы можете назначить роль не только на каталог, но и на его дочерние ресурсы. Они перечислены в разделе [{#T}](../../iam/concepts/access-control/resources-with-access-control.md).

Разрешите сервисному аккаунту управлять каталогом и ресурсами в нем:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [grant-role-console-sa](../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

  {% include [grant-role-for-sa-to-folder-via-cli](../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- API {#api}

  {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}
