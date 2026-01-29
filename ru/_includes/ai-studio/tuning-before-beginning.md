Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- Консоль управления {#console}

  Для работы из консоли управления подготовительные действия не требуются.

- SDK {#sdk}

  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../ai-studio/security/index.md#ai-editor) `ai.editor`.
  1. [Получите](../../iam/operations/authentication/manage-api-keys.md#create-api-key) и сохраните API-ключ сервисного аккаунта с заданной [областью действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.ai.foundationModels.execute`.

      {% include [sdk-auth-details-paragraph](./sdk-auth-details-paragraph.md) %}
  1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите [библиотеку {{ ml-sdk-name }}](../../ai-studio/sdk/index.md):

      ```bash
      pip install yandex-ai-studio-sdk
      ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](./yandexgpt/ai-before-beginning.md) %}
  1. {% include [curl](../curl.md) %}
  1. Установите [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. (Опционально) Установите [утилиту jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов.
  1. [Получите IAM-токен](../../iam/operations/iam-token/create.md) для аутентификации в API.
  
      [Аккаунту](../../iam/concepts/users/accounts.md), для которого вы получаете [IAM-токен](../../iam/concepts/authorization/iam-token.md), должна быть назначена [роль](../../ai-studio/security/index.md#ai-editor) `ai.editor` или выше.
  
      {% note info %}

      У IAM-токена короткое [время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) — не более {{ iam-token-lifetime }}.

      {% endnote %}
   
{% endlist %}