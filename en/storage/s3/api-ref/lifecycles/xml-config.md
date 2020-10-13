# Bucket object lifecycle configuration

{{ objstorage-name }} lets you manage [lifecycles](../../../concepts/lifecycles.md) for objects in buckets. To upload the lifecycle configuration to {{ objstorage-name }}, you need to create an XML document as described in this section. You can obtain a document in this format by downloading an existing configuration.

General configuration format:

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Rule description</ID>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
           <Prefix>key_ prefix</Prefix>
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

A configuration may contain up to 1000 rules.

## Elements {#elements}

| Element | Description |
| ----- | ----- |
| `AbortIncompleteMultipartUpload` | Rule for deleting uploads not completed within the specified number of days.<br/><br/>Contains the `DaysAfterInitiation` element that sets when the rule applies.<br/><br/>Path: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\DaysAfterInitiation`. |
| `Date` | Date of rule execution.<br/><br/>Format: [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601), for example, `YYYY-MM-DD`. Time is always 00:00 UTC.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Date`. |
| `Days` | Rule execution interval.<br/><br/>This is defined by the number of days since the object was uploaded.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Days`. |
| `Expiration` | Rule for deleting an object from {{ objstorage-name }}.<br/><br/>Contains the `Days` or `Date` element that sets the action expiry.<br/>It may also contain `ExpiredObjectDeleteMarker`: An expired object delete marker that indicates whether {{ objstorage-name }} will remove the delete marker if there aren't any non-current versions.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration`. |
| `Filter` | Object filter.<br/><br/>Contains no more than one `Prefix` element. If an empty `<Filter></Filter>` filter is set, the rule applies to all objects in a bucket.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter`. |
| `ID` | Unique rule ID.<br/><br/>Custom text up to 255 characters long, such as "Delete in 20 days". An optional parameter that you can use to search for a rule in a configuration.<br/><br/>If no ID is specified, {{objstorage-name}} generates one automatically.<br/><br/>Path: `LifecycleConfiguration\Rule\ID`. |
| `LifecycleConfiguration` | Root element of an XML document.<br/><br/>It may contain up to 1000 `Rule` elements.<br/><br/>Path: `LifecycleConfiguration`. |
| `Prefix` | Key prefix.<br/><br/>You can use it to filter objects that meet the rule.<br/><br/>Examples of prefixes for the key `some/long/object/key`: `some`, `some/`, `some/lo`.<br/><br/>Filters can only contain one prefix.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter\Prefix`. |
| `Rule` | Rule description.<br/><br/>Objects that meet the rule are set by the `Filter` element. Actions on objects are defined by the `Transition` and `Expiration` elements. There can be multiple actions of each type.<br/><br/>Path: `LifecycleConfiguration\Rule`. |
| `Status` | Rule status.<br/><br/>You can activate a rule by setting `<Status>Enabled</Status>` for it, or disable it by setting `<Status>Disabled</Status>`.<br/><br/>Path: `LifecycleConfiguration\Rule\Status`. |
| `StorageClass` | [Storage class](../../../concepts/storage-class.md) of an object.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\StorageClass`. |
| `Transition` | The rule to change the [storage class](../../../concepts/storage-class.md) of an object.<br/><br/>It contains the `StorageClass` element, which defines the target storage class and the `Date` or `Days` element, which sets when the action expires.<br/><br/>You can only move objects from standard to cold storage.<br/><br/>Path: `LifecycleConfiguration\Rule\Transition\`. |
| `NoncurrentVersionTransition` | The rule to change the [storage class](../../../concepts/storage-class.md) for non-current object versions. This rule only applies to non-current versions of an object rather than the entire object.<br/><br/>Contains the `StorageClass` element that sets the target storage class and the `NoncurrentDays` element that sets the action expiry.<br/><br/>You can only move objects from standard to cold storage.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`. |
| `NoncurrentVersionExpiration` | Rule for deleting non-current object versions from {{ objstorage-name }}. This rule only applies to non-current versions of an object rather than the entire object.<br/><br/>Contains the `NoncurrentDays` element that sets the action expiry.<br/><br/>Path: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`. |

## Example {#example}

The rule below applies to all objects uploaded to the bucket as follows:

- They are moved to cold storage 30 days after being uploaded to {{ objstorage-name }}.
- They are deleted from {{ objstorage-name }} 365 days after being uploaded.
- Deleting incomplete uploads from {{ objstorage-name }} 5 days after the start of the object upload.

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

