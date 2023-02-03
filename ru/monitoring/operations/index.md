# Пошаговые инструкции для {{ monitoring-full-name }}

## Работа с метриками {#working-with-metrics}

{% if audience == "external" %}

* [{#T}](unified-agent/linux_metrics.md)
* [{#T}](unified-agent/pull_prometheus.md)
* [{#T}](unified-agent/haproxy.md)
* [{#T}](unified-agent/non-yc.md)
* [{#T}](metric/add.md)
* [{#T}](metric/list.md)
* [{#T}](metric/get.md)
* [{#T}](metric/prometheusExport.md)

{% endif %}

{% if audience == "internal" %}

* [{#T}](metric/push.md)
* [{#T}](metric/data.md)
* [{#T}](metric/deletion.md)
* [{#T}](metric/troubleshooting.md)

{% endif %}

## Работа с дашбордами {#working-with-dashboards}

{% if audience == "external" %}

* [{#T}](dashboard/create.md)
* [{#T}](dashboard/copy.md)
* [{#T}](dashboard/add-widget.md)
* [{#T}](dashboard/delete-widget.md)
* [{#T}](dashboard/delete-dashboard.md)
* [{#T}](dashboard/api-examples.md)

{% endif %}

{% if audience == "internal" %}

* [{#T}](dashboard/examples.md)

{% endif %}

## Работа с алертами {#working-with-alerts}

{% if audience == "external" %}

* [{#T}](alert/create-alert.md)
* [{#T}](alert/create-channel.md)
* [{#T}](alert/delete-alert.md)

{% endif %}

{% if audience == "internal" %}

* [{#T}](alert/create.md)
* [{#T}](alert/false.md)
* [{#T}](alert/no_data.md)
* [{#T}](alert/slow.md)
* [{#T}](alert/historical.md)

{% endif %}
