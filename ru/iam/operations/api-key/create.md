# Создать API-ключ

Это инструкция по созданию [API-ключей](../../concepts/users/service-accounts.md#access-keys) для [сервисного аккаунта](../../concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [настройте права доступа](../sa/assign-role-for-sa.md) для него.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды создания API-ключа:

    ```
    $ yc iam api-key create --help
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
1. Создайте API-ключ для сервисного аккаунта `my-robot` и запишите ответ в файл:

    ```
    $ yc iam api-key create --service-account-name my-robot > api-key.yaml
    ```

    В ответе в свойстве `secret` будет содержаться API-ключ:

    ```
    api_key:
      id: ajeke74kbp5bfq7m6ka2
      service_account_id: ajepg0mjt06siuj65usm
      created_at: "2019-04-09T08:41:27Z"
    secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
    ```

    О том, как передать ключ в запросе, читайте в документации [сервисов](../../concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ авторизации.

**[!TAB API]**

1. [Узнайте идентификатор сервисного аккаунта](../sa/get-id.md).
2. Создайте API-ключ с помощью метода [create](../../api-ref/ApiKey/create.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

    ```bash
    $ export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $IAM_TOKEN" \
        -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
        https://iam.api.cloud.yandex.net/iam/v1/apiKeys
    ```

---

## Примеры

### Добавить описание при создании

Чтобы было проще найти API-ключ не зная его идентификатора, добавьте описание при создании:

---

**[!TAB CLI]**

```bash
$ yc iam api-key create --service-account-name my-robot \
    --description "this API-key is for my-robot"
```

**[!TAB API]**

```bash
$ export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"description\": \"this API-key is for my-robot\"
    }" \
    https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```

---

#### Что дальше

- [Узнайте, какие сервисы поддерживают API-ключи](../../concepts/authorization/api-key.md#supported-services)