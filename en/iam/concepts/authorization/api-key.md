# API key


The _API key_ is a secret key used for simplified authorization in the {{ yandex-cloud }} API. API keys are only used for [service account](../users/service-accounts.md) authorization.

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

If someone might have gotten access to your private key, [delete it](../../operations/api-key/delete.md) and [create a new one](../../operations/api-key/create.md).

{% endnote %}

Storing the API key is your responsibility. {{ yandex-cloud }} only provides access to an API key while it is being created. If the key is lost or damaged, you cannot restore it. In this case, you can [reissue](../../operations/compromised-credentials.md#api-key-reissue) the key or create a new one.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API keys with a limited scope and validity period {#scoped-api-keys}

You can create API keys with a limited scope and validity period. This will reduce the risk of their unauthorized use.

You can create such keys to manage {{ ydb-full-name }} tables and topics (`yc.ydb.tables.manage` and `yc.ydb.topics.manage`).

## Using an API key {#use}

Enter the API key when accessing {{ yandex-cloud }} resources via the API. Provide the API key in the `Authorization` header in the following format:

```
Authorization: Api-Key <API_key>
```

## Services that support this authentication method {#supported-services}

The following services support authentication based on API keys:

* [{{ sf-full-name }}](../../../functions/operations/function/auth.md)
* [{{ ml-platform-full-name }}](../../../datasphere/api-ref/authentication.md)
* [{{ search-api-full-name }}](../../../search-api/operations/auth.md)
* [{{ speechkit-full-name }}](../../../{{ speechkit-slug }}/concepts/auth.md)
* [{{ speechsense-full-name }}](../../../speechsense/api-ref/authentication.md)
* [{{ translate-full-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-full-name }}](../../../vision/api-ref/authentication.md)


#### See also {#see-also}

* [{#T}](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)