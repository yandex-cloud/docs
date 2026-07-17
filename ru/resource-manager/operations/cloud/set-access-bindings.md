# Настройка прав доступа к облаку

{% note warning %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

Чтобы предоставить пользователю доступ к ресурсам в [облаке](../../concepts/resources-hierarchy.md#cloud), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.

## Назначить роль на облако {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для назначения роли на облако:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

  1. Получите список доступных облаков:

      ```bash
      yc resource-manager cloud list
      ```

      Результат:

      ```text
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7******** | my-cloud |
      +----------------------+----------+
      ```

  1. Получите список доступных ролей:

      ```bash
      yc iam role list
      ```

      Результат:

      ```text
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

  1. Назначьте пользователю роль на облако. В субъекте укажите тип `userAccount` и идентификатор пользователя:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<идентификатор_пользователя>
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить, например `{{ roles-cloud-owner }}`.
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
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль>"
        member   = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_resourcemanager_cloud_iam_member` в {{ TF }} читайте в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к облаку.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/UpdateAccessBindings](../../api-ref/grpc/Cloud/updateAccessBindings.md).

  Вам понадобится идентификатор облака и идентификатор пользователя, которому назначается роль на облако.

  1. Узнайте идентификатор облака с помощью метода REST API [list](../../api-ref/Cloud/list.md):

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
      ```

      Результат:

      ```text
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
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Результат:

      ```text
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Назначьте пользователю роль на облако. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` и идентификатор пользователя:

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
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
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

  {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}

- CLI {#cli}

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc resource-manager cloud list-access-bindings <имя_или_идентификатор_облака>
      ```

  1. Чтобы назначить роль, выполните команду:

      ```bash
      yc resource-manager cloud set-access-bindings <имя_или_идентификатор_облака> \
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
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  Чтобы назначить роль не пользователю, а [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), [группе пользователей](../../../organization/concepts/groups.md) или [системной группе](../../../iam/concepts/access-control/system-group.md), воспользуйтесь [примерами](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры прав доступа к облаку.

      Пример структуры конфигурационного файла:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member1" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль_1>"
        member   = "userAccount:<идентификатор_пользователя>"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member2" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<роль_2>"
        member   = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Получить список доступных облаков можно с помощью команды [CLI](../../../cli/quickstart.md): `yc resource-manager cloud list`. Обязательный параметр.
      * `role` — роль, которую нужно назначить. Перечень ролей можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc iam role list`. В одном ресурсе `yandex_resourcemanager_cloud_iam_member` можно назначить только одну роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к облаку.

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
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
  ```

  Где:

  * `roleId` — назначаемая роль.
  * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

  Вы также можете назначать роли с помощью метода REST API [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызова gRPC API [CloudService/SetAccessBindings](../../api-ref/grpc/Cloud/setAccessBindings.md).

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

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

  1. Узнайте идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Назначьте роль сервисному аккаунту, используя его идентификатор:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role <роль> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — идентификатор роли, которую нужно назначить, например `{{ roles-cloud-owner }}`.
      * `--service-account-id` — идентификатор сервисного аккаунта. Также вы можете использовать параметр `--service-account-name` и указать имя сервисного аккаунта вместо идентификатора.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "<идентификатор_облака>"
        role     = "<роль>"
        member   = "serviceAccount:<идентификатор_сервисного_аккаунта>"
      }
      ```

      Где:

      * `cloud_id` — идентификатор облака. Обязательный параметр.
      * `role` — назначаемая роль. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../../iam/roles-reference.md). Обязательный параметр.
      * `member` — обозначение [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль. Для сервисного аккаунта укажите `serviceAccount:<идентификатор_сервисного_аккаунта>`. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого будут назначены права доступа к облаку.

- API {#api}

  1. Узнайте идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM-токен>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=<идентификатор_каталога>
      ```

      Результат:

      ```text
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

  1. Назначьте сервисному аккаунту роль на облако. В свойстве `subject` укажите тип `serviceAccount` и идентификатор сервисного аккаунта. В URL запроса в качестве ресурса укажите идентификатор облака:

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
                  "id": "<идентификатор_сервисного_аккаунта>",
                  "type": "serviceAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<идентификатор_облака>:updateAccessBindings
      ```

      Где:

      * `roleId` — назначаемая роль.
      * `subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

{% endlist %}


## Что дальше {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
