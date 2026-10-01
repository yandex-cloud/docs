### Service accounts have minimum privileges granted on the service level {#sa-privileges-service-roles}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.sa-privileges-service-roles ||
|#

#### Description

**How this rule works:** The rule automatically scans IAM role assignments across the organization and identifies service accounts that have been granted any of the listed service-level admin roles (`compute.admin`, `storage.admin`, `iam.serviceAccounts.admin`, `vpc.admin`, `k8s.admin`, `lockbox.admin`, `kms.admin`). It flags these service accounts regardless of whether the roles are actively used.

Follow the principle of least privilege and [assign to the service account](https://yandex.cloud/en/docs/iam/operations/roles/grant) only the roles necessary for the service to run.

This rule detects service accounts with the following roles within the service:

* `compute.admin`
* `storage.admin`
* `iam.serviceAccounts.admin`
* `vpc.admin`
* `k8s.admin`
* `lockbox.admin`
* `kms.admin`

**Risks if the rule is not followed:** Service accounts with admin-level roles on critical services can perform any operation within those services. A compromised service account key gives an attacker the ability to read all secrets from Lockbox, decrypt data with KMS keys, modify network configurations, or take over Kubernetes clusters — depending on which admin roles are assigned. Limiting service accounts to the minimum required roles reduces the impact of any key compromise.

#### Instructions and solutions

* Use Security Deck to [revoke](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions) the service account's excessive access permissions.
* [Revoke](https://yandex.cloud/en/docs/iam/operations/roles/revoke) the excessive permissions from the service account using IAM.
