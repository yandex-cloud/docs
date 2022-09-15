# Storage class

{{ objstorage-name }} lets you store objects in various storage _classes_ depending on your requirements for storage duration and frequency of object operations. The following classes are available in the service:

* Standard storage.
* Cold storage.
   {% if product == "yandex-cloud" and audience != "internal" %}

* Ice storage.
   {% endif %}

<q>Colder</q> classes are designed to store objects that you plan to use less frequently for longer periods of time. The <q>colder</q> storage is, the cheaper it is to store data but the more expensive it is to read from and write to it. {% if audience != "internal" %}For more information about the pricing, see [{#T}](../pricing.md){% endif %}.

{% if product == "yandex-cloud" and audience != "internal" %}

{% note info %}

{% include [ice-minimum-duration](../../_includes/storage/ice-minimum-duration.md) %}

{% endnote %}

{% endif %}

The storage class is optionally specified when uploading each individual object.

## Default storage for a bucket {#default-storage-class}

If you don't specify the storage class on object upload, the object is saved to the default storage for the bucket.

You can set the default storage when creating a bucket in the management console. Afterwards, you can also change this setting for each bucket in the management console. You can't set or change the default storage with other tools. For buckets created outside of the management console, the default storage is set. You can't set the default storage for all buckets in a folder or cloud at once.

Setting the default storage is useful if the tool you use doesn't let you set the object storage class.

## Changing an object storage class {#changing-storage-class}

{{ objstorage-name }} doesn't support arbitrarily changing the storage class of an object. To change the storage class, you can:

- Upload the object again to {{ objstorage-name }} with the required storage class.
- Set the criteria for changing the storage class in the [object lifecycle](lifecycles.md) configuration.

The Lifecycle configuration lets you move an object from standard storage to cold storage according to the [rules](../s3/api-ref/lifecycles/xml-config.md).

{% note info %}

The lifecycle configuration only lets you move an object from `STANDARD` to `COLD` storage.

{% endnote %}


## Storage class IDs {#storage-class-identifiers}

When working with {{ objstorage-name }} using the [Amazon S3-compatible API](../s3/index.md) or the tools described in [{#T}](../tools/index.md), for storage classes, use the following IDs:

* Standard storage: `STANDARD`.
* Cold storage: `COLD`, `STANDARD_IA`, or `NEARLINE` (the last two only for uploading objects to a bucket).
   {% if product == "yandex-cloud" and audience != "internal" %}

* Ice storage: `ICE` or `GLACIER` (the latter only for uploading objects to a bucket).
   {% endif %}
