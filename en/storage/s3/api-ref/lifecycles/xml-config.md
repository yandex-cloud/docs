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

Element | Description
----- | -----
`LifecycleConfiguration` | Root element of the XML document.<br/><br/>It may contain up to 1,000 `Rule` elements.<br/><br/>Path: `LifecycleConfiguration`.
`Rule` | Rule description.<br/><br/>Objects covered by the rule are set using the `Filter` element. The `Transition` and `Expiration` elements define actions on objects. There can be multiple actions of each type.<br/><br/>Path: `LifecycleConfiguration\Rule`.
`ID` | Unique rule ID.<br/><br/>Any text up to 255 characters long, e.g., "Delete in 20 days". An optional parameter that you can use to search for a rule in a configuration.<br/><br/>If no ID is specified, {{ objstorage-name }} generates one automatically.<br/><br/>Path: `LifecycleConfiguration\Rule\ID`.
`Status` | Rule status.<br/><br/>You can activate a rule by setting `<Status>Enabled</Status>` or deactivate it by setting `<Status>Disabled</Status>`.<br/><br/>Path: `LifecycleConfiguration\Rule\Status`.
`Filter` | Object filter.<br/><br/>Contains no more than one element of each type: `And`, `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, `Tag`.<br/><br/>If you set an empty filter named (`<Filter></Filter>`), the rule will apply to all objects in the bucket.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter`.
`ObjectSizeGreaterThan` | Minimum object size in bytes.<br/><br/>The rule applies to objects whose size is greater than or equal to the specified one.<br/><br/>A filter may only contain one minimum object size.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`.
`ObjectSizeLessThan` | Maximum object size in bytes.<br/><br/>The rule applies to objects whose size is smaller than or equal to the specified one.<br/><br/>A filter may only contain one maximum object size.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`.
`Prefix` | Key prefix.<br/><br/>The rule applies to objects with the specified key prefix.<br/><br/>Examples of prefixes for a key named `some/long/object/key`: `some`, `some/`, and `some/lo`.<br/><br/>A filter may only contain one prefix.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Prefix`.
`Tag` | Object [tag](../../../concepts/tags.md#object-tags).<br/><br/>The rule applies to objects the specified tag is assigned to.<br/><br/>The filter may contain only one object tag.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag`.
`And` | `AND` logical operator for filters.<br/><br/>May contain any combination of the following elements: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, `Tag`.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\And`.
`Key` | Object tag key.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Key`.
`Value` | Object tag value.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Value`.
`Transition` | Rule for changing object [storage class](../../../concepts/storage-class.md).<br/><br/>Contains the `StorageClass` element that defines the target storage class and the `Date` or `Days` element for when the action will be executed.<br/><br/>You can move objects from `STANDARD` to `COLD` or `ICE` storage and from `COLD` to `ICE` storage.<br/><br/>For buckets with [versioning](../../../operations/buckets/versioning.md) enabled, the action will be applied to the current object versions.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\`.
`StorageClass` | Object [storage class](../../../concepts/storage-class.md).<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\StorageClass`.
`Expiration` | Rule for deleting an object from {{ objstorage-name }}.<br/><br/>Contains the `Days` or `Date` element representing the action execution date.<br/>It may also contain `ExpiredObjectDeleteMarker`, which is the expired object delete marker that indicates whether {{ objstorage-name }} will remove the delete marker if there are no non-current versions.<br/><br/>For buckets with versioning enabled, the action will be applied to the current object versions.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration`.
`Date` | Rule execution date.<br/><br/>Format: [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), e.g., `YYYY-MM-DD`. The time is always 00:00 UTC.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Date`.
`Days` | Rule execution interval.<br/><br/>Defined by the number of days since the object's upload.<br/><br/>Minimum value: 1.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Days`.
`NoncurrentVersionTransition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of non-current object versions. This rule applies only to non-current versions of the object rather than the whole object.<br/><br/>It contains the `StorageClass` element that defines the target storage class and the `NoncurrentDays` element that defines the action execution date.<br/><br/>You can move objects from `STANDARD` to `COLD` or `ICE` storage and from `COLD` to `ICE` storage.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`.
`NoncurrentVersionExpiration` | Rule for deleting non-current object versions from {{ objstorage-name }}. This rule applies only to non-current versions of the object rather than the whole object.<br/><br/>Contains the `NoncurrentDays` element that defines the action execution date.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`.
`AbortIncompleteMultipartUpload` | Rule for deleting uploads not completed within the specified number of days.<br/><br/>Contains the `DaysAfterInitiation` element which sets the rule execution time.<br/><br/>Path: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\` `DaysAfterInitiation`.

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

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}