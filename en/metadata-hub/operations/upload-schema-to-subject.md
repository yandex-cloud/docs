---
title: Uploading a schema to a new subject
description: Follow this guide to upload a schema and create a subject.
---

# Uploading a schema to a new subject

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to upload a schema to a subject.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}**.
  1. Select the namespace you want to upload a schema for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **Schemas**.
  1. Click **Upload schema**.
  1. Select the method for schema uploading into the new subject and specify the following parameters:
      * **Name**: Unique subject name.
      * (Optional) Add a description for the subject.
      * **Compatibility check level**: Specify if you want to override the level specified for the [namespace](create-name-space.md). You can override the level only for the current subject.
        * `BACKWARD`: (Default) Consumers using the new schema can read data written by producers using the latest registered schema.
        * `BACKWARD_TRANSITIVE`: Consumers using the new schema can read data written by producers using all previously registered schemas.
        * `FORWARD`: Consumers using the latest registered schema can read data written by producers using the new schema.
        * `FORWARD_TRANSITIVE`: Consumers using all previously registered schemas can read data written by producers using the new schema.
        * `FULL`: New schema is forward and backward compatible with the latest registered schema.
        * `FULL_TRANSITIVE`: New schema is forward and backward compatible with all previously registered schemas.
        * `NONE`: Schema compatibility checks are disabled.
          For more information about schema compatibility types, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
  1. Set the data format to [Protobuf](https://protobuf.dev/), [Avro](https://avro.apache.org/), or [JSON Schema](https://json-schema.org/) and attach the file.
  1. If a schema references another schema, in the **References** section, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name the schema is registered under for linking, and the subject version containing the referenced schema.
  1. To apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), enable the **Normalization** setting.
  1. If you want to skip schema compatibility checking, enable the relevant option.
  1. Click **Upload schema**.

{% endlist %}
