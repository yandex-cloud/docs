# {{ objstorage-full-name }} release notes

## Q1 2024 {#q1-2024}

* Improved object [lifecycle](./concepts/lifecycles.md) management in a bucket:
   * Added support for new filters for grouping objects: [object labels](./concepts/tags.md#object-tags) and the `AND` operator.
   * Implemented the new filter feature in the management console, YC СLI, {{ TF }}, and using the [tools](./tools/) that support the S3 API.
* Added support for working with [bucket labels](./concepts/tags.md#bucket-tags) in the management console, YC СLI, and {{ TF }}.
* Implemented the feature to add {{ org-full-name }} [user groups](../organization/concepts/groups.md) to an [access control list (ACL)](./security/acl.md) and an [access policy (bucket policy)](./security/policy.md) in the management console, YC СLI, and {{ TF }}.
* Improved the management console interface:
   * Added filtering by prefix in the list of bucket objects.
   * Added the feature to download objects from a list.
