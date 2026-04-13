### Only trusted administrators have access to service accounts {#access-privileged-sa-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | access.privileged-sa-access ||
|#

#### Description

{% note info %}

This rule automatically identifies accounts that have access rights assigned for service accounts.

{% endnote %}

You can grant a user or another service account permission to use a service account.

Follow the principle of least privilege when granting access for a service account as a resource. A user with permission to use a service account also inherits all permissions assigned to that service account. [Assign](https://yandex.cloud/en/docs/iam/operations/sa/set-access-bindings) roles that allow the use and management of service accounts only to a minimal number of trusted users.

Each service account with extended permissions should be placed as a resource in a separate folder. This helps prevent accidentally granting permissions for a service account along with the permissions for the folder with the respective service component.

#### Recommendations

**Guides and solutions to use:**

Validate the access rights assigned for service accounts. The recommendation is considered satisfied if the list contains only trusted administrators. Otherwise, follow this [guide](https://yandex.cloud/en/docs/iam/operations/roles/revoke) to revoke any excessive permissions using the Identity and Access Management service.

To manage access centrally, use the [CIEM module](https://center.yandex.cloud/security/iam-diagnostics/). Refer to the guides below for instructions:

* [Viewing a list of a subject's accesses](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions)
* [Revoking a subject's access](https://yandex.cloud/en/docs/security-deck/operations/ciem/revoke-permissions)
