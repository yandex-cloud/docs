---
title: Deleting a namespace
description: Follow this guide to delete a namespace.
---

# Deleting a namespace

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to delete a namespace.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Namespace**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) to the right of the namespace you want to delete and select **Delete**.

After you delete the namespace, all subjects and data schemas related to that namespace will be deleted as well.

{% endlist %}
