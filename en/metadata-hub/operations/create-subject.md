---
title: Creating a subject
description: Follow this guide to create a subject.
---

# Creating a subject

You can create a subject:

* On the **Subjects** tab, [independently from a schema](#create-new-separate-subject).
* [When uploading a new schema](#create-subject-during-schema-upload).

## Creating a subject independently from a schema {#create-new-separate-subject}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a subject.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace you want to create a subject in.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.schema-registry.label_create-subject-action }}**.
  1. Specify the following parameters:
      * Subject name and description.
      * **Compatibility check level**:
          * `BACKWARD`: (Default) Consumers using the new schema can read data written by producers using the latest registered schema.
          * `BACKWARD_TRANSITIVE`: Consumers using the new schema can read data written by producers using all previously registered schemas.
          * `FORWARD`: Consumers using the latest registered schema can read data written by producers using the new schema.
          * `FORWARD_TRANSITIVE`: Consumers using all previously registered schemas can read data written by producers using the new schema.
          * `FULL`: New schema is forward and backward compatible with the latest registered schema.
          * `FULL_TRANSITIVE`: New schema is forward and backward compatible with all previously registered schemas.
          * `NONE`: Schema compatibility checks are disabled.
          For more information about schema compatibility types, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
      * Under **Schema**:
          * Set the schema format to [Protobuf](https://protobuf.dev/), [Avro](https://avro.apache.org/), or [JSON Schema](https://json-schema.org/) and attach the file.
          * If a schema references another schema, in the **References** section, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name the schema for is registered under for linking, and the registered subject's schema version.
          * To apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), enable the **Normalization** setting.
          * If you want to skip schema compatibility checking, enable the relevant option.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Creating a subject when uploading a schema {#create-subject-during-schema-upload}

To create a subject when uploading a schema, select **New** in the **Subject** field and specify the subject parameters: name, description, and compatibility check level. For more information on how to creatie a subject when uploading a schema, see [this guide](upload-schema-to-subject.md).

