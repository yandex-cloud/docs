---
title: How to copy a configuration from one resource to another in {{ cdn-full-name }}
description: Follow this guide to copy a configuration from one resource to another.
---

# Copying a configuration from one resource to another

{% include [copy-configuration](../../../_includes/cdn/copy-configuration.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a resource.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. In the **Copy configuration** field, select an existing CDN resource whose settings you want to copy to a new one.
  1. If required, adjust the settings.

      {% note warning %}

      The **{{ ui-key.yacloud.cdn.label_personal-domain }}** parameter must be unique within the resources of one [CDN provider](../../concepts/providers.md).

      {% endnote %}

  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. If required, adjust the settings under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **Advanced**, then click **Continue**.

{% endlist %}

{% include [get-and-create-cname](../../../_includes/cdn/get-and-create-cname.md) %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [note-dns-aname](../../../_includes/cdn/note-dns-aname.md) %}

{% include [edge-center-features-note](../../../_includes/cdn/edge-center-features-note.md) %}