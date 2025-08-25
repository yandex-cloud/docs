---
title: Adding a schema to an existing subject
description: Follow this guide to add a schema to a subject.
---

# Adding a schema to an existing subject



{% include notitle [preview](../../_includes/note-preview.md) %}



You can upload a schema to an existing subject from the [subject page](#from-subject-page) or the [schema list page](#from-schema-list).

## Adding a schema from the subject page {#from-subject-page}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to add a schema to a subject.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace where the subject is located.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Click the subject name. Then, in the top-right corner, click ![add](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.
  1. Click **{{ ui-key.yacloud.component.dyn-string-field.button-upload_file }}** and attach your file.
  1. If a schema references another schema, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name the schema is registered under for linking, and the subject version containing the referenced schema.
  1. To apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), enable the **Normalization** setting.
  1. If you want to skip the schema compatibility check, enable the relevant option.
  1. Click **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.

{% endlist %}

## Adding a schema from the scema list page {#from-schema-list}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to add a schema to a subject.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace where the subject is located.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
  1. Click **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.
  1. Select the schema uploading method: into an existing subject.
  1. In the **Name** field, select a subject from the list.
  1. Click **{{ ui-key.yacloud.component.dyn-string-field.button-upload_file }}** and attach your file.
  1. If a schema references another schema, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name the schema is registered under for linking, and the subject version containing the referenced schema.
  1. To apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), enable the **Normalization** setting.
  1. If you want to skip the schema compatibility check, enable the relevant option.
  1. Click **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.

{% endlist %}
