---
title: Viewing a list of namespaces
description: Follow this guide to view namespaces.
---

# Viewing a list of namespaces



{% include notitle [preview](../../_includes/note-preview.md) %}



{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to edit a namespace in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.

  Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) to the right of a selected namespace to [connect](connect-to-namespace.md) to, [update](update-name-space.md), or [delete](delete-name-space.md) it.

  In the list of namespaces, apart from the properties set on namespace creation, you can also find and copy the namespace _ID_ to manage data schemas across {{ yandex-cloud }}.

{% endlist %}
