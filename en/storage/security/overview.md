# Overview of access management methods in {{ objstorage-name }}

{{ objstorage-name }} incorporates several interrelated access management mechanisms:
* [{{ iam-full-name }} ({{ iam-short-name }})](#iam)
* [Access control list (ACL)](#acl)
* [Bucket policy](#policy)
* [Public access](#anonymous)
* [Pre-signed URLs](#pre-signed)

The flow chart shows how the access management mechanisms interact in {{ objstorage-name }}.

![access-scheme](../../_assets/storage/access-scheme.svg)

All checks follow this algorithm:

1. _IAM_ and _bucket ACL_:
   * If the request passes the _IAM_ **or** the _bucket ACL_ check, the next step is the _bucket policy_ check, if such a policy is enabled in the bucket. If the _bucket policy_ is disabled, access will be allowed.
   * If the request fails the _IAM_ **and** the _bucket ACL_ checks, _public access_ to the bucket is checked.
1. _Public access_:
   * If public access to perform the action is enabled, the next step is the _bucket policy_ check, if such a policy is enabled in the bucket. If the _bucket policy_ is disabled, access will be allowed.
   * If public access to perform the action is disabled, the next step is to check the access based on the _object ACL_.
1. _Bucket policy_:
   1. If the request meets at least one of the `Deny` rules, the next step is to check the access based on the _object ACL_.
   1. If the request meets at least one of the `Allow` rules, access will be allowed.
   1. If the request does not meet any of the rules, the next step is to check the access based on the _object ACL_.
1. _Object ACL_:
   * If the request passes the _object ACL_ check, access will be allowed.
   * If the request fails the _object ACL_ check, access will be denied.

## {{ iam-name }} {#iam}

[{{ iam-name }}](./index.md): Basic method for managing access in {{ yandex-cloud }} using role assignment. It defines basic access permissions. For more details, see [{#T}](./index.md#roles-list).

Access grantees include:
* Yandex account
* [Service account](../../iam/concepts/users/service-accounts.md)
* [Federated user](../../iam/concepts/federations.md)
* [User group](../../organization/operations/manage-groups.md)
* [System group](../../iam/concepts/access-control/system-group.md)

Access is granted to a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [bucket](../concepts/bucket.md).

## Access control list (ACL) {#acl}

An [access control list (ACL)](./acl.md) is a list of action permissions stored directly in {{ objstorage-name }}. It defines basic access permissions. ACL permissions for buckets and objects are different; see [{#T}](./acl.md#permissions-types) for details.

{% note info %}

If you do not need to differentiate access to specific objects, we recommend using {{ iam-name }}.

{% endnote %}

Access grantees include:
* Yandex account
* [Service account](../../iam/concepts/users/service-accounts.md)
* [Federated user](../../iam/concepts/federations.md)
* [User group](../../organization/operations/manage-groups.md)
* [System group](../../iam/concepts/access-control/system-group.md)

Access is granted to a [bucket](../concepts/bucket.md) or [object](../concepts/object.md).

## Bucket policy {#policy}

A [bucket policy](./policy.md) is a list of rules that prohibit or allow [actions](../s3/api-ref/policy/actions.md) when certain [conditions](../s3/api-ref/policy/conditions.md) are met. Allows you to granularly differentiate access to buckets, objects and groups of objects.

Access grantees include:
* Yandex account
* [Service account](../../iam/concepts/users/service-accounts.md)
* [Federated user](../../iam/concepts/federations.md)
* Anonymous user

Access is granted to a [bucket](../concepts/bucket.md), [object](../concepts/object.md), or a group of objects.

## Public access {#anonymous}

[Public access](./public-access.md) defines access permissions for anonymous users to read objects, list of objects and bucket settings.

Access is granted to a [bucket](../concepts/bucket.md).

{% include [public-access-warning](../../_includes/storage/security/public-access-warning.md) %}

## Pre-signed URLs {#pre-signed}

[Pre-signed URLs](./pre-signed-urls.md) are a way of giving anonymous users temporary access to certain actions in {{ objstorage-name }} using URLs that contain request authorization data in their parameters.

Access is granted to a [bucket](../concepts/bucket.md) or [object](../concepts/object.md).

### See also {#see-also}

* [{#T}](../operations/buckets/iam-access.md)
* [{#T}](../operations/buckets/edit-acl.md)
* [{#T}](../operations/objects/edit-acl.md)
* [{#T}](../operations/buckets/policy.md)
* [{#T}](../operations/buckets/bucket-availability.md)