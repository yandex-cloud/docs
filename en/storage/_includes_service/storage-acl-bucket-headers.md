Header | Description
--- | ---
`X-Amz-Acl` | Sets [permission types](../concepts/acl.md#permissions-types) for a bucket.
`X-Amz-Grant-Read` | Grants the access grantee permission to view the contents of a bucket and read objects in it.
`X-Amz-Grant-Write` | Grants the access grantee object write permission. Make sure to use this header with `X-Amz-Grant-Read`; otherwise, {{ objstorage-name }} will return the `501 Not Implemented` code.
`X-Amz-Grant-Read-Acp` | Grants the access grantee bucket ACL read permission.
`X-Amz-Grant-Write-Acp` | Grants the access grantee bucket ACL write permission.
`X-Amz-Grant-Full-Control` | Grants the access grantee the `READ`, `WRITE`, `READ_ACP`, and `WRITE_ACP` permissions for the bucket.

The value for the `X-Amz-Grant-*` header is a comma-separated list of access grantees. Each access grantee is identified as `<access_grantee_type>:<access_grantee_ID>`. {{ objstorage-name }} supports the following types of access grantees:
* `id`: Access grantee is a cloud user.
* `uri`: Access grantee is a public group.

Example:

```http
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```