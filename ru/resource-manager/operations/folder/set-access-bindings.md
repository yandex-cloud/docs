# Настройка прав доступа к каталогу

{% note warning %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

Чтобы предоставить пользователю доступ к ресурсам в [каталоге](../../concepts/resources-hierarchy.md#folder), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на этот каталог.

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

## Назначить роль на каталог {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для назначения роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Получите список доступных каталогов:

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

  1. Получите список доступных ролей:

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

  1. Назначьте пользователю роль на каталог. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfh********
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить.
      * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
      * `role` — роль, которую нужно назначить. В одном ресурсе `yandex_resourcemanager_folder_iam_member` можно назначить только одну роль.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_resourcemanager_folder_iam_member` в {{ TF }} читайте в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к каталогу.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../api-ref/grpc/Folder/updateAccessBindings.md). Вам понадобится идентификатор каталога и идентификатор пользователя, которому назначается роль на каталог.

  1. Узнайте идентификатор каталога с помощью метода REST API [list](../../api-ref/Folder/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=<идентификатор_облака>
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

  1. Узнайте идентификатор пользователя по логину с помощью метода REST API [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):

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

  1. Назначьте пользователю роль на каталог. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` и идентификатор пользователя:

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
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings
      ```

      Где:

      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

{% endlist %}


## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc resource-manager folder list-access-bindings <имя_или_идентификатор_каталога>
      ```

  1. Чтобы назначить роль, выполните команду:

      ```bash
      yc resource-manager folder set-access-bindings <имя_или_идентификатор_каталога> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `role` — идентификатор роли, которую нужно назначить.
      * `subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Для каждой роли передайте отдельный параметр `--access-binding`. Например:

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры прав доступа к каталогу.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member1" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<роль_1>"
        member    = "userAccount:<идентификатор_пользователя>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member2" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<роль_2>"
        member    = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md), на который назначаются права. Обязательный параметр.
      * `role` — роль, которую нужно назначить. В одном ресурсе `yandex_resourcemanager_folder_iam_member` можно назначить только одну роль.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к каталогу.

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
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings
  ```

  Где:

  * `roleId` — назначаемая роль.
  * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызова gRPC API [FolderService/SetAccessBindings](../../api-ref/grpc/Folder/setAccessBindings.md).

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

{% endlist %}


## Доступ к каталогу для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно [назначать](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) роли на любые облака и каталоги в рамках организации, к которой он принадлежит.

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Назначьте роль `editor` сервисному аккаунту:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "serviceAccount:<идентификатор_сервисного_аккаунта>"
      }
      ```

      Где:

      * `folder_id` — [идентификатор каталога](get-id.md).
      * `role` — роль, которую нужно назначить.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Для сервисного аккаунта укажите `serviceAccount:<идентификатор_сервисного_аккаунта>`.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к каталогу.

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
  1. [Получите идентификатор пользователя](../../../organization/operations/users-get.md).
  1. Назначьте роль с помощью команды:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
          --role <идентификатор_роли> \
          --subject federatedUser:<идентификатор_пользователя>
      ```

      Где:

      * `<имя_или_идентификатор_каталога>` — имя или идентификатор каталога.
      * `--role` — идентификатор роли, например `editor`.
      * `--subject` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

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
