Header | Description
--- | ---
`X-Amz-Acl` | Sets a [predefined ACL](../concepts/acl.md#predefined-acls) for an object.
`X-Amz-Grant-Read` | Grants the access grantee object read permission.
`X-Amz-Grant-Read-Acp` | Grants the access grantee object ACL read permission.
`X-Amz-Grant-Write-Acp` | Grants the access grantee object ACL write permission.
`X-Amz-Grant-Full-Control` | Grants the access grantee the `READ`, `WRITE`, `READ_ACP`, and `WRITE_ACP` permissions for the object.

The value for the `X-Amz-Grant-*` headers is a comma-separated list of access grantees. Each access grantee is identified in a structure `<access_grantee_type>:<access_grantee_ID>`. {{ objstorage-name }} supports the following types of access grantees:
* `id`: Access grantee is a cloud user.
* `uri`: Access grantee is a public group.

Example:

```http
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```