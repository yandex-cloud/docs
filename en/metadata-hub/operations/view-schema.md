---
title: Viewing a schema
description: Follow this guide to view a schema.
---

# Viewing a schema



{% include notitle [preview](../../_includes/note-preview.md) %}



You can view a schema from the [subject page](#from-subject-page) or the [schema list page](#from-schema-list).

## Viewing a schema from the subject page {#from-subject-page}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the schema is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace where the schema is located.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Select the subject where the schema is located.
  1. Under **{{ ui-key.yacloud.schema-registry.label_versions }}**, select the schema you want to view.

{% endlist %}

## Viewing a schema from the scema list page {#from-schema-list}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the schema is in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace where the schema is located.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
  1. Select the schema you want to view.

{% endlist %}