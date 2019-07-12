# API key

_The API key_ is a private key used for simplified authorization in the Yandex.Cloud API. API keys are only used for [service accounts](../users/service-accounts.md).

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

If someone might have gotten access to your private key, [delete it](../../operations/api-key/delete.md) and [create a new one](../../operations/api-key/create.md).

{% endnote %}

## Services that support this authentication method {#supported-services}

For information about how to use an API key for authentication, read the documentation on the services that support this authorization method:

* [SpeechKit](../../../speechkit/concepts/auth.md)
* [Translate](../../../translate/concepts/auth.md)
* [Vision](../../../vision/api-ref/authentication.md)

#### See also

* [How to create an API key](../../operations/api-key/create.md)
* [#T](iam-token.md)
* [#T](index.md)

