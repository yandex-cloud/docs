# Getting an IAM token for a Yandex account

To perform operations in Yandex.Cloud via the API, you need an [IAM token](../../concepts/authorization/iam-token.md).

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get an IAM token:

  ```
  $ yc iam create-token
  ```

- API

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

Save the IAM token to a variable in the CLI and use it in other requests from the command line. Sample request to get cloud list:

{% list tabs %}

- Bash

  ```bash
  $ export IAM_TOKEN=`yc iam create-token`
  $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

- PowerShell

  ```
  $IAM_TOKEN=yc iam create-token
  curl.exe -H "Authorization: Bearer $IAM_TOKEN" https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

{% endlist %}

