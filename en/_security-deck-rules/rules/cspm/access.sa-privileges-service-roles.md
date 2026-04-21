### Service accounts have minimum privileges granted on the service level {#sa-privileges-service-roles}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.sa-privileges-service-roles ||
|#

#### Description

Follow the principle of least privilege and [assign to the service account](https://yandex.cloud/en/docs/iam/operations/roles/grant) only the roles necessary for the service to run.

This rule detects service accounts with the following roles within the service:

* `compute.admin`
* `storage.admin`
* `iam.serviceAccounts.admin`
* `vpc.admin`
* `k8s.admin`
* `lockbox.admin`
* `kms.admin`

#### Guides and solutions to use

**Guides and solutions to use:**

* Use Security Deck to [revoke](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions) the service account's excessive access permissions.
* [Revoke](https://yandex.cloud/en/docs/iam/operations/roles/revoke) the excessive permissions from the service account using IAM.
