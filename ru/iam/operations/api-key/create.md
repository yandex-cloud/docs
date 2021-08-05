---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Создание API-ключа

Это инструкция по созданию [API-ключа](../../concepts/authorization/api-key.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md). _API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API {{ yandex-cloud }}.

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

Чтобы создать API-ключ:

{% list tabs %}

- Консоль управления

  1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Выберите вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать API-ключ**.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Сохраните идентификатор и секретный ключ.
      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

- API

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

{% endlist %}

## Примеры {#examples}

### Добавить описание при создании {#add-description}

Чтобы было проще найти API-ключ не зная его идентификатора, добавьте описание при создании:

{% list tabs %}

- CLI

  ```bash
  $ yc iam api-key create --service-account-name my-robot \
      --description "this API-key is for my-robot"
  ```

- API

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

{% endlist %}

#### Что дальше {#what-is-next}

- [Узнайте, какие сервисы поддерживают API-ключи](../../concepts/authorization/api-key.md#supported-services)