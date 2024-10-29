---
title: Adding a schema to an existing subject
description: Follow this guide to add a schema to a subject.
---

# Adding a schema to a subject

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to add a schema to a subject.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Namespace**.
  1. Select the namespace your schemas are residing in.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **Schemas**.
  1. Click **Upload schema**.
  1. Select the method for schema uploading into the existing subject and specify its name. You can copy the name from the ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Subjects** section by clicking ![image](../../_assets/console-icons/copy.svg) next to the subject's name.
  1. Set the schema format to [Avro](https://avro.apache.org/), [JSON Schema](https://json-schema.org/), or [Protobuf](https://protobuf.dev/) and attach the file.
  1. If a schema references another schema, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name under which the referenced schema is registered, and the registered subject's schema version.
  1. Select **Normalization** to apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization).
  1. If you want to skip schema compatibility checking, enable the relevant option.
  1. Click **Upload schema**.

{% endlist %}
