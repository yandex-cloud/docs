---
title: Access control lists (ACL)
description: Users with the appropriate access rights can edit and upload ACLs for {{ objstorage-name }} buckets and objects. An {{ objstorage-name }} ACL is a list of permissions for each object and bucket and is stored directly in {{ objstorage-name }}.
keywords:
  - ACL
  - access control list
---

# Access control lists (ACLs)

{{ yandex-cloud }} uses two independent mechanisms for managing access to {{ objstorage-name }} resources:
* [{{ iam-name }}](../../iam/concepts/index.md) settings.
* An {{ objstorage-name }} ACL is a list of permissions for each object and bucket and is stored directly in {{ objstorage-name }}.

When receiving a request to a bucket or object, {{ objstorage-name }} checks access permissions through both mechanisms. If the required access is granted from either method, {{ objstorage-name }} executes the request. Permissions granted to a bucket apply to all of the objects it contains. With ACLs, you can extend access permissions to individual objects.

{% note warning %}

A bucket [inherits](#inheritance) the same access rights in the IAM service as those of the folder and cloud where it's located.

{% endnote %}

> For example, if users have the `viewer` role in {{ iam-short-name }} for the bucket's folder, they can view its contents even if it isn't reflected in the bucket ACL.

By default, {{ objstorage-name }} creates an empty ACL for each new object or bucket. Users with the appropriate access rights can edit and upload ACLs for {{ objstorage-name }} buckets and objects.

You can use ACLs to grant permissions to {{ yandex-cloud }} users, service accounts, and system groups. To do this, you need to know the [permission recipient's ID](#accounts-ids). When granting permissions, you can use [predefined ACLs](#predefined-acls), which contain common permission sets.

To view the ACL structure, see [ACL XML schema](../s3/api-ref/acl/xml-config.md). You can set up to 100 rules per ACL.

{% note info %}

ACLs uploaded for objects are applied immediately. ACLs uploaded for buckets and access permissions updated in the IAM service apply after a delay. For more information about delays, see the [IAM documentation](../../iam/concepts/access-control/index.md).

{% endnote %}

## Permission recipient ID {#accounts-ids}

- User {{ yandex-cloud }}

  You can get the ID in the following ways:
  * In the [IAM]({{ link-console-access-management }}) section of the management console.
  * Using the [CLI or IAM API](../../iam/operations/users/get.md).

- [A service account](../../iam/concepts/users/service-accounts)

  To get the ID, go to the **Service accounts** section in the management console.

- [System group](#system-groups)

  Use the system group URI to grant permissions.

## ACL operations {#acl-operations}

* In the management console, you can edit ACLs for [buckets](../operations/buckets/edit-acl.md) and [objects](../operations/objects/edit-acl.md).
* Using an Amazon S3-compatible API, you can [upload or download](../s3/api-ref/acl.md) ACLs for buckets or objects.

  You can't delete ACLs. To remove all access permissions, upload an empty ACL.

## Permission types {#permissions-types}

Permissions correspond to user roles in {{ iam-name }}.

Permission | IAM role | Description
--- | --- | ---
`READ` | `viewer` | For buckets: permission to retrieve a list of objects in the bucket, read various bucket settings (lifecycle, CORS, static hosting), and read all objects in the bucket.<br>For objects: read permission.
`WRITE` | `editor` | For buckets: permission to write objects to the bucket, rewrite and delete them from there.<br>It must be used along with `READ`. You cannot specify `WRITE` separately.<br>For objects: this permission is meaningless, as permission is checked for the bucket when writing an object.
`FULL_CONTROL` | `admin` | Full access to objects and buckets.
`READ_ACP` | `viewer` | ACL read permission. For objects only.
`WRITE_ACP` | `editor` | ACL write permission. For objects only.

{% note info %}

If you specify `WRITE` permission, but not `READ` when making an ACL, {{ objstorage-name }} will return the code `501 Not Implemented`.

{% endnote %}

## Predefined ACLs {#predefined-acls}

ACL | Description
--- | ---
`private`<br>`bucket-owner-full-control` | {{ yandex-cloud }} users get permissions according to their roles in IAM.
`public-read` | The `AllUsers` system group gets `READ` permission.
`public-read-write` | The `AllUsers` system group gets `READ` and `WRITE` permissions.
`authenticated-read` | The `AuthenticatedUsers` system group gets `READ` permission.

Predefined ACLs can be applied to both objects and buckets. When applied to an object, the `public-read-write` ACL is the same as `public-read`.

You can upload a predefined ACL using only an [Amazon S3-compatible HTTP API](../s3/api-ref/acl.md). When uploading an ACL, use the `x-amz-acl` HTTP header.

## System groups {#system-groups}

### AllUsers {#all-users}

Includes all internet users.

Permission for `AllUsers` looks like this:

```
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AllUsers</URI>
</Grantee>
```

### AuthenticatedUsers {#authenticated-users}

Includes all authenticated {{ yandex-cloud }} users: both from your clouds and other users' clouds.

Permission for `AuthenticatedUsers` looks like this:

```
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
    <URI>http://acs.amazonaws.com/groups/global/AuthenticatedUsers</URI>
</Grantee>
```

## Inheritance of bucket access rights by system groups {{ yandex-cloud }} {#inheritance}

A bucket inherits the same access rights in the {{ iam-short-name }} service as those of the folder and cloud where it's located. If users have access rights to the folder or cloud that the bucket belongs to, they'll also have access to the bucket itself.

{% note warning %}

Assigning roles to [system groups](../../iam/concepts/access-control/system-group.md) `allUsers` and `allAuthenticatedUsers` for the folder or cloud that the bucket belongs to is the same as granting **public access** to the bucket:
* `allAuthenticatedUsers`: All authenticated {{ yandex-cloud }} users get access to the bucket, both from your clouds and other users' clouds.
* `allUsers`: Access is granted to all users.

You can grant similar access rights to a bucket by adding access rights for the `AuthenticatedUsers` and `AllUsers` groups in the bucket ACL.

{% endnote %}

### How to view bucket access rights inherited from folders {#examples}

A bucket inherits access rights from its folder. If you want to know exactly what access rights your bucket inherited, get a list of roles for the folder. You can also revoke these roles at any time.

* To get a list of folder roles, run the command:

  ```bash
  yc resource-manager folder list-access-bindings \
    --id b1g7gvsi89m34qmcm4ke
  ```

  Result:

  ```bash
  +---------+--------------+-----------------------+
  | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
  +---------+--------------+-----------------------+
  | viewer  | system       | allAuthenticatedUsers |
  | viewer  | system       | allUsers              |
  +---------+--------------+-----------------------+
  ```

  The output contains `allAuthenticatedUsers` and `allUsers`. This means that users of these groups are granted rights for this folder and all resources contained in it, including buckets.

* To revoke a role from the `allAuthenticatedUsers` system group, run the command:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m34qmcm4ke \
    --role viewer \
    --allAuthenticatedUsers
  ```

* To revoke a role from the `allUsers` system group, run the command:

  ```bash
  yc resource-manager folder remove-access-binding \
    --id b1g7gvsi89m34qmcm4ke \
    --role viewer \
    --allUsers
  ```