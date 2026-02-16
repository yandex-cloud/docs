1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
1. Click **{{ ui-key.yacloud.schema-registry.label_create-namespace-action }}**.
1. In the **{{ ui-key.yacloud.common.name }}** field, set a unique name for the namespace.
1. Optionally, add a namespace description.
1. Under **Compatibility parameters**:
    1. Set **Compatibility check level**:
        * `BACKWARD`: (Default) Consumers using the new schema can read data written by producers using the latest registered schema.
        * `BACKWARD_TRANSITIVE`: Consumers using the new schema can read data written by producers using all previously registered schemas.
        * `FORWARD`: Consumers using the latest registered schema can read data written by producers using the new schema.
        * `FORWARD_TRANSITIVE`: Consumers using all previously registered schemas can read data written by producers using the new schema.
        * `FULL`: New schema is forward and backward compatible with the latest registered schema.
        * `FULL_TRANSITIVE`: New schema is forward and backward compatible with all previously registered schemas.
        * `NONE`: Schema compatibility checks are disabled.
          For more information about schema compatibility types, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
    1. Select a [compatibility policy](../../metadata-hub/concepts/compatibility-check-policy.md) for JSON schemas:
        * `optional-friendly`: Based on a [solution](#optional-parameters-compatibility-solution) using various content models for the producer and the consumer. It supports adding or removing optional parameters while maintaining full transitive compatibility.
        * `Confluent`: Follows the [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types) standards and ensures no full compatibility when adding and removing optional parameters.
    1. Select a compatibility policy for Protobuf schemas:
        * `Confluent`: Based on the [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types) standards.
        * `buf`: Based on the Buf v1 standards.
1. Click **{{ ui-key.yacloud.common.create }}**.
