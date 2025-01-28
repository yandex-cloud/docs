1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
1. Click **{{ ui-key.yacloud.schema-registry.label_create-namespace-action }}**.
1. Specify the following parameters:
    * **{{ ui-key.yacloud.common.name }}**: Unique name of the namespace.
    * Optionally, add a namespace description.
    * **Compatibility check level**
        * `BACKWARD`: (Default) Consumers using the new schema can read data written by producers using the latest registered schema.
        * `BACKWARD_TRANSITIVE`: Consumers using the new schema can read data written by producers using all previously registered schemas.
        * `FORWARD`: Consumers using the latest registered schema can read data written by producers using the new schema.
        * `FORWARD_TRANSITIVE`: Consumers using all previously registered schemas can read data written by producers using the new schema.
        * `FULL`: New schema is forward and backward compatible with the latest registered schema.
        * `FULL_TRANSITIVE`: New schema is forward and backward compatible with all previously registered schemas.
        * `NONE`: Schema compatibility checks are disabled.
          For more information about schema compatibility types, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
    * **Compatibility check rules**: Select the types of schema checks you would like to have, i.e., [Confluent](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types) (default) or [Buf](https://buf-build-git-psachs-docs-and-search-bufbuild.vercel.app/docs/build/usage/).
1. Click **{{ ui-key.yacloud.common.create }}**.
