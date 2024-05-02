# Mounting a bucket to a function

Mounting buckets allows you to access them through the file system interface. In the function version settings, you can specify one or multiple mount points. The directory where the bucket is mounted will be accessible at the `/function/storage/<mount_point>` path.

You can mount the entire bucket or a specific [folder](../../storage/concepts/object#folder).


{% include [roles-for-bucket-mounting](../../_includes/functions/roles-for-bucket-mounting.md) %}

## See also {#see-also}

* [Mounting a bucket to a function](../operations/function/mount-bucket.md)
* [Mounting a bucket to a container](../../serverless-containers/operations/mount-bucket.md)
