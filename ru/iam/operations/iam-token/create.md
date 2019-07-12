# Получение IAM-токена для своей учетной записи

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md).

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите IAM-токен:

  ```
  $ yc iam create-token
  ```

- API

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры

Запишите IAM-токен в переменную с помощью CLI и используйте токен в других запросах из командной строки. Пример запроса на получение списка облаков:

{% list tabs %}

- Bash

  ```bash
  $ export IAM_TOKEN=`yc iam create-token`
  $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

- Powershell

  ```
  $IAM_TOKEN=yc iam create-token
  curl.exe -H "Authorization: Bearer $IAM_TOKEN" https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

{% endlist %}
