### Access permissions of users and service accounts are regularly audited using the Yandex Security Deck CIEM {#access-check-bindings}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | access.check-bindings ||
|#

#### Description

{% note warning "**Manual verification**" %}

The rule requires a manual check. Upon completion, please change the rule's status.

{% endnote %}

To ensure data and cloud infrastructure security, you need to regularly audit the access permissions of users and service accounts.

[Cloud Infrastructure Entitlement Management](https://center.yandex.cloud/security/iam-diagnostics/) or CIEM is a tool that provides a centralized view of the full list of access permissions for the organization's [resources](https://yandex.cloud/en/docs/iam/concepts/access-control/resources-with-access-control), granted to [subjects](https://yandex.cloud/en/docs/iam/concepts/access-control/#subject): users, service accounts, [user groups](https://yandex.cloud/en/docs/organization/concepts/groups), [system groups](https://yandex.cloud/en/docs/iam/concepts/access-control/system-group), and [public groups](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group). The tool also makes it easy to revoke excessive access permissions from subjects.

For more information, see [Cloud Infrastructure Entitlement Management (CIEM)](https://yandex.cloud/en/docs/security-deck/concepts/ciem).

#### Recommendations

**Guides and solutions to use:**

Use the [Cloud Infrastructure Entitlement Management](https://yandex.cloud/en/docs/security-deck/concepts/ciem) module to centrally view all access permissions granted to individual [subjects](https://yandex.cloud/en/docs/iam/concepts/access-control/#subject) and groups for organization [resources](https://yandex.cloud/en/docs/iam/concepts/access-control/resources-with-access-control), and to revoke any permissions that are excessive.

For a quick start with the CIEM module, refer to the guides below:

* [Viewing a list of a subject's accesses](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions)
* [Revoking a subject's access](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions)
