### There is no public access to your organization's resources {#public-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.public-access ||
|#

#### Description

This rule checks if there is a public access granted to `All authenticated users` and `All users` within an organization, cloud or folder.

Yandex Cloud allows you to grant public access to your resources. You can grant public access by assigning access permissions to [public groups](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group) (`All authenticated users`, `All users`).

Public group details:

* `All authenticated users`: All authenticated users. This means all registered Yandex Cloud users or service accounts, both from your clouds and other users' clouds.

* `All users`: Any user. No authentication is required.

{% note alert "**Warning**" %}

Now `All users` is only supported in the following services: Object Storage (if ACL-based access management is used), Container Registry, and Cloud Functions. For other services, assigning a role to the `All users` group is equivalent to assigning a role to `All authenticated users`.

{% endnote %}

Make sure that these groups have no public access to your resources: clouds, folders, buckets, and more.

#### Instructions and solutions

If you detect that `All users` and `All authenticated users` have the access permissions that they should not have, remove these permissions [using CIEM module](https://yandex.cloud/en/docs/security-deck/concepts/ciem).
