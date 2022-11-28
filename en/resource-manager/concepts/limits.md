---
title: "Quotas and limits in {{ resmgr-full-name }}"
description: "There are no quotas or limits for {{ resmgr-full-name }}."

editable: false
---

# Quotas and limits in {{ resmgr-name }}
{% if product == "yandex-cloud" %}

{% include [resource-manager-limits.md](../../_includes/resource-manager-limits.md) %}

{% endif %}
{% if product == "cloud-il" %}

At the [Preview](../../overview/concepts/launch-stages.md) stage, the following limitation applies: only one organization and one cloud are available.

{% endif %}