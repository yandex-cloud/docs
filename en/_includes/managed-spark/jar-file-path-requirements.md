| File location                                                | Path format                                          |
|-----------------------------------------------------------------|------------------------------------------------------|
| Instance file system                                       | `file:///<file_path>`                             |
| [{{ objstorage-name }}](../../storage/concepts/bucket.md) bucket | `s3a://<bucket_name>/<file_path>`                  |
| Internet                                                        | `http://<path_to_file>` or `https://<path_to_file>` |

Archives in standard Linux formats, such as `zip`, `gz`, `xz`, `bz2`, etc., are supported.

The cluster service account needs read access to all the files in the bucket. Step-by-step guides on how to set up access to {{ objstorage-name }} are provided in [{#T}](../../storage/operations/buckets/edit-acl.md).
