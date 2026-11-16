---
title: Посмотреть статистику CDN-ресурса
description: Следуя данной инструкции, вы сможете посмотреть статистику CDN-ресурса.
---

# Просмотр статистики CDN-ресурса

{{ cdn-name }} автоматически отправляет метрики работы CDN-ресурса в [{{ metrics-name }}](../../../monium/metrics/overview.md) — в [проект каталога](*monium-folder-project), в котором находится ресурс.

Метрики {{ cdn-short-name }} обновляются в среднем раз в 3 минуты.

Полный список метрик представлен в [справочнике](../../metrics-yc.md).

## Посмотреть общую статистику на странице CDN-ресурса {#cdn-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан CDN-ресурс.
  1. [Перейдите]({{ link-console-main }}/link/cdn) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите CDN-ресурс, статистику которого вы хотите посмотреть.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя, 1 месяц.

      На вкладке отображаются следующие графики:

      * **Requests** — количество запросов к CDN-серверам в секунду.
      * **Origin_requests** — количество запросов к источникам в секунду.
      * **Bandwidth** — скорость соединения клиентов с CDN-серверами.
      * **Origin_bandwidth** — скорость соединения CDN-серверов с [источником](../../concepts/origins.md).
      * **Requests_codes** — количество ответов с HTTP-кодами от CDN-серверов.
      * **Origin_requests_codes** — количество ответов с HTTP-кодами от источников.
      * **Requests_total** — общее количество запросов к CDN-серверам.
      * **Requests_waf_blocked/waf_passed** — общее количество запросов к CDN-серверам, разрешенных и заблокированных WAF CDN-провайдера.
      * **Hit_bytes** — объем кешированного трафика.
      * **Hit_ratio** — соотношение кешированного трафика.

{% endlist %}

## Посмотреть подробную статистику в {{ monium-name }} {#monitoring}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Откройте [{{ monium-name }}]({{ link-monium }}).
  1. На панели сверху выберите [проект каталога](*monium-folder-project), в котором находится CDN-ресурс.
  1. На панели слева выберите ![compass](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![rectangle-pulse](../../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Задайте временной интервал для просмотра метрик.
  1. В строке запроса выберите метки:

      * `project` — `folder__<идентификатор_каталога>` для каталога с CDN-ресурсом. По умолчанию указан проект, выбранный на панели сверху.
      * `cluster` — `default`.
      * `service` — `__cdn__`.
      * `name` — имя метрики из [справочника](../../metrics-yc.md), например `edge.requests` для количества запросов к CDN-серверам в секунду.
      * `resource` — [идентификатор CDN-ресурса](get-resources-info.md).

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

{% endlist %}


Подробнее о работе с графиками — в инструкции [{#T}](../../../monium/metrics/metric-explorer.md).


[*monium-folder-project]: {% include [folder-project](../../../_includes/monium/folder-project.md) %}
