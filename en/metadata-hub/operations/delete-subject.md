---
title: Deleting a subject
description: Follow this guide to delete a subject.
---

# Deleting a subject



{% include notitle [preview](../../_includes/note-preview.md) %}



{% note warning %}

The subject will be deleted along with all the schemas uploaded into it.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to delete a subject.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace you want to delete a subject from.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) to the right of the subject you want to delete and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
