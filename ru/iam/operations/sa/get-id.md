# Получение идентификатора сервисного аккаунта

Если у вас еще нет сервисного аккаунта, [создайте его](create.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. На странице **Обзор** отобразится **Идентификатор** сервисного аккаунта — строка вида `aje9sb6....ffd2uv0i9`.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Если вы знаете имя сервисного аккаунта, получите его идентификатор с помощью команды `get`:

  ```bash
  yc iam service-account get my-robot
  ```
  
  Результат:

  ```
  id: aje6o61dvog2h6g9a33s
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
  | aje6o61dvog2h6g9a33s | my-robot         |                               |
  | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
  +----------------------+------------------+-------------------------------+
  ```

- API

  1. [Узнайте идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором был создан сервисный аккаунт.
  1. Получите информацию о сервисных аккаунтах в каталоге с помощью метода [list](../../api-ref/ServiceAccount/list.md):

      ```bash
      export FOLDER_ID=b1gvmob95yysaplct532
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"

      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "my-robot",
         "description": "my description"
        }
       ]
      }
      ```

{% endlist %}
