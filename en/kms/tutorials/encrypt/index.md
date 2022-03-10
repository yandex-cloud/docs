# Which encryption method should I choose?

The table below compares encryption using {{ yandex-cloud }} tools (CLI, API, and SDK) and other libraries (AWS Encryption SDK and Google Tink). Take a look at the table and choose the most suitable method.

| Feature | [API](cli-api.md) | [CLI](cli-api.md) | [SDK](sdk.md) | [Google Tink](google-tink.md) | [AWS Encryption SDK](aws-encryption-sdk.md) |
| ---- | :---: | :---: | :---: | :---: | :---: |
| Easy authentication | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) |
| Unlimited size of plaintext for encryption | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) |
| Stream encryption | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) |

We recommend encrypting large amounts of data through the AWS Encryption SDK and Google Tink, since they use [envelope encryption](../../concepts/envelope.md).

You can also implement the envelope encryption algorithm yourself using the {{ yandex-cloud }} API or SDK based on cryptographic methods provided by {{ kms-short-name }}.

{% note warning %}

In this case, you should consider all [implementation features of envelope encryption](../../concepts/envelope.md#specify).

{% endnote %}

