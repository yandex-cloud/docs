# Authentication in the API

{% if audience != "internal" %}

To perform operations via the API, you need to get an [IAM token](../iam/concepts/authorization/iam-token.md):

{% if product == "yandex-cloud" %}
* [Instructions](../iam/operations/iam-token/create.md) for a Yandex account.
{% endif %}
* [Instructions](../iam/operations/iam-token/create-for-sa.md) for a service account.
* [Instructions](../iam/operations/iam-token/create-for-federation.md) for a federated account.

{% include [iam-token-usage](iam-token-usage.md) %}

#### See also {#see-also}

[Accounts in {{ yandex-cloud }}](../iam/concepts/index.md#accounts).

{% else %}

To perform operations via the API, you need to get an IAM token.

{% include [create-iam-token-for-robot](iam/create-iam-token-for-robot.md) %}

{% endif %}
