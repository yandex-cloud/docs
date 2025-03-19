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
                    <Key>tag key</Key>
                    <Value>tag value</Value>
                </Tag>
                ...
            </And>
            <ObjectSizeGreaterThan>minimum object size</ObjectSizeGreaterThan>
            <ObjectSizeLessThan>maximum object size</ObjectSizeLessThan>
            <Prefix>key prefix</Prefix>
            <Tag>
                <Key>tag key</Key>
                <Value>tag value</Value>
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
`LifecycleConfiguration` | Root element of an XML document.<br/><br/>It can contain up to 1,000 `Rule` elements.<br/><br/>Path: `LifecycleConfiguration`.
`Rule` | Rule description.<br/><br/>The `Filter` element specifies objects that meet the rule. The `Transition` and `Expiration` elements define actions on objects. There can be multiple actions of each type.<br/><br/>Path: `LifecycleConfiguration\Rule`.
`ID` | Unique rule ID.<br/><br/>Any text up to 255 characters long, e.g., _Delete in 20 days_. It is an optional parameter that you can use to search for a rule in a configuration.<br/><br/>If the ID is not specified, {{ objstorage-name }} generates it automatically.<br/><br/>Path: `LifecycleConfiguration\Rule\ID`.
`Status` | Rule status.<br/><br/>You can activate a rule by setting `<Status>Enabled</Status>` or deactivate it by setting `<Status>Disabled</Status>`.<br/><br/>Path: `LifecycleConfiguration\Rule\Status`.
`Filter` | Object filter.<br/><br/>It may only contain one element of each type: `And`, `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, or `Tag`.<br/><br/>If an empty `<Filter></Filter>` filter is set, the rule applies to all objects in a bucket.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter`.
`ObjectSizeGreaterThan` | Minimum object size in bytes.<br/><br/>The rule applies to objects with a size greater than or equal to the specified value.<br/><br/>The filter may contain only one minimum object size.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`.
`ObjectSizeLessThan` | Maximum object size in bytes.<br/><br/>The rule applies to objects with a size less than or equal to the specified value.<br/><br/>The filter may contain only one maximum object size.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`.
`Prefix` | Key prefix.<br/><br/>The rule applies to objects with the specified key prefix.<br/><br/>For example, the `some/long/object/key` key may have these prefixes: `some`, `some/`, or `some/lo`.<br/><br/>The filter may contain only one prefix.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Prefix`.
`Tag` | Object [label](../../../concepts/tags.md#object-tags).<br/><br/>The rule applies to objects with the specified label assigned.<br/><br/>The filter may contain only one object label.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag`.
`And` | Logical `AND` for filters.<br/><br/>This filter may contain any combination of the following elements: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, and `Tag`.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\And`.
`Key` | Object label key.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Key`.
`Value` | Object label value.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Value`.
`Transition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of an object.<br/><br/>It contains the `StorageClass` element, which defines the target storage class and the `Date` or `Days` element, which sets when the action expires.<br/><br/>You can only move objects from the `STANDARD` storage to the `COLD` or `ICE` one, and from the cold storage, to the ice one.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\`.
`StorageClass` | [Storage class](../../../concepts/storage-class.md) of an object.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\StorageClass`.
`Expiration` | Rule for deleting an object from {{ objstorage-name }}.<br/><br/>It contains the `Days` or `Date` element, which sets when the action expires.<br/>It may also contain `ExpiredObjectDeleteMarker`: an expired object delete marker that indicates whether {{ objstorage-name }} will remove the delete marker if there are not any non-current versions.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration`.
`Date` | Date for the rule to apply.<br/><br/>The date should be in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DD`. The time is always 00:00 UTC.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Date`.
`Days` | Time interval for the rule to apply.<br/><br/>It is defined by the number of days since the object was uploaded.<br/><br/>The minimum value is `1`.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Days`.
`NoncurrentVersionTransition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of non-current object versions. This rule only applies to non-current versions of an object rather than the entire object.<br/><br/>It contains the `StorageClass` element, which defines the target storage class and the `NoncurrentDays` element, which sets when the action expires.<br/><br/>You can only move objects from the `STANDARD` storage to the `COLD` or `ICE` one, and from the cold storage, to the ice one.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`.
`NoncurrentVersionExpiration` | Rule for deleting non-current object versions from {{ objstorage-name }}. This rule only applies to non-current versions of an object rather than the entire object.<br/><br/>It contains the `NoncurrentDays` element, which sets when the action expires.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`.
`AbortIncompleteMultipartUpload` | Rule for deleting uploads that were not completed within the specified number of days.<br/><br/>It contains the `DaysAfterInitiation` element, which sets when the rule is to be applied.<br/><br/>Path: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\`.

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