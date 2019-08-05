# Создание сервисного аккаунта

Создайте [сервисный аккаунт](../../concepts/users/service-accounts.md), чтобы управлять ресурсами от имени другой учетной записи.

## Создать сервисный аккаунт

{% list tabs %}

- Консоль управления

  1. Выберите каталог.
  2. Выберите вкладку **Сервисные аккаунты**.
  3. Нажмите кнопку **Создать сервисный аккаунт**.
  4. Введите имя сервисного аккаунта.
  5. Вы можете сразу назначить сервисному аккаунту [роль](../../concepts/access-control/roles.md) на каталог, в котором он будет создан.
      Для этого нажмите **Добавить роль** и выберите роль.

      Чтобы назначить роль на другой ресурс, воспользуйтесь CLI или API по инструкции [{#T}](assign-role-for-sa.md).
  6. Нажмите кнопку **Добавить**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания сервисного аккаунта:

      ```
      $ yc iam service-account create --help
      ```

  2. Создайте сервисный аккаунт с именем `my-robot`:

      ```
      $ yc iam service-account create --name my-robot
      ```

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

{% endlist %}


## Примеры

### Добавить описание при создании

Создайте сервисный аккаунт с именем и описанием:

{% list tabs %}

- CLI

  ```bash
  $ yc iam service-account create --name my-robot \
      --description "this is my favorite service account"
  ```

- API

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
          "folderId": "b1gvmob95yysaplct532",
          "name": "my-robot",
          "description": "this is my favorite service account"
      }' \
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts
  ```

{% endlist %}

#### Что дальше

- [{#T}](assign-role-for-sa.md)
- [{#T}](create-access-key.md)
- [{#T}](set-access-bindings.md)