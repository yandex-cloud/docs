### Service accounts have minimum privileges granted on the organization level {#sa-privileges-org-roles}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.sa-privileges-org-roles ||
|#

#### Description

**How this rule works:** The rule automatically scans IAM role assignments at the organization level and identifies service accounts that have been granted `admin`, `editor`, or `resource-manager.clouds.owner` roles. It flags these service accounts regardless of whether the roles are actively used. The rule does not verify whether the assignment is justified by a specific use case.

Follow the principle of least privilege and [assign to the service account](https://yandex.cloud/en/docs/iam/operations/roles/grant) only the roles necessary for the organization to run.

This rule detects service accounts with the following roles within the organization:

* `admin`
* `editor`
* `resource-manager.clouds.owner`

**Risks if the rule is not followed:** A service account with organization-level `admin` or `editor` roles has the ability to modify access policies, create and delete resources, and manage other service accounts across the entire organization. If the service account's key is compromised — for example, leaked in a repository or log file — an attacker gains organization-wide administrative access, which can lead to a complete takeover of the cloud environment.

#### Instructions and solutions

* Use Security Deck to [revoke](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions) the service account's excessive access permissions.
* [Revoke](https://yandex.cloud/en/docs/iam/operations/roles/revoke) the excessive permissions from the service account using IAM.
