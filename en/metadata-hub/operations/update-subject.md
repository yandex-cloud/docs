---
title: Editing subject settings
description: Follow this guide to edit subject settings.
---

# Editing subject settings

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to edit subject settings.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Namespace**.
  1. Select the namespace you want to edit a subject in.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Subjects**.
  1. Select the subject you want to edit.
  1. In the top-right corner of the page with the subject settings, click ![image](../../_assets/console-icons/pencil.svg) **Edit**.
  1. Edit [settings](create-subject.md) or [add a schema](add-schema.md). Then click **Save changes**.

{% endlist %}

{% note warning %}

Changing the schema type may result in incorrect schema version compatibility checks. 

{% endnote %}
