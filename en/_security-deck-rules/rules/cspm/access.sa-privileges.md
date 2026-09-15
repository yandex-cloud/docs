### Service accounts have minimum privileges granted {#sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.sa-privileges ||
|#

#### Description

**How this rule works:** This is a manual check. The rule helps identify service accounts that may have excessive privileges by surfacing them for review. The administrator must audit the roles assigned to each service account and confirm that they are the minimum required for the application to function. The rule does not automatically determine which roles are excessive.

{% note warning "**Manual verification**" %}

This rule helps identify service accounts with excessive privileges that require manual review. After auditing the required privileges, please change the rule status.

{% endnote %}

Follow the principle of least privilege and [assign to the service account](https://yandex.cloud/en/docs/iam/operations/roles/grant) only the roles necessary to run the application.

**Risks if the rule is not followed:** Service accounts with excessive privileges expand the blast radius of any key compromise. If a service account key leaks — for example, into a code repository, container image, or log file — an attacker can use it to perform any action the account is authorized for. Overly broad roles mean that a single leaked key can give access to sensitive data, allow infrastructure modifications, or enable lateral movement across the cloud environment.

#### Instructions and solutions

* Use Yandex Security Deck to [view](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions) the full list of a service account's access permissions.
* Use Security Deck to [revoke](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions) the service account's excessive access permissions.
* [Remove](https://yandex.cloud/en/docs/iam/operations/roles/revoke) the excessive permissions from the service account using IAM.
