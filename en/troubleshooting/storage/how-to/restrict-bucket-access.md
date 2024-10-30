# How to restrict access to a bucket for a user


## Scenario description {#case-description}

You need to restrict access to the bucket for another user or a service account.

## Solution {#case-resolution}

Users with service roles such as `storage.viewer`, `storage.configViewer`, `storage.configurer`, `storage.editor`, or `storage.admin` have different privileges and access rights for buckets:
* The `storage.viewer`, `storage.editor`, and `storage.admin` roles grant access to view or edit files in buckets.
* The `storage.configViewer` role only allows viewing the security settings of buckets and objects in them (without access to objects).
* The `storage.configurer` role allows modifying these settings.

For more details about service roles in Object Storage, see the [documentation](../../../storage/security/).

You can [configure access to the bucket through ACL](../../../storage/concepts/acl), removing the service roles from the required users, or configure access policies for each bucket: for more details, [see here](../../../storage/concepts/policy).

