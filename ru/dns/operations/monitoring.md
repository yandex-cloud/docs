---
title: Мониторинг зон DNS
description: Следуя данной инструкции, вы сможете посмотреть метрики зон и запросов.
---

# Мониторинг зон DNS

{{ dns-name }} автоматически отправляет метрики зон и запросов в сервис [{{ monitoring-full-name }}](../../monitoring).

Вы можете посмотреть общую статистику работы на [странице зоны](#zone-ui) или подробную статистику в [интерфейсе {{ monium-full-name }}](#monitoring).

Полный список метрик представлен в [справочнике](../metrics.md).

## Посмотреть статистику запросов к зоне на странице зоны {#zone-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная зона.
  1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите на зону, статистику которой вы хотите посмотреть.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя или 1 месяц.

      На вкладке отобразится дашборд **Zone requests** — количество запросов, пришедших в выбранную зону, за выбранный промежуток времени.

{% endlist %}

## Посмотреть подробную статистику в {{ monium-full-name }} {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Для перехода в [{{ monium-name }}]({{ link-monium }}) на странице зоны нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** ![image](../../_assets/console-icons/arrow-up-right-from-square.svg) или воспользуйтесь пошаговой инструкцией:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана зона.
  1. [Перейдите]({{ link-monium }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
  1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В списке сервисов нажмите **DNS — Zone overview**.
  1. В поле **DNS Zone** укажите идентификатор нужной зоны.
  1. Выберите временной промежуток, за который хотите посмотреть статистику.

{% endlist %}