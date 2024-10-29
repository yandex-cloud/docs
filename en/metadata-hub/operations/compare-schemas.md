---
title: Comparing schema versions
description: Follow this guide to compare two versions of a subject's schema.
---

# Comparing schema versions

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to compare schema versions.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Namespace**.
  1. Select the namespace your schemas are residing in.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Subjects**.
  1. Select the subject you want to compare schemas for.
  1. Under **Versions**, select two schemas of the same type, such as `JSON`, and click ![image](../../_assets/console-icons/scales-unbalanced.svg) **Compare**.
  1. In the version comparison window, select the display mode: **Two versions** or **Last version**. Additions will be highlighted in green and deletions in red.

{% endlist %}
