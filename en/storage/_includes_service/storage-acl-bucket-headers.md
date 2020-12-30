| Header | Description |
| ---------- | --------- |
| `x-amz-acl` | Sets [permissions types](../concepts/acl.md#permissions-types) for a bucket. |
| `x-amz-grant-read` | Grants the access grantee permission to view the contents of a bucket and read objects within it. |
| `x-amz-grant-write` | Grants the access grantee object write permission. You must use this header with `x-amz-grant-read`, otherwise {{ objstorage-name }} returns the code `501 Not Implemented`. |
| `x-amz-grant-read-acp` | Grants the access grantee bucket ACL read permission. |
| `x-amz-grant-write-acp` | Grants the access grantee bucket ACL write permission. |
| `x-amz-grant-full-control` | Grants the access grantee the following permissions: `READ`, `WRITE`, `READ_ACP`, and `WRITE_ACP` for a bucket. |

The value for an `x-amz-grant-*` header is a comma-separated list of access grantees. Each access grantee is identified in a structure like `<access grantee type>:<access grantee ID>`. {{ objstorage-name }} supports the following types of access grantees:

- `id` — access grantee — cloud user.
- `uri` — access grantee — system group.

Example:

```
x-amz-grant-read: uri="http://acs.amazonaws.com/groups/s3/AuthenticatedUsers"
```