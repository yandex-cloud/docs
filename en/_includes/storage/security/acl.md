# Access control list (ACL)

{% include [full-overview](./full-overview.md) %}

An {{ objstorage-name }} ACL is a list of permissions for each object and bucket. It is stored directly in {{ objstorage-name }}.

Permissions granted to a bucket apply to all objects it contains. With ACLs, you can also extend access permissions to individual objects.

{% note warning %}

A bucket [inherits](#inheritance) the access permissions in {{ iam-short-name }} from the folder and cloud where it is located.

{% endnote %}

> For example, a user with the `viewer` role in {{ iam-short-name }} for the folder containing the bucket can view its content, even if this permission is not specified in the bucket ACL.

By default, {{ objstorage-name }} creates an empty ACL for each new object or bucket. Users with the appropriate access permissions can edit and upload ACLs for {{ objstorage-name }} buckets and objects.

You can use ACLs to grant permissions to a {{ yandex-cloud }} user, [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [public group](#public-groups) (the group of all internet users, the group of all authenticated {{ yandex-cloud }} users). To do this, you need to know the [permission grantee's ID](#accounts-ids). When granting permissions, you can use [predefined ACLs](#predefined-acls), which contain common permission sets.


{% include [console-sa-acl-note](../console-sa-acl-note.md) %}

To view the ACL structure description, see [ACL XML schema](../../../storage/s3/api-ref/acl/xml-config.md). You can set up to 100 rules per ACL.

{% note info %}

ACLs uploaded for objects apply immediately. ACLs uploaded for buckets, as well as access permissions updated in {{ iam-short-name }}, apply with a delay. For more information about delays, see the [{{ iam-short-name }} documentation](../../../iam/concepts/access-control/index.md).

{% endnote %}

## Permission grantee’s ID {#accounts-ids}

* {{ yandex-cloud }} user

  You can get the ID in the following ways:
  * In the [IAM]({{ link-console-access-management }}) section of the management console.
  * Using the [CLI or {{ iam-short-name }} API](../../../iam/operations/users/get.md).
* [Service account](../../../iam/concepts/users/service-accounts)

  To get the ID, in the management console, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** from the list of services. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the service account.

* [Public group](#public-groups)

  Use the public group URI to grant permissions.

* [User group](../../../organization/concepts/groups.md)

  To get the ID, navigate to the [**{{ ui-key.yacloud_org.pages.groups }}**]({{ link-org-cloud-center }}/groups) tab in the {{ cloud-center }} interface.

## ACL operations {#acl-operations}

* In the management console, you can edit ACLs for [buckets](../../../storage/operations/buckets/edit-acl.md) and [objects](../../../storage/operations/objects/edit-acl.md).
* Using an Amazon S3-compatible API, you can [upload or download](../../../storage/s3/api-ref/acl.md) ACLs for buckets or objects.

  You cannot delete ACLs. To remove all access permissions, upload an empty ACL.

## Permission types {#permissions-types}

Permissions match the user roles in {{ iam-short-name }}.

Permission | Role in {{ iam-short-name }} | Description
--- |--- |---
`READ` | `viewer` | For buckets: Permission to retrieve a list of objects in the bucket, read various bucket settings (lifecycle, CORS, static hosting), and read all objects in the bucket.<br>For objects: Read permission.
`WRITE` | `editor` | For buckets: Writing, overwriting, and deleting the bucket’s objects.<br>You must use it together with `READ`; you cannot grant the `WRITE` permission separately.<br>For objects: This permission is meaningless, because the permission is checked for the bucket when writing an object.
`FULL_CONTROL` | `admin` | Full access to objects and buckets.
`READ_ACP` | `viewer` | ACL read permission. For objects only.
`WRITE_ACP` | `editor` | ACL write permission. For objects only.

{% note info %}

If you specify the `WRITE` permission without `READ` when creating an ACL, {{ objstorage-name }} will return the `501 Not Implemented` error code.

{% endnote %}

## Predefined ACLs {#predefined-acls}

ACL | Description
--- |---
`private`<br>`bucket-owner-full-control` | {{ yandex-cloud }} users get permissions according to their roles in {{ iam-short-name }}.
`public-read` | The `AllUsers` public group gets the `READ` permission.
`public-read-write` | The `AllUsers` public group gets the `READ` and `WRITE` permissions.
`authenticated-read` | The `AuthenticatedUsers` public group gets the `READ` permission.

Predefined ACLs can be applied to both objects and buckets. When applied to an object, the `public-read-write` ACL is the same as `public-read`.

You can upload a predefined ACL using only an [Amazon S3-compatible HTTP API](../../../storage/s3/api-ref/acl.md). When uploading an ACL, use the `X-Amz-Acl` HTTP header.

## Public groups {#public-groups}

### AllUsers {#all-users}

This system group includes all internet users.

The permission for `AllUsers` looks as follows:

```xml
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AllUsers</URI>
</Grantee>
```

### AuthenticatedUsers {#authenticated-users}

This group includes all authenticated {{ yandex-cloud }} users: both from your cloud and other users' clouds.

The permission for `AuthenticatedUsers` looks as follows:

```xml
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AuthenticatedUsers</URI>
</Grantee>
```

## Inheritance of bucket access permissions by {{ yandex-cloud }} public groups {#inheritance}

A bucket inherits the access permissions in {{ iam-short-name }} from the folder and cloud where it is located. If a user has permissions to access the folder or cloud the bucket belongs to, they will also have permissions to access the bucket itself.

{% note warning %}

Assigning roles to the `All users` and `All authenticated users` [public groups](../../../iam/concepts/access-control/public-group.md) for the folder or cloud the bucket belongs to is equivalent to granting **public access** to the bucket:
* `All authenticated users`: All authenticated {{ yandex-cloud }} users get access to the bucket, both from your cloud and other users' clouds.
* `All users`: Access is granted to all users.

You can grant the same access permissions to a bucket by adding access permissions for the `AuthenticatedUsers` and `AllUsers` groups to the bucket ACL.

{% endnote %}

### Viewing bucket access permissions inherited from a folder {#examples}

A bucket inherits access permissions from the folder. If you want to know which access permissions your bucket has inherited, get a list of roles for the folder. You can also revoke these roles at any time.

* To get a list of folder roles, run this command:

  ```bash
  yc resource-manager folder list-access-bindings \
    --id b1g7gvsi89m3********
  ```

  Result:

  ```text
  +---------+--------------+-----------------------+
  | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
  +---------+--------------+-----------------------+
  | viewer  | system       | allAuthenticatedUsers |
  | viewer  | system       | allUsers              |
  +---------+--------------+-----------------------+
  ```

  The output contains `allAuthenticatedUsers` and `allUsers`. This means the users of these groups have permissions for this folder and all resources it contains, including buckets.

* To revoke a role from the `All authenticated users` public group, run the following command:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m3******** \
    --role viewer \
    --allAuthenticatedUsers
  ```

* To revoke a role from the `All users` public group, run the following command:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m3******** \
    --role viewer \
    --allUsers
  ```

### See also {#see-also}

* [{#T}](../../../storage/operations/buckets/edit-acl.md)
* [{#T}](../../../storage/operations/objects/edit-acl.md)