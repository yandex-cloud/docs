When the Identity Provider (IdP) informs Yandex.Cloud that a user passed authentication, they sign the message with their certificate. To enable Yandex.Cloud to verify this certificate, add it to the federation in {{ iam-short-name }}.

{% note tip %}

To ensure that authentication isn't interrupted when the certificate expires, we recommend adding several certificates to the federation: the current one and the ones that will be used after. If a certificate is invalid, Yandex.Cloud tries to verify the signature with a different one.

{% endnote %}

