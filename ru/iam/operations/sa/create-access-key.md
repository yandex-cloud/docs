# Создание статических ключей доступа

Это инструкция по созданию  [статических ключей доступа](../../concepts/authorization/access-key.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md).

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

Чтобы создать статический ключ доступа:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания статического ключа доступа:

      ```bash
      yc iam access-key create --help
      ```

  1. Выберите сервисный аккаунт, например `my-robot`:

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
  1. Создайте ключ доступа для сервисного аккаунта `my-robot`:

      ```bash
      yc iam access-key create --service-account-name my-robot
      ```

      Результат:

      ```
      access_key:
        id: aje6t3vsbj8lp9r4vk2u
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2018-11-22T14:37:51Z"
        key_id: 0n8X6WY6S24N7OjXQ0YQ
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
      ```

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../api-ref/AccessKey/create.md) для ресурса [AccessKey](../../api-ref/AccessKey/index.md).

{% endlist %}

## Примеры {#examples}

### Добавить описание при создании {#add-description}

Добавьте описание при создании ключа доступа.

{% list tabs %}

- CLI

  ```bash
  yc iam access-key create --service-account-name my-robot \
    --description "this key is for my bucket"
  ```

- API

  ```bash
  curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
        "serviceAccountId": "aje6o61dvog2h6g9a33s",
        "description": "this key is for my bucket"
    }' \
    https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
  ```

{% endlist %}

#### Что дальше {#what-is-next}

* [Настроить инструменты для работы с {{ objstorage-name }}](../../../storage/tools/).
* [{#T}](assign-role-for-sa.md).
