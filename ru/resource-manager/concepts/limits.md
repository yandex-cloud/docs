---
title: Квоты и лимиты в {{ resmgr-full-name }}
description: "Квоты и лимиты для сервиса {{ resmgr-full-name }} не определены."

editable: false
---

# Квоты и лимиты в {{ resmgr-name }}
{% if product == "yandex-cloud" %}

{% include [resource-manager-limits.md](../../_includes/resource-manager-limits.md) %}

{% endif %}
{% if product == "cloud-il" %}

   На стадии [Preview](../../overview/concepts/launch-stages.md) действует ограничение: доступна только 1 организация и 1 облако.

{% endif %}