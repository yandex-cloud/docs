If a `Confluent` [compatibility check policy](../../metadata-hub/concepts/compatibility-check-policy.md) is configured at the namespace level, the following errors may occur when adding or deleting optional parameters in the schema:

* `PROPERTY_ADDED_TO_OPEN_CONTENT_MODEL`
* `PROPERTY_REMOVED_FROM_CLOSED_CONTENT_MODEL`

**Solution**
The `Confluent` compatibility check policy is based on the Confluent Schema Registry standards and implements mathematically accurate compatibility checks. This policy does not allow adding or removing optional parameters in `object` fields, causing the errors mentioned above.

To add or delete optional parameters, select the `optional-friendly` JSON compatibility check policy in the [namespace](../../metadata-hub/operations/update-name-space.md). It is based on [using various content models](../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution) for the producer and the consumer, where only the producer schema is registered. The compatibility check involves converting the consumer schema from an open content model to a closed one and comparing it with the registered producer schemas. This enables you to add or remove optional parameters while maintaining full transitive compatibility.
