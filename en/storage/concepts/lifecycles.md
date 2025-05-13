# Bucket object lifecycles

With _object lifecycles_, you can [configure](../operations/buckets/lifecycles.md) automatic actions on individual objects or groups of objects in a bucket at specified points in time.

{% note info %}

In buckets with [logging enabled](./server-logs.md), actions performed on objects as part of the object lifecycle are not logged.

{% endnote %}

Types of actions include:

* Change the [storage class](./storage-class.md) of objects or their non-current [versions](./versioning.md) to a colder one. You can configure the change to the `ICE` class using the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, and the API.
* Delete objects or their non-current versions.
* Delete incomplete multipart uploads.

Filters for grouping objects include:

* Object [key](object.md#key) prefix.
* Minimum or maximum object size.
* Object [label](./tags.md#object-tags); unavailable in the [management console]({{ link-console-main }}).
* **AND** logical operator that allows you to group objects using a combination of multiple filters.

You can only specify one filter per lifecycle rule. To specify more than one filter type for a lifecycle at a time, use the logical `AND`. For more information, see [Lifecycle configuration](../s3/api-ref/lifecycles/xml-config.md).

If you use the [S3 API](../s3/index.md), specify the lifecycle configuration in [XML format](../s3/api-ref/lifecycles/xml-config.md). Various [tools](../tools/index.md) with the S3 API support may require other configuration formats. The AWS CLI, for example, uses the JSON format.

You can only [configure](../operations/buckets/lifecycles.md) object lifecycles for each individual bucket, not for a bucket group, folder, or cloud.

Object lifecycles are updated daily at 00:00 UTC. This operation takes a few hours to complete.

#### See also {#see-also}

* [{#T}](../operations/buckets/lifecycles.md)
