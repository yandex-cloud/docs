---
title: "XML structure of ACL configuration. {{ objstorage-name }} API (S3)"
description: "A general view of the XML structure of ACL configuration, as well as each of its elements are described. AccessControlPolicy, Owner, AccessControlList, Grant, Grantee, ID, DisplayName, URI, Permission."
---

# XML structure of ACL configuration

ACL general view:

```
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

| Element | Description |
----- | -----
| `AccessControlPolicy` | Root element.<br/><br/>Path: `/AccessControlPolicy`. |
| `Owner` | User information.<br/><br/>Users can specify this element for `objectPutAcl` and `bucketPutAcl` requests. If the element is specified, then when uploading an ACL, {{ objstorage-name }} checks whether the ID passed matches the actual ID. Otherwise, a 403 code is returned.<br/><br/>Path: `/AccessControlPolicy/Owner`. |
| `AccessControlList` | Access control list. May contain up to 100 access permissions.<br/><br/>Path: `/AccessControlPolicy/AccessControlList`. |
| `Grant` | Access description.<br/><br/>Path: `/AccessControlPolicy/AccessControlList/Grant`. |
| `Grantee` | Type of the permission grantee. The possible values for `type`:<ul><li>`CanonicalUser`: For a user, [service account](../../../../iam/concepts/users/service-accounts.md), or [user group](../../../../organization/concepts/groups.md).</li><li>`Group`: For a [system group](../../../concepts/acl.md#system-groups).</li></ul>Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee`. |
| `ID` | ID of a user, [service account](../../../../iam/concepts/users/service-accounts.md), or [user group](../../../../organization/concepts/groups.md). It is used with the `CanonicalUser` permission grantee type.<br/><br/>A response to a `bucketGetAcl` request contains the ID of the folder where the bucket is located.<br/><br/>Paths: `/AccessControlPolicy/Owner/ID`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/ID`. |
| `DisplayName` | Username. Ignored for `objectPutAcl` and `bucketPutAcl` requests<br/><br/>Paths: `/AccessControlPolicy/Owner/DisplayName`, `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. |
| `URI` | ID of a [system group](../../../concepts/acl.md#system-groups). It is used with the `Group` permission grantee type. The possible values include:<ul><li>`http://acs.amazonaws.com/groups/global/AllUsers`: All internet users.</li><li>`http://acs.amazonaws.com/groups/global/AuthenticatedUsers`: All authenticated {{ yandex-cloud }} users.</li></ul>Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee/URI`. |
| `Permission` | User permissions.<br/><br/>You can specify the following permissions: `READ`, `WRITE`, and `FULL_CONTROL`. When granting permissions to an object, you can also specify `READ_ACP` and `WRITE_ACP`. For more information, see [Access control lists (ACLs)](../../../concepts/acl.md). <br/><br/>Path: `/AccessControlPolicy/AccessControlList/Grant/Grantee/DisplayName`. |

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}