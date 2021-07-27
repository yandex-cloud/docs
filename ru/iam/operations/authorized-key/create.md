---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создание авторизованных ключей

Чтобы создать [авторизованные ключи](../../concepts/authorization/key.md):

{% list tabs %}

- Консоль управления

  1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Выберите вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать авторизованный ключ**.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в {{ yandex-cloud }}, открытый ключ нельзя будет посмотреть в консоли управления.

- CLI

  Создайте авторизованные ключи для сервисного аккаунта `my-robot`:

  ```
  $  yc iam key create --service-account-name my-robot -o my-robot-key.json
  ```

  В случае успеха в файл `my-robot-key.json` будет записан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`).

  Пример файла с ключом:

  ```json
  {
     "id": "lfkoe35hsk58aks301nl",
     "service_account_id": "ajepg0mjt06siua65usm",
     "created_at": "2019-03-20T10:04:56Z",
     "key_algorithm": "RSA_2048",
     "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
     "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

- API

  Чтобы создать ключ доступа, воспользуйтесь методом [create](../../api-ref/Key/create.md) для ресурса [Key](../../api-ref/Key/index.md).

  Пример запроса с помощью cURL:

  ```
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{"serviceAccountId": "<SERVICE-ACCOUNT-ID>"}' \
      https://iam.api.cloud.yandex.net/iam/v1/keys
  ```

  где:
  * `<IAM-TOKEN>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
  * `<SERVICE-ACCOUNT-ID>` — `ID` сервисного аккаунта, для которого создаются ключи.

  В случае успеха в ответе сервера будет указан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`). Сохраните эти данные. Получить значение ключа снова будет невозможно.

  Пример ответа сервера:

  ```json
  {
      "key": {
          "createdAt": "2018-10-30T15:55:00+00:00",
          "description": "",
          "id": "lfkoe35hsk58aks301nl",
          "keyAlgorithm": "RSA_2048",
          "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
          "serviceAccountId": "ajepg0mjt06siua65usm"
      },
      "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

{% endlist %}

#### Что дальше {#what-is-next}

* [Получите IAM-токен для сервисного аккаунта](../iam-token/create-for-sa.md)