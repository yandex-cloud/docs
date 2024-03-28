# Mounting a bucket to a container

{% include [read-note](../../_includes/functions/read-note.md) %}

Mounting buckets allows you to access them through the file system interface. In the container revision settings, the user can specify one or more mount paths. Use this path to access the directory in which the bucket is mounted. Do not use this path for anything other than an empty directory; otherwise, the container initialization may result in an error, and the mounted buckets will become unavailable.

You can mount the whole bucket or a specific [folder](../../storage/concepts/object#folder).

The `/run/storage_sync_socket` path is reserved for the Unix socket. To avoid loss of information when reading/writing data from/to the bucket:
* Do not put anything in the Unix socket path destination.
* Do not read from the Unix socket or write to it.


{% include [roles-for-bucket-mounting](../../_includes/functions/roles-for-bucket-mounting.md) %}

## See also {#see-also}

* [Mounting a bucket to a container](../operations/mount-bucket.md)
* [Mounting a bucket to a function](../../functions/operations/function/mount-bucket.md)
