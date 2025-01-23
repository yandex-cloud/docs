# Which encryption method should I choose?

The table below compares encryption using {{ yandex-cloud }} (CLI, API, and SDK) and other libraries (AWS Encryption SDK, Google Tink). Take a look at the table and choose the most suitable method.

Feature | [API](../../../kms/tutorials/encrypt/cli-api.md) | [CLI](../../../kms/tutorials/encrypt/cli-api.md) | [SDK](../../../kms/tutorials/encrypt/sdk.md) |  [Google Tink](../../../kms/tutorials/encrypt/google-tink.md) | [AWS Encryption SDK](../../../kms/tutorials/encrypt/aws-encryption-sdk.md) |
----|:---:|:---:|:---:|:---:|:---:|
Easy authentication| ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) |
Unlimited size of plaintext for encryption | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)|
Stream encryption| ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) |

We recommend encrypting large amounts of data through the AWS Encryption SDK and Google Tink because they use [envelope encryption](../../../kms/concepts/envelope.md).

You can also implement the envelope encryption algorithm yourself using the API or SDK  {{ yandex-cloud }} based on cryptographic methods provided by {{ kms-full-name }}.

{% note warning %}

In this case, you should consider all [implementation features of envelope encryption](../../../kms/concepts/envelope.md#specify).

{% endnote %}
