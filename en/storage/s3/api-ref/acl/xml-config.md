---
title: ACL configuration in XML format. {{ objstorage-name }} API (S3)
description: Here you can find a typical XML structure of an ACL configuration, as well as each of its elements. AccessControlPolicy, Owner, AccessControlList, Grant, Grantee, ID, DisplayName, URI, Permission.
---

# ACL configuration in XML format

The typical ACL format is as follows:

```xml
<AccessControlPolicy>
  <Owner>
    <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cde********</ID>
    <DisplayName>CustomersName@amazon.com</DisplayName>
  </Owner>
  <AccessControlList>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:type="CanonicalUser">
        <ID>8caede4d8w78r43d14f2e7fagrbf45c78ejc7c6cde********</ID>
        <DisplayName>YandexCloudUserName</DisplayName>
      </Grantee>
      <Permission>WRITE</Permission>
    </Grant>
  </AccessControlList>
</AccessControlPolicy>
```


## Elements {#elements}

#|
|| **Element** | **Description** ||
|| `AccessControlPolicy` | Root element.

Path: `/AccessControlPolicy`. ||
|| `Owner` | User information.

Users can specify this element for `objectPutAcl` and `bucketPutAcl` requests. If the element is specified, {{ objstorage-name }} will check if the provided ID matches the actual one during the ACL upload. If there is no match, it will return code 403.

Path: `/AccessControlPolicy/Owner`. ||
|| `AccessControlList` | Access control list. It cannot contain more than 100 access permissions.

Path: `/AccessControlPolicy/AccessControlList`. ||
|| `Grant` | Access description.

Path: `/AccessControlPolicy/AccessControlList/Grant`. ||
|| `Grantee` | Type of permission grantee. The possible values for `type` include:
* `CanonicalUser`: For a user, [service account](../../../../iam/concepts/users/service-accounts.md), or [user group](../../../../organization/concepts/groups.md).
* `Group`: For a [public group](../../../concepts/acl.md#public-groups).

{% include [canonical-user-identification](../../../../_includes/storage/canonical-user-identification.md) %}

Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee`. ||
|| `ID` | ID of a user, [service account](../../../../iam/concepts/users/service-accounts.md), or [user group](../../../../organization/concepts/groups.md). It is used with the `CanonicalUser` type of permission grantee.

A response to the `bucketGetAcl` request contains the ID of the folder containing the bucket.

Paths: `/AccessControlPolicy/Owner/ID`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/ID`. ||
|| `DisplayName` | Username. It is ignored for the `objectPutAcl` and `bucketPutAcl` requests.

Paths: `/AccessControlPolicy/Owner/DisplayName`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. ||
|| `URI` | Public group ID. It is used with the `Group` type of permission grantee. The possible values are:
* `http://acs.amazonaws.com/groups/global/AllUsers`: All internet users.
* `http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: All authenticated {{ yandex-cloud }} users.

Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee/URI`. ||
|| `Permission` | User permissions.

You can specify the following permissions: `READ`, `WRITE`, and `FULL_CONTROL`. When granting permissions for an object, you can also specify `READ_ACP` and `WRITE_ACP`. Learn more in [Access control lists (ACLs)](../../../concepts/acl.md).

Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. ||
|#

#### Related articles {#related-articles}

* [{#T}](../../../concepts/acl.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
