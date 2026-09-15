### There is no public access to your organization's resources {#public-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.public-access ||
|#

#### Description

**How this rule works:** This is a manual check. The rule checks if there is a public access granted to `All authenticated users` and `All users` within an organization, cloud or folder.

In Yandex Cloud you can grant public access to a resource by assigning a role to one of the system [public groups](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group):

* `All authenticated users` — all authenticated users. This includes every Yandex Cloud user and service account, both from your clouds and from other users' clouds.
* `All users` — any user, no authentication required.

Public access is a frequent cause of data leaks and unauthorized changes, because it opens a resource to a much wider audience than usually intended. It should stay only on resources that are deliberately made public — for example, a static website served from an Object Storage bucket.

{% note alert "**Warning**" %}

`All users` currently works only in Object Storage (with ACL-based access management), Container Registry, and Cloud Functions. In other services, granting a role to `All users` is equivalent to granting it to `All authenticated users`.

{% endnote %}

**Risks if the rule is not followed:** Granting public access to resources exposes them to all internet users or all Yandex Cloud users, leading to potential data leaks, unauthorized modifications, and compliance violations — especially if the resource contains sensitive or personal data.

#### Instructions and solutions

Find all roles granted to `All users` and `All authenticated users` — the full list is available in the [CIEM module](https://yandex.cloud/en/docs/security-deck/concepts/ciem) of Security Deck.

For each resource where such a role is granted:

* If the resource should not be public, remove the role.
* If the resource should be public, make sure that this is intentional.
* Check higher levels first — organization, cloud, and folder — and only then the resource itself: roles granted on higher levels are inherited by everything below.
