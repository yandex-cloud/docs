| File | Path format |
| ----------------------------------------------------------------- | ------------------------------------------------------ |
| Instance file system | `file:///<file path>` |
| Distributed cluster file system | `hdfs:///<file path>` |
| [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md) | `s3a://bucket name>/<file path>` |
| Internet | `http://<file path>` or `https://<file path>` |

Archives in standard Linux formats, such as `zip`, `gz`, `xz`, `bz2`, and others, are supported.

If the file is in a bucket, the cluster service account must have read access to it. For more information about configuring access to {{ objstorage-name }} buckets, see [{#T}](../../storage/operations/buckets/edit-acl.md).

