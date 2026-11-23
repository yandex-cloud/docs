---
title: Просмотр аудитных логов {{ at-name }} в {{ monium-full-name }}
description: Как посмотреть аудитные логи {{ at-name }} в {{ monium-name }}.
---

# Просмотр аудитных логов {{ at-name }} в {{ monium-name }}

[Создайте трейл](../operations/create-trail.md#monium) с загрузкой аудитных логов в {{ monium-name }} или [измените назначение](../operations/manage-trail.md#update-trail) существующего трейла.

Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с трейлом.

{% list tabs group=audit-trails-destination %}

- {{ monium-name }} {#monium}

  {% include [view-logs-monium](../../_includes/audit-trails/view-logs-monium.md) %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](search-cloud-logging.md)
* [{#T}](../concepts/format.md)
* [{#T}](../concepts/format-data-plane.md)
