---
title: Comparing schemas in a subject
description: Follow this guide to compare two schemas from different versions of a subject.
---

# Comparing schemas in a subject

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to compare schemas.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Select the namespace your schemas are residing in.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Select the subject you want to compare schemas for.
  1. Under **{{ ui-key.yacloud.schema-registry.label_versions }}**, select two schemas of the same type, such as `JSON`, and click ![image](../../_assets/console-icons/scales-unbalanced.svg) **{{ ui-key.yacloud.schema-registry.label_compare }}**.
  1. In the version comparison window, select the display mode: **{{ ui-key.yacloud.schema-registry.label_compare-mode-side-by-side }}** or **{{ ui-key.yacloud.schema-registry.label_compare-mode-single }}**. Additions will be highlighted in green and deletions in red.

{% endlist %}
