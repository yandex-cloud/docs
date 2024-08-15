# Настройка прав доступа к облаку

Чтобы предоставить пользователю доступ к ресурсам в облаке, назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.


## Назначить роль на облако {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

- CLI {#cli}

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
      | b1gg8sgd16g7******** | my-cloud |
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

  1. Узнайте идентификатор пользователя по логину или адресу электронной почты.

      ```bash
      yc iam user-account get test-user
      ```

      Результат:

      ```bash
      id: gfei8n54hmfh********
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

  1. Назначьте пользователю `test-user` роль `editor` на облако `my-cloud`. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<идентификатор_пользователя>
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры прав доступа к облаку:
      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль.
      * `member` — пользователь или группа, которым нужно назначить роль. Каждый ресурс `yandex_resourcemanager_cloud_iam_member` может иметь одно из следующих значений:
        * `userAccount:<идентификатор_пользователя>` — [идентификатор пользователя](../../../iam/operations/users/get.md).
        * `serviceAccount:<идентификатор_сервисного_аккаунта>` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
        * `federatedUser:<идентификатор_федеративного_аккаунта>` — [идентификатор федеративного аккаунта](../../../organization/operations/users-get.md).
        * `system:group:organization:<идентификатор_организации>:users` — идентификатор [организации](../../../organization/quickstart.md), чтобы назначить роль [системной группе](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`.
        * `system:group:federation:<идентификатор_федерации>:users` — идентификатор [федерации удостоверений](../../../organization/concepts/add-federation.md), чтобы назначить роль [системной группе](../../../iam/concepts/access-control/system-group.md#allFederationUsers) `All users in federation N`.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "userAccount:<идентификатор_пользователя>"
      }
      ```



      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member).
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

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../api-ref/grpc/cloud_service.md#UpdateAccessBindings).

  Вам понадобится идентификатор облака и идентификатор пользователя, которому назначается роль на облако.

  1. Узнайте идентификатор облака с помощью метода REST API [list](../../api-ref/Cloud/list.md):

      ```bash
      curl -H "Authorization: Bearer <IAM-токен>" \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
      ```

      Результат:

      ```bash
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
      curl -H "Authorization: Bearer <IAM-токен>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Результат:

      ```bash
      {
       "id": "gfei8n54hmfh********",
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
          -H "Authorization: Bearer <IAM-токен>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<идентификатор_пользователя>",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
      ```


{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc resource-manager cloud list-access-binding my-cloud
      ```

  1. Например, назначьте роль нескольким пользователям:

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:<идентификатор_первого_пользователя>
        --access-binding role=viewer,subject=userAccount:<идентификатор_второго_пользователя>
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры прав доступа к облаку. Назначьте одному пользователю роль `editor`, а другому `viewer`:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "userAccount:<идентификатор_первого_пользователя>"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "viewer"
        member   = "userAccount:<идентификатор_второго_пользователя>"
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

- API {#api}

  Назначьте одному пользователю роль `editor`, а другому `viewer`:

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "<идентификатор_первого_пользователя>",
                  "type": "userAccount"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "<идентификатор_второго_пользователя>",
                  "type": "userAccount"
      }}}]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызова gRPC API [CloudService/SetAccessBindings](../../api-ref/grpc/cloud_service.md#SetAccessBindings).

  {% note alert %}

  Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}


  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{
      "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "<идентификатор_первого_пользователя>", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "<идентификатор_второго_пользователя>", "type": "userAccount" }
      }]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:setAccessBindings
  ```


{% endlist %}


## Доступ к облаку для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно [назначать](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) роли на любые облака и каталоги в рамках организации, к которой он принадлежит.

Разрешите сервисному аккаунту `test-sa` управлять облаком `my-cloud` и ресурсами в нем:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Роли сервисному аккаунту назначаются так же, как пользовательскому аккаунту.

  Чтобы назначить сервисному аккаунту роль на облако:

  {% include [set-accessbinding-sa-cloud-console](../../../_includes/iam/set-accessbinding-sa-cloud-console.md) %}

- CLI {#cli}

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```bash
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его идентификатор. В типе субъекта укажите `serviceAccount`:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

- {{ TF }} {#tf}

  1. Назначьте роль `editor` сервисному аккаунту:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
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

- API {#api}

  1. Узнайте идентификатор сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl -H "Authorization: Bearer <IAM-токен>" \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Результат:

      ```bash
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

  1. Назначьте сервисному аккаунту `test-sa` роль `editor` на облако `my-cloud`. В свойстве `subject` укажите тип `serviceAccount` и идентификатор `test-sa`. В URL запроса в качестве ресурса укажите идентификатор `my-cloud`:

      ```bash
      curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-токен>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<идентификатор_сервисного_аккаунта>",
                      "type": "serviceAccount"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
      ```

{% endlist %}


## Что дальше {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
