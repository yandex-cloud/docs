### The Key Management Service keys are stored in the hardware Security module(HSM) {#keys-hsm}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | crypto.keys-hsm ||
|#

#### Description

{% note warning "**Manual check**" %}

This rule requires manual verification of HSM key storage settings.

{% endnote %}

In production environments, we recommend using separate keys whose every cryptographic operation will only be handled inside a HSM. For more information, see Hardware security module (HSM) <https://yandex.cloud/en/docs/kms/concepts/hsm>.

To use the HSM, when creating a key, select AES-256 HSM as the algorithm type. The HSM will handle all operations with this key internally, and no additional actions are required.

It is recommended to use HSMs for KMS keys to enhance the security level.

#### Guides and solutions

* Set the encryption algorithm for KMS keys to AES-256 HSM: <https://yandex.cloud/en/docs/kms/operations/symmetric-encryption>
