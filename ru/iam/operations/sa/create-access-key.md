# Создать статические ключи доступа

Создайте [статические ключи доступа](../../concepts/users/service-accounts.md#access-keys) для сервисного аккаунта.

---

**[!TAB Консоль управления]**

1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
1. Выберите вкладку **Сервисные аккаунты**.
1. Выберите сервисный аккаунт и нажмите на строку с его именем.
1. Нажмите кнопку **Создать ключ доступа** на верхней панели.
1. Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды создания статического ключа доступа:

    ```
    $ yc iam access-key create --help
    ```

1. Выберите сервисный аккаунт, например `my-robot`:

    ```
    $ yc iam service-account list
    +----------------------+------------------+-------------------------------+
    |          ID          |       NAME       |          DESCRIPTION          |
    +----------------------+------------------+-------------------------------+
    | aje6o61dvog2h6g9a33s | my-robot         |                               |
    | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
    +----------------------+------------------+-------------------------------+
    ```
1. Создайте ключ доступа для сервисного аккаунта `my-robot`:

    ```
    $ yc iam access-key create --service-account-name my-robot

    access_key:
      id: aje6t3vsbj8lp9r4vk2u
      service_account_id: ajepg0mjt06siuj65usm
      created_at: "2018-11-22T14:37:51Z"
      key_id: 0n8X6WY6S24N7OjXQ0YQ
    secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
    ```
1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

**[!TAB API]**

Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../api-ref/AccessKey/create.md) для ресурса [ServiceAccount](../../api-ref/AccessKey/index.md).

---

## Примеры

### Добавить описание при создании

Добавьте описание при создании ключа доступа.

---

**[!TAB CLI]**

```
$ yc iam access-key create --service-account-name my-robot \
    --description "this key is for my bucket"
```

**[!TAB API]**

```bash
$ curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
        "serviceAccountId": "aje6o61dvog2h6g9a33s",
        "description": "this key is for my bucket"
    }' \
    https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys
```

---

#### Что дальше

- [Настроить инструменты для работы с [!KEYREF objstorage-name]](../../../storage/instruments/)
- [[!TITLE]](assign-role-for-sa.md)