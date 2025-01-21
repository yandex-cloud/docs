Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../foundation-models/security/index.md#languageModels-user) `ai.editor`.
  1. [Получите](../../iam/operations/api-key/create.md) и сохраните API-ключ сервисного аккаунта.

      {% include [sdk-auth-details-paragraph](./sdk-auth-details-paragraph.md) %}
  1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите бета-версию [библиотеки {{ ml-sdk-name }}](../../foundation-models/sdk/index.md):

      ```bash
      pip install yandex-cloud-ml-sdk --upgrade --pre
      ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](./yandexgpt/ai-before-beginning.md) %}
  1. Установите [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. {% include [curl](../curl.md) %}
  1. (Опционально) Установите [утилиту jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов.
  1. [Получите IAM-токен](../../iam/operations/iam-token/create.md) для аутентификации в API.
  
     {% note info %}

     У IAM-токена короткое [время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) — не более  {{ iam-token-lifetime }}.

     {% endnote %}
   
{% endlist %}