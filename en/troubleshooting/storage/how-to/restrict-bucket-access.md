# How to restrict access to a bucket for a user



## Case description {#case-description}

You need to restrict access to the bucket for another user or a service account.

## Solution {#case-resolution}

The `storage.viewer`, `storage.configViewer`, `storage.configurer`, `storage.editor`, and `storage.admin` service roles provide users with different privileges and access permissions for buckets:

* The `storage.viewer`, `storage.editor`, and `storage.admin` roles allow users to view or edit files in buckets. 
* The `storage.configViewer` role allows users to view security settings of buckets and their objects but does not allow access to those objects.
* The `storage.configurer` role allows users to change these settings. 

For more info on service roles in {{ objstorage-short-name }}, see [this section](../../../storage/security/).

You can [configure bucket access using ACL](../../../storage/concepts/acl.md) by revoking service roles from specific users, or set up individual bucket policies. For more details, see [this guide](../../../storage/concepts/policy.md).