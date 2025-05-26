---
title: How to enable origin shielding in {{ cdn-full-name }}
description: Follow this guide to enable origin shielding.
---

# Enabling origin shielding

To enable [origin shielding](../../concepts/origins-shielding.md) for a [resource](../../concepts/resource.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the resource name.
  1. Navigate to the **{{ ui-key.yacloud.cdn.label_shielding }}** tab.
  1. In the top-right corner, enable the origin shielding option.
  1. In the **{{ ui-key.yacloud.cdn.label_shielding-settings-title }}** window, select the required location in the **{{ ui-key.yacloud.cdn.label_shielding-location }}** field.
  1. Click **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.

  Once enabled, the shielding status will change from `Not activated` to `Active`.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
