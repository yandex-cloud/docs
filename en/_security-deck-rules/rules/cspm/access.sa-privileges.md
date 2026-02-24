### Service accounts have minimum privileges granted {#sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.sa-privileges ||
|#

#### Description

{% note warning "**Manual verification**" %}

This rule requires manual check. After auditing the required privileges, please change the rule status.

{% endnote %}

Follow the principle of least privilege and [assign to the service account](https://yandex.cloud/en/docs/iam/operations/roles/grant) only the roles necessary to run the application.

#### Guides and solutions

**Guides and solutions to use:**

* Use Yandex Security Deck to [view](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions) the full list of a service account's access permissions.
* Use Security Deck to [revoke](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions) the service account's excessive access permissions.
* [Remove](https://yandex.cloud/en/docs/iam/operations/roles/revoke) the excessive permissions from the service account using IAM.