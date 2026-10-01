### Permissions to manage keys in KMS are granted to authorized users {#kms-keys-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.kms-keys-access ||
|#

#### Description

**How this rule works:** The rule automatically scans IAM role assignments across the organization, clouds, and folders, and also checks direct role assignments on KMS keys. It flags all users and service accounts that have any of the listed roles that grant KMS encryption/decryption or management capabilities. The rule requires manual review to confirm that each flagged account legitimately needs the assigned KMS permissions.

To minimize the risk of compromising user account credentials, it is recommended to grant users and service accounts granular permissions for particular keys in Yandex Key Management Service. For more information, see [Access management in Key Management Service](https://yandex.cloud/en/docs/kms/security/).

This rule checks access permissions for KMS keys and returns all the users that are assigned either of the following roles:

* `admin`, `editor`, `kms.admin`, `kms.editor`, or `kms.keys.encrypterDecrypter` for organization, clouds, or folders.
* `kms.keys.encrypterDecrypter` or `kms.editor` for KMS keys.

**Risks if the rule is not followed:** Overly broad KMS permissions mean that a compromised account or service account can decrypt any data protected by KMS keys in the organization, not just the data it legitimately needs to access. This undermines the purpose of encryption at rest — an attacker who gains access to such an account can read all encrypted data without needing to break the encryption itself.

#### Instructions and solutions

It is recommended to follow these principles when granting permissions for KMS keys:

* To access Yandex Key Management Service, you need an [IAM token](https://yandex.cloud/en/docs/iam/concepts/authorization/iam-token).
* To automate operations with KMS, we recommend that you create a [service account](https://yandex.cloud/en/docs/iam/concepts/users/service-accounts) and run commands and scripts under it. If you use VMs, get an IAM token for your service account using the mechanism of [assigning a service account](https://yandex.cloud/en/docs/compute/operations/vm-connect/auth-inside-vm) to your VM. For other ways to get an IAM token for your service account, see the Yandex Identity and Access Management documentation, [Getting an IAM token for a service account](https://yandex.cloud/en/docs/iam/operations/iam-token/create-for-sa).
* We recommend that you grant granular permissions for specific keys in the KMS service to your users and service accounts. For more information, see the KMS documentation, [Access management in Key Management Service](https://yandex.cloud/en/docs/kms/security/).

For more information about security measures for access control, see [Authentication and access control](https://yandex.cloud/en/docs/security/standard/authentication).
