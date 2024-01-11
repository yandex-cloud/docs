| Header | Description |
--- | ---
| `X-Amz-Acl` | Sets a [predefined ACL](../concepts/acl.md#predefined-acls) for an object. |
| `X-Amz-Grant-Read` | Grants the access grantee object read permission. |
| `X-Amz-Grant-Read-Acp` | Grants the access grantee object ACL read permission. |
| `X-Amz-Grant-Write-Acp` | Grants the access grantee object ACL write permission. |
| `X-Amz-Grant-Full-Control` | Grants the access grantee the following permissions: `READ`, `WRITE`, `READ_ACP`, and `WRITE_ACP` for an object. |

The value for an `X-Amz-Grant-*` header is a comma-separated list of access grantees. Each access grantee is identified in a structure like `<access_grantee_type>:<access_grantee_ID>`. {{ objstorage-name }} supports the following types of access grantees:
* `id`: access grantee is a cloud user.
* `uri`: access grantee is a system group.

For example:

```
X-Amz-Grant-Read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```
