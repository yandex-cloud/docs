# API key

_The API key_ is a private key used for simplified authorization in the Yandex.Cloud API. API keys are only used for [service accounts](../users/service-accounts.md).

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

If someone might have gotten access to your private key, [delete it](../../operations/api-key/delete.md) and [create a new one](../../operations/api-key/create.md).

{% endnote %}

## Using the token {#use}

Enter the API key when accessing Yandex.Cloud resources via the API. Pass the API key in the `Authorization` header in the following format:

```
Authorization: Api-Key <API key>
```

## Services that support this authentication method {#supported-services}

* [{{ speechkit-name }}](../../../speechkit/concepts/auth.md)
* [{{ translate-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-name }}](../../../vision/api-ref/authentication.md)

#### See also {#see-also}

* [How to create an API key](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)

