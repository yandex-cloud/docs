# Получение информации о сервисном аккаунте

Вы можете получить информацию о сервисном аккаунте: его имя и идентификатор, даты создания и последней аутентификации, а также роли сервисного аккаунта в каталоге.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите нужный сервисный аккаунт.
  1. На странице **{{ ui-key.yacloud.iam.folder.service-account.overview.label_title }}** отобразятся параметры сервисного аккаунта:

     * **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id }}** сервисного аккаунта — строка вида `aje9sb6ffd2u********`.
     * **{{ ui-key.yacloud.iam.folder.service-accounts.column_name }}**.
     * **{{ ui-key.yacloud.iam.folder.service-accounts.column_date }}**.
     * **{{ ui-key.yacloud.iam.folder.service-accounts.column_last-auth }}**.
     * **{{ ui-key.yacloud.iam.folder.service-accounts.column_roles }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Получите список сервисных аккаунтов в каталоге по умолчанию:

  ```bash
  yc iam service-account list
  ```

  Результат:

  ```
  +----------------------+------------------+-------------------------------+
  |          ID          |       NAME       |          DESCRIPTION          |
  +----------------------+------------------+-------------------------------+
  | aje6o61dvog2******** | my-robot         |                               |
  | aje9sda1ufvq******** | account_name     | account_description           |
  +----------------------+------------------+-------------------------------+
  ```

  Получите информацию о нужном сервисном аккаунте с помощью команды `get`:

  ```bash
  yc iam service-account get <идентификатор_сервисного_аккаунта>
  ```
  
  Результат:

  ```
  id: aje6o61dvog2********
  folder_id: jbmsjns93hj8********
  created_at: "2024-09-09T20:15:19Z"
  name: service-account
  last_authenticated_at: "2024-09-19T18:05:06Z"
  ```

  Где:

  * `id` — идентификатор сервисного аккаунта.
  * `folder_id` — идентификатор каталога.
  * `created_at` — дата и время создания сервисного аккаунта.
  * `name: service-account` — имя сервисного аккаунта.
  * `last_authenticated_at` — дата и время последней аутентификации.

- API {#api}

  1. [Узнайте идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором был создан сервисный аккаунт.
  1. Получите информацию о сервисных аккаунтах в каталоге с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md):

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```

      Результат:

      ```text
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "my-robot",
         "description": "my description"
        }
       ]
      }
      ```

     Информацию о сервисных аккаунтах в каталоге можно также получить с помощью вызова gRPC API [ServiceAccountService/List](../../api-ref/grpc/ServiceAccount/list.md).

{% endlist %}
