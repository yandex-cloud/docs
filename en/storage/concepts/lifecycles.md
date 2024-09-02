# Object lifecycles

With _object lifecycles_, you can [configure](../operations/buckets/lifecycles.md) actions to be automatically performed with individual objects or groups of objects in a bucket at specified points in time.

{% note info %}

In buckets with [logging enabled](./server-logs.md), actions performed with objects as part of the object lifecycle are not logged.

{% endnote %}

Types of actions:

* Change the [storage class](./storage-class.md) of objects or their non-current [versions](./versioning.md) to a "colder" one. You can set the change of the storage class to `ICE` using YC CLI, AWS CLI, {{ TF }}, and the API.
* Delete objects or their non-current versions.
* Delete incomplete multipart uploads.

Filters for grouping objects:

* Object [key](object.md#key) prefix.
* Minimum or maximum object size.
* Object [label](./tags.md#object-tags). Unavailable in the [management console]({{ link-console-main }}).
* `AND` logical operator. Allows you to group objects using a combination of several filters.

You can only specify one filter per lifecycle rule. To specify more than one filter type for a lifecycle at a time, use the `AND` logical operator. For more information, see [Lifecycle configuration](../s3/api-ref/lifecycles/xml-config.md).

If you are using the [S3 API](../s3/index.md), specify a lifecycle configuration in [XML format](../s3/api-ref/lifecycles/xml-config.md). For various [tools](../tools/index.md) with the S3 API support, other configuration formats may be required. The AWS CLI, for example, uses the JSON format.

You can only [configure](../operations/buckets/lifecycles.md) object lifecycles for each individual bucket, not for a bucket group, folder, or cloud.

Once a day, lifecycles are updated with the latest changes as of 00:00 UTC. This operation takes a few hours to complete.

#### See also {#see-also}

* [{#T}](../operations/buckets/lifecycles.md)
