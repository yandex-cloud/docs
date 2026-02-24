### Data encryption at the application level is used {#application-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | crypto.data.application-encryption ||
|#

#### Description

{% note warning "**Manual check**" %}

If client-side encryption is implemented, mark the rule as completed.

{% endnote %}

For client-side encryption before uploading data to a Yandex Object Storage bucket, you can use the following approaches:

* Integrating Object Storage with the Key Management Service service for client-side encryption. For more information, see "Recommended cryptographic libraries".

* Using third-party client-side encryption libraries prior to sending data to Object Storage. If you use third-party data encryption libraries and your own key management methods, make sure your operation scheme, algorithms, and key lenghts comply with regulatory requirements.

#### Guides and solutions

For client-side encryption, we recommend that you use the following libraries:

* AWS Encryption SDK and its KMS integration: <https://yandex.cloud/en/docs/kms/tutorials/encrypt/aws-encryption-sdk>
* Google Tink and its KMS integration: <https://yandex.cloud/en/docs/kms/tutorials/encrypt/google-tink>
* Yandex Cloud SDK with any other cryptographic library compatible with PCI DSS or any standards used in your company: <https://yandex.cloud/en/docs/kms/tutorials/encrypt/sdk>

For a comparison of libraries, see the KMS documentation, Which encryption method should I choose?: <https://yandex.cloud/en/docs/kms/tutorials/encrypt>