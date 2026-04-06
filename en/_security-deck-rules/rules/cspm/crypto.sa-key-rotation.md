### Service account keys are rotated on a regular basis {#sa-key-rotation}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.sa-key-rotation ||
|#

#### Description

Yandex Cloud allows you to create the following access keys for service accounts:

* [IAM tokens](https://yandex.cloud/en/docs/iam/concepts/authorization/iam-token) that are valid for 12 hours.
* [API keys](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key): You can choose any validity period.
* [Authorized keys](https://yandex.cloud/en/docs/iam/concepts/authorization/key) with unlimited validity.
* [AWS API-compatible static access keys](https://yandex.cloud/en/docs/iam/concepts/authorization/access-key) with unlimited validity.

It is recommended to rotate keys with unlimited validity yourself: delete and generate new ones. You can check out the date when a key was created in its properties. Perform key rotation at least once in 90 days.

This control checks the last update date. In cases where it is impossible to determine the last update date (for example, when starting {{ cspm-name }} for the first time), it is recommended that the control is performed manually.

#### Guides and solutions

Follow the [guide](https://yandex.cloud/en/docs/iam/operations/compromised-credentials#key-reissue) for rotating keys depending on their type.
