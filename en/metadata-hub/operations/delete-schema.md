---
title: Deleting a schema
description: Follow this guide to delete a schema.
---

# Deleting a schema

{% include notitle [preview](../../_includes/note-preview.md) %}

{% note warning %}

If there is only one schema in a subject, deleting that schema will also delete the subject.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace you want to delete a schema from.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) to the right of the schema you want to delete and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
