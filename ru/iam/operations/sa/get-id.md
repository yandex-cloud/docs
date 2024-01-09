# Получение идентификатора сервисного аккаунта

Если у вас еще нет сервисного аккаунта, [создайте его](create.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. На странице **{{ ui-key.yacloud.iam.folder.service-account.overview.label_title }}** отобразится **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id }}** сервисного аккаунта — строка вида `aje9sb6ffd2u********`.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Если вы знаете имя сервисного аккаунта, получите его идентификатор с помощью команды `get`:

  ```bash
  yc iam service-account get my-robot
  ```
  
  Результат:

  ```
  id: aje6o61dvog2********
  ...
  ```

  Если вы не знаете имя сервисного аккаунта, получите список сервисных аккаунтов в каталоге по умолчанию:

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

- API {#api}

  1. [Узнайте идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором был создан сервисный аккаунт.
  1. Получите информацию о сервисных аккаунтах в каталоге с помощью метода REST API [list](../../api-ref/ServiceAccount/list.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md):

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"

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

     Информацию о сервисных аккаунтах в каталоге можно также получить с помощью вызова gRPC API [ServiceAccountService/List](../../api-ref/grpc/service_account_service.md#List).

{% endlist %}
