### Service roles are used instead of primitive roles: admin, editor, viewer {#min-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.min-privileges ||
|#

#### Description

{% note warning "**Manual verification**" %}

This rule requires manual check. After checking the necessity for the privileges, please change the rule status.

{% endnote %}

The [principle of least privilege](https://yandex.cloud/en/docs/iam/best-practices/using-iam-securely#restrict-access) requires assigning users the minimum required roles. We do not recommend using primitive roles, such as `admin`, `editor`, and `viewer` that are valid for all services, because this contradicts the principle of least privilege. To ensure more selective access control and implementation of the principle of least privilege, use service roles that only contain permissions for a certain type of resources in a given service. You can see the list of all service roles in the [Yandex Cloud role reference](https://yandex.cloud/en/docs/iam/roles-reference).

Use the [auditor](https://yandex.cloud/en/docs/iam/roles-reference#auditor) role without data access wherever possible.

#### Instructions and solutions

Analyze the accounts found with the `admin`, `editor`, and `viewer` primitive roles assigned and replace them with [service granular roles](https://yandex.cloud/en/docs/iam/roles-reference) based on your role matrix.

Follow [this guide](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions) to view the full list of a subject's access permissions.
