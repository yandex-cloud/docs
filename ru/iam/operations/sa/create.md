# Создание сервисного аккаунта

Создайте [сервисный аккаунт](../../concepts/users/service-accounts.md), чтобы управлять ресурсами от имени другой учетной записи.

## Создать сервисный аккаунт {#create-sa}

{% list tabs %}

- Консоль управления

  {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания сервисного аккаунта:

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт с именем `my-robot`:

      ```bash
      yc iam service-account create --name my-robot
      ```

      Требования к формату имени:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

{% endlist %}


## Примеры {#examples}

### Добавить описание при создании {#add-description}

Создайте сервисный аккаунт с именем и описанием:

{% list tabs %}

- CLI

  ```bash
  yc iam service-account create --name my-robot \
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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts
  ```

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](assign-role-for-sa.md).
* [{#T}](create-access-key.md).
* [{#T}](set-access-bindings.md).
