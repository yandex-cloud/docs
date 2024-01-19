| File | Path format |
|-----------------------------------------------------------------|------------------------------------------------------|
| Instance file system | `file:///<path_to_file>` |
| Distributed cluster file system | `hdfs:///<path_to_file>` |
| [Bucket {{ objstorage-name }}](../../storage/concepts/bucket.md) | `s3a://<bucket_name>/<path_to_file>` |
| Internet | `http://<path_to_file>` or `https://<path_to_file>` |

Archives in standard Linux formats, such as `zip`, `gz`, `xz`, `bz2`, and others, are supported.

The cluster service account needs read access to all the files in the bucket. For step-by-step guides on setting up access to {{ objstorage-name }}, see [{#T}](../../storage/operations/buckets/edit-acl.md).
