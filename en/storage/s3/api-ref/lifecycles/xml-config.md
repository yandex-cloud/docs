# Bucket object lifecycle configuration

{{ objstorage-name }} allows you to manage [object lifecycles](../../../concepts/lifecycles.md) in a bucket. To upload lifecycle configuration to {{ objstorage-name }}, you need to create an XML document as described in this section. You can obtain a document in this format by downloading an existing configuration.

General configuration format:

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Rule description</ID>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
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
            <NoncurrentDays>Migrating versions older than the specified number of days</NoncurrentDays>
        </NoncurrentVersionTransition>

        <NoncurrentVersionExpiration>
            <NoncurrentDays>Deleting versions older than the specified number of days</NoncurrentDays>
        </NoncurrentVersionExpiration>

        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>Deleting uploads not completed within the specified number of days</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    ...
</LifecycleConfiguration>
```

A configuration may contain up to 1000 rules.

## Elements {#elements}

| Element | Description |
| ----- | ----- |
| `LifecycleConfiguration` | Root element of an XML document.<br/><br/>It may contain up to 1000 `Rule` elements.<br/><br/>Path: `LifecycleConfiguration`. |
| `Rule` | Rule description.<br/><br/>Objects that meet the rule are set by the `Filter` element. Actions on objects are defined by the `Transition` and `Expiration` elements. There can be multiple actions of each type.<br/><br/>Path: `LifecycleConfiguration\Rule`. |
| `ID` | Unique rule ID.<br/><br/>Any text up to 255 characters long, e.g., "Delete in 20 days". An optional parameter that you can use to search for a rule in a configuration.<br/><br/>If no ID is specified, {{ objstorage-name }} generates one automatically.<br/><br/>Path: `LifecycleConfiguration\Rule\ID`. |
| `Status` | Rule status.<br/><br/>You can activate a rule by setting `<Status>Enabled</Status>` or deactivate it by setting `<Status>Disabled</Status>`.<br/><br/>Path: `LifecycleConfiguration\Rule\Status`. |
| `Filter` | Object filter.<br/><br/>Contains no more than one element of each type: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, or `Tag`.<br/><br/>If an empty `<Filter></Filter>` is set, the rule applies to all bucket objects.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter`. |
| `ObjectSizeGreaterThan` | Minimum object size in bytes.<br/><br/>The rule applies to objects whose size is greater than or equal to the set one.<br/><br/>A filter may only contain one minimum object size.<br/><br/>Path:`LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`. |
| `ObjectSizeLessThan` | Maximum object size in bytes.<br/><br/>The rule applies to objects whose size is less than or equal to the set one.<br/><br/>A filter may only contain one maximum object size.<br/><br/>Path:`LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`. |
| `Prefix` | Key prefix.<br/><br/>The rule applies to objects with the specified key prefix.<br/><br/>Sample prefixes for the key `some/long/object/key`: `some`, `some/`, and `some/lo`.<br/><br/>A filter may only contain one prefix.<br/><br/>Do not use it together with the `Tag` filter.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Prefix`. |
| `Tag` | [Object's tag](../../../concepts/tags.md#object-tags)<br/><br/>The rule applies to objects that have been assigned the specified tag.<br/><br/>The filter can only contain one object tag.<br/><br/>It cannot be used with the `Prefix` filter.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag`. |
| `Key` | Object tag key<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Key`. |
| `Value` | Object tag value<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Tag\Value`. |
| `Transition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of an object.<br/><br/>It contains the `StorageClass` element that defines the target storage class and the `Date` or `Days` element that determines when the action expires.<br/><br/>You can move objects from `STANDARD` to `COLD` or `ICE` storage and from COLD to ICE storage.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\`. |
| `StorageClass` | [Storage class](../../../concepts/storage-class.md) of the object.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\StorageClass`. |
| `Expiration` | Rule for deleting an object from {{ objstorage-name }}.<br/><br/>Contains the `Days` or `Date` element that sets the action expiry.<br/>It may also contain `ExpiredObjectDeleteMarker`: An expired object delete marker that indicates whether {{ objstorage-name }} will remove the delete marker if there aren't any non-current versions.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration`. |
| `Date` | Rule execution date.<br/><br/>Format: [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), for example, `YYYY-MM-DD`. Time is always 00:00 UTC.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Date`. |
| `Days` | Rule execution interval.<br/><br/>This is defined by the number of days since the object was uploaded.<br/><br/>Minimum value: 1.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Days`. |
| `NoncurrentVersionTransition` | Rule for changing the [storage class](../../../concepts/storage-class.md) of non-current object versions. This rule only applies to non-current versions of an object rather than to the entire object.<br/><br/>It contains the `StorageClass` element that defines the target storage class and the `NoncurrentDays` element that sets the action expiry.<br/><br/>You can move objects from `STANDARD` to `COLD` or `ICE` storage and from `COLD` to `ICE` storage.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`. |
| `NoncurrentVersionExpiration` | Rule for deleting non-current object versions from {{ objstorage-name }}. This rule only applies to non-current versions of an object rather than the entire object.<br/><br/>Contains the `NoncurrentDays` element that sets the action expiry.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`. |
| `AbortIncompleteMultipartUpload` | Rule for deleting uploads not completed within the specified number of days.<br/><br/>Contains the `DaysAfterInitiation` element that sets when the rule applies.<br/><br/>Path: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\` `DaysAfterInitiation`. |

## Example {#example}

The rule below applies to all objects uploaded to the bucket as follows:

- They are moved to cold storage 30 days after being uploaded to {{ objstorage-name }}.
- They are deleted from {{ objstorage-name }} 365 days after being uploaded.
- Deleting incomplete uploads from {{ objstorage-name }} five days after the start of the object upload.

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
