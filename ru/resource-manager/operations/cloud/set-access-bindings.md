# Настройка прав доступа к облаку

Чтобы предоставить пользователю доступ к ресурсам в облаке, назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.


## Назначить роль на облако {#access-to-user}

{% list tabs %}

- Консоль управления

  {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

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
{% if product == "yandex-cloud" %}

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

{% endif %}
{% if product == "cloud-il" %}

  1. [Получите идентификатор пользователя](../../../iam/operations/users/get.md).

{% endif %}
  1. Назначьте пользователю `test-user` роль `editor` на облако `my-cloud`. В субъекте укажите тип {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} и идентификатор пользователя:
{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<идентификатор пользователя>
      ```

{% endif %}
{% if product == "cloud-il" %}

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject federatedUser:<идентификатор пользователя>
      ```

{% endif %}
- API

  Воспользуйтесь методом [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md). Вам понадобится идентификатор облака и идентификатор пользователя, которому назначается роль на облако.

  1. Узнайте идентификатор облака с помощью метода [list](../../api-ref/Cloud/list.md):

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
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
{% if product == "yandex-cloud" %}

  1. Узнайте идентификатор пользователя по логину с помощью метода [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
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

{% endif %}
{% if product == "cloud-il" %}

  1. [Получите идентификатор пользователя](../../../iam/operations/users/get.md).

{% endif %}
  1. Назначьте пользователю роль `editor` на облако `my-cloud`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} и идентификатор пользователя:
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
                      "id": "<идентификатор пользователя>",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
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
                      "id": "<идентификатор пользователя>",
                      "type": "federatedUser"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
      ```

{% endif %}
- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры прав доступа к облаку:
      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_binding` можно назначить только одну роль.
      * блок `members` — список пользователей, которым нужно назначить роль. Каждая запись может иметь одно из следующих значений:
{% if product == "yandex-cloud" %}
        * `userAccount:<идентификатор пользователя>` — [идентификатор пользователя](../../../iam/operations/users/get.md).
{% endif %}
        * `serviceAccount:<идентификатор сервисного аккаунта>` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
        * `federatedUser:<идентификатор федеративного аккаунта>` — [идентификатор федеративного аккаунта](../../../organization/users-get.md).

      Пример структуры конфигурационного файла:

{% if product == "yandex-cloud" %}
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

{% endif %}

{% if product == "cloud-il" %}

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "federatedUser:<идентификатор пользователя>",
        ]
      }
      ```

{% endif %}

      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_cloud_iam_binding).
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- Консоль управления

  {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}
  
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
{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:<идентификатор первого пользователя>
        --access-binding role=viewer,subject=userAccount:<идентификатор второго пользователя>
      ```

{% endif %}
{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=federatedUser:<идентификатор первого пользователя>
        --access-binding role=viewer,subject=federatedUser:<идентификатор второго пользователя>
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
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
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
                  "id": "<идентификатор первого пользователя>",
                  "type": "federatedUser"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "<идентификатор второго пользователя>",
                  "type": "federatedUser"
      }}}]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

{% endif %}
  Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md).

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
          "subject": { "id": "<идентификатор первого пользователя>", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "<идентификатор второго пользователя>", "type": "userAccount" }
      }]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
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
          "subject": { "id": "<идентификатор первого пользователя>", "type": "federatedUser" }
      },{
          "roleId": "viewer",
          "subject": { "id": "<идентификатор второго пользователя>", "type": "federatedUser" }
      }]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
  ```

{% endif %}
- {{ TF }}

  1. Опишите в конфигурационном файле параметры прав доступа к облаку. Назначьте одному пользователю роль `editor`, а другому `viewer`:
{% if product == "yandex-cloud" %}

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

{% endif %}
{% if product == "cloud-il" %}

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "federatedUser:<идентификатор первого пользователя>",
        ]
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "viewer"
        members = [
          "federatedUser:<идентификатор второго пользователя>",
        ]
      }
      ```

{% endif %}
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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}


## Доступ к облаку для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно назначать роли только на облако, которому он принадлежит.

Разрешите сервисному аккаунту `test-sa` управлять облаком `my-cloud` и ресурсами в нем:

{% list tabs %}

- Консоль управления

  Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.

  Чтобы назначить сервисному аккаунту роль на облако:

  {% include [set-accessbinding-sa-cloud-console](../../../_includes/iam/set-accessbinding-sa-cloud-console.md) %}

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
          https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
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
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

- {{ TF }}

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
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

{% endlist %}


## Доступ к ресурсу всем пользователям {#access-to-all}

{% include [set-accessbinding-all-console](../../../_includes/iam/set-accessbinding-all-console.md) %}


## Что дальше {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
