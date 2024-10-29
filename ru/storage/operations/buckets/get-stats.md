---
title: Просмотр метрик бакета в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть метрики бакета в {{ objstorage-name }}.
---

# Просмотр метрик бакета

{{ objstorage-name }} автоматически отправляет метрики работы бакетов в сервис [{{ monitoring-full-name }}](../../../monitoring).

Вы можете посмотреть общую статистику работы на [странице бакета](#storage-ui) или подробно в [интерфейсе {{ monitoring-name }}](#monitoring).

Полный список метрик представлен в [справочнике](../../metrics.md).

## Посмотреть общую статистику на странице бакета {#storage-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, статистику которого вы хотите посмотреть.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя, 1 месяц. 

      {% include [storage-monitoring-dashboards](../../_includes_service/storage-monitoring-dashboards.md) %}

{% endlist %}

## Посмотреть подробную статистику в {{ monitoring-name }} {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. На панели слева выберите ![image](../../../_assets/monitoring/concepts/visualization/legend-goto-chart.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. В строке запроса выберите параметры:
      1. Сервис **{{ objstorage-name }}**.
      1. Метрику, значения которой вы хотите визуализировать.
      1. Метку для метрики.

{% endlist %}