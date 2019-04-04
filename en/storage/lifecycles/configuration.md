# Bucket object lifecycle configuration

To pass a lifecycle configuration through the [HTTP API compatible with Amazon S3](../s3/index.md), it should be formatted as an XML document of the following type:

```
<LifecycleConfiguration>
    <Rule>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
           <Prefix>key_ prefix</Prefix>
        </Filter>
        <Expiration>
            <!-- <Date> or <Days> -->
        </Expiration>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    …
</LifecycleConfiguration>
```

A configuration can contain up to 1,000 rules.

## Possible elements

| Element | Description |
| ----- | ----- |
| `Date` | Date on which [!KEYREF objstorage-name] will perform an action.<br/><br/> It must be in ISO 8601 format such as `YYYY-MM-DD`. Time: always 00:00 UTC.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Date`. |
| `Days` | Determines the number of days after loading an object when the rule becomes applicable.<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration\Days`. |
| `Expiration` | Contains the `<Days>` and/or `<Date>` elements that determine when to delete an object from [!KEYREF objstorage-name].<br/><br/>Path: `LifecycleConfiguration\Rule\Expiration`. |
| `Filter` | Contains no more than one `Prefix` element.<br/><br/>If an empty `<Filter></Filter>` is set, the rule will apply to all bucket elements.<br/><br/>Path: `LifecycleConfiguration\Rule\Filter`. |
| `ID` | Unique rule ID.<br/><br/>The maximum ID length is 255 characters. Optional parameter. You can use it to search for a rule in a configuration.<br/><br/>Path: `LifecycleConfiguration\Rule\ID`. |
| `LifecycleConfiguration` | Root element of an XML document. It can contain up to 1,000 elements `<Rule>`.<br/><br/>Path: `LifecycleConfiguration`. |
| `Prefix` | Prefix of the key that is used for object filtering when applying the rule.<br/>For example, you can use any prefix for the `some/long/object/key` key, regardless of where slashes are placed in its name. In other words, when using any of the prefixes `some`, `some/`, or `some/long/obj`, the `some/long/object/key` key will match the rule. <br/><br/>A filter may have only one prefix.<br/><br/>Path:`LifecycleConfiguration\Rule\Filter\Prefix`. |
| `Rule` | Contains a description of a single rule.<br/><br/>Path: `LifecycleConfiguration\Rule`. |
| `Status` | You can activate a rule by setting `<Status>Enabled</Status>` or deactivate it by setting `<Status>Disabled</Status>`.<br/><br/>Path: `LifecycleConfiguration\Rule\Status`. |

