| File | Path format |
| ----------------------------------------------------------------- | ------------------------------------------------------ |
| Instance file system | `file:///<file path>` |
| Distributed cluster file system | `hdfs:///<file path>` |
| [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md) | `s3a://bucket name>/<file path>` |
| Internet | `http://<file path>` or `https://<file path>` |

Archives in standard Linux formats, such as `zip`, `gz`, `xz`, `bz2`, and others, are supported.

The cluster service account needs read access to all the files in the bucket. Step-by-step instructions for setting up access to {{ objstorage-name }} are provided in [{#T}](../../storage/operations/buckets/edit-acl.md).

