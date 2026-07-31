# Bucket object lifecycle configuration

{{ objstorage-name }} allows you to manage bucket [object lifecycles](../../../concepts/lifecycles.md). To upload a lifecycle configuration to {{ objstorage-name }}, you need to create an XML document as described in this section. You can get a document in this format by downloading an existing configuration.

The general configuration format is as follows:

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Rule description</ID>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
            <And>
                <ObjectSizeGreaterThan>minimum object size</ObjectSizeGreaterThan>
                <ObjectSizeLessThan>maximum object size</ObjectSizeLessThan>
                <Prefix>key prefix</Prefix>
                <Tag>
                    <Key>label key</Key>
                    <Value>label value</Value>
                </Tag>
                ...
            </And>
            <ObjectSizeGreaterThan>minimum object size</ObjectSizeGreaterThan>
            <ObjectSizeLessThan>maximum object size</ObjectSizeLessThan>
            <Prefix>key prefix</Prefix>
            <Tag>
                <Key>label key</Key>
                <Value>label value</Value>
            </Tag>
        </Filter>

        <Transition>
            <StorageClass>Storage class ID</StorageClass>
            <!-- <Date> or <Days> -->
        </Transition>

        <Expiration>
            <!-- <Date> or <Days> -->
            <!-- <ExpiredObjectDeleteMarker> -->
        </Expiration>

        <NoncurrentVersionTransition>
            <StorageClass>Storage class ID</StorageClass>
            <NoncurrentDays>Migrating versions that are older than the specified number of days</NoncurrentDays>
        </NoncurrentVersionTransition>

        <NoncurrentVersionExpiration>
            <NoncurrentDays>Deleting versions that are older than the specified number of days</NoncurrentDays>
        </NoncurrentVersionExpiration>

        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>Deleting uploads that were not completed within the specified number of days</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    ...
</LifecycleConfiguration>
```

A configuration may contain up to 1,000 rules.

## Elements {#elements}

#|
|| Element | Description ||
|| `LifecycleConfiguration` | Root element of an XML document.
It can contain up to 1,000 `Rule` elements.
Path: `LifecycleConfiguration`. ||
|| `Rule` | Rule description.
The `Filter` element specifies objects the rule applies to. The `Transition` and `Expiration` elements define actions on objects. There can be multiple actions of each type.
Path: `LifecycleConfiguration\Rule`. ||
|| `ID` | Unique rule ID.
Any text up to 255 characters long, e.g., _Delete in 20 days_. It is an optional parameter that you can use to search for a rule in a configuration.
If the ID is not specified, {{ objstorage-name }} generates it automatically.
Path: `LifecycleConfiguration\Rule\ID`. ||
|| `Status` | Rule status.
You can activate a rule by setting `<Status>Enabled</Status>` or deactivate it by setting `<Status>Disabled</Status>`.
Path: `LifecycleConfiguration\Rule\Status`. ||
|| `Filter` | Object filter.
It may only contain one element of each type: `And`, `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, or `Tag`.
If an empty `<Filter></Filter>` filter is set, the rule applies to all objects in a bucket.
Path: `LifecycleConfiguration\Rule\Filter`. ||
|| `ObjectSizeGreaterThan` | Minimum object size in bytes.
The rule applies to objects with a size greater than the specified value.
The filter may contain only one minimum object size.
Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`. ||
|| `ObjectSizeLessThan` | Maximum object size in bytes.
The rule applies to objects with a size less than the specified value.
The filter may contain only one maximum object size.
Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`. ||
|| `Prefix` | Key prefix.
The rule applies to objects with the specified key prefix.
For example, the `some/long/object/key` key may have these prefixes: `some`, `some/`, or `some/lo`.
The filter may contain only one prefix.
Path: `LifecycleConfiguration\Rule\Filter\Prefix`. ||
|| `Tag` | Object [label](../../../concepts/tags.md#object-tags).
The rule applies to objects with the specified label assigned.
The filter may contain only one object label.
Path: `LifecycleConfiguration\Rule\Filter\Tag`. ||
|| `And` | Logical `AND` for filters.
This filter may contain any combination of the following elements: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, and `Tag`.
Path: `LifecycleConfiguration\Rule\Filter\And`. ||
|| `Key` | Object label key.
Path: `LifecycleConfiguration\Rule\Filter\Tag\Key`. ||
|| `Value` | Object label value.
Path: `LifecycleConfiguration\Rule\Filter\Tag\Value`. ||
|| `Transition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of an object.
It contains the `StorageClass` element, which defines the target storage class and the `Date` or `Days` element, which sets when the action expires.
You can only move objects from the `STANDARD` storage to the `COLD`, `ICE`, or `INTELLIGENT_TIERING` one, and from the cold storage, to the ice one.
For buckets with [versioning](../../../operations/buckets/versioning.md) enabled, the action will apply to the current object versions.
Path: `LifecycleConfiguration\Rule\Transition\`. ||
|| `StorageClass` | [Storage class](../../../concepts/storage-class.md) of the object It can be `COLD`, `STANDARD`, `ICE`, or `INTELLIGENT_TIERING`.
Path: `LifecycleConfiguration\Rule\Transition\StorageClass`. ||
|| `Expiration` | Rule for deleting an object from {{ objstorage-name }}.
Contains the `Days` or `Date` element that indicates when the action is due.<br/>It may also contain `ExpiredObjectDeleteMarker`, an expired object delete marker that indicates whether {{ objstorage-name }} will remove the delete marker if there are no non-current versions.
For buckets with versioning enabled, the action will apply to current versions of objects.
Path: `LifecycleConfiguration\Rule\Expiration`.||
|| `Date` | Date for the rule to apply.
The date should be in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DD`. The time is always 00:00 UTC.
Path: `LifecycleConfiguration\Rule\Expiration\Date`. ||
|| `Days` | Time interval for the rule to apply.
It is defined by the number of days since the object was uploaded.
The minimum value is `1`.
Path: `LifecycleConfiguration\Rule\Expiration\Days`. ||
|| `NoncurrentVersionTransition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of non-current object versions. This rule only applies to non-current versions of an object rather than the entire object.
It contains the `StorageClass` element, which defines the target storage class and the `NoncurrentDays` element, which sets when the action expires.
You can only move objects from the `STANDARD` storage to the `COLD`, `ICE`, or `INTELLIGENT_TIERING` one, and from the cold storage, to the ice one.
Path: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`. ||
|| `NoncurrentVersionExpiration` | Rule for deleting non-current object versions from {{ objstorage-name }}. This rule only applies to non-current versions of an object rather than the entire object.
It contains the `NoncurrentDays` element, which sets when the action expires.
Path: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`.
 
{% note tip %}

To remove [non-current delete markers](*noncurrent-delete-markers), use the `NoncurrentDeleteMarkers` lifecycle rule parameter. Only the [{{ yandex-cloud }} CLI](../../../operations/buckets/lifecycles.md#cli_1), [{{ yandex-cloud }} REST](../../../api-ref/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers), and [{{ yandex-cloud }} gRPC](../../../api-ref/grpc/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers) support this parameter.

{% endnote %}

||
|| `AbortIncompleteMultipartUpload` | Rule for deleting uploads that were not completed within the specified number of days.
It contains the `DaysAfterInitiation` element, which sets when the rule is to be applied.
Path: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\DaysAfterInitiation`. ||
|#


## Example {#example}

The rule below applies to all objects uploaded to the bucket as follows:

- They are moved to the cold storage 30 days after being uploaded to {{ objstorage-name }}.
- They are deleted from {{ objstorage-name }} 365 days after being uploaded.
- Incomplete uploads are deleted from {{ objstorage-name }} five days after the start of the object upload.

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Move and then delete</ID>
        <Status>Enabled</Status>
        <Filter>
           <Prefix></Prefix>
        </Filter>
        <Transition>
            <StorageClass>COLD</StorageClass>
            <Days>30</Days>
        </Transition>
        <Expiration>
            <Days>365</Days>
        </Expiration>
        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>5</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
    </Rule>
</LifecycleConfiguration>
```

#### Related articles {#related-articles}

* [{#T}](../../../concepts/lifecycles.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}

[*noncurrent-delete-markers]: {% include notitle [popups](../../../_includes_service/popups.md#noncurrent-delete-markers) %}
