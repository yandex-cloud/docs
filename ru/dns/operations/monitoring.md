---
title: Мониторинг зон DNS
description: Следуя данной инструкции, вы сможете посмотреть метрики зон и запросов.
---

# Мониторинг зон DNS

Метрики зоны DNS автоматически передаются в [{{ metrics-name }}](../../monium/metrics/overview.md) — в [проект каталога](*monium-folder-project), в котором находится зона.

Вы можете посмотреть общую статистику работы на [странице зоны](#zone-ui) или подробную статистику в [интерфейсе {{ monium-name }}](#monitoring).

Полный список метрик представлен в [справочнике](../metrics.md).

## Посмотреть статистику запросов к зоне на странице зоны {#zone-ui}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная зона.
  1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите на зону, статистику которой вы хотите посмотреть.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя или 1 месяц.

      На вкладке отображается график **Zone requests** — количество запросов к зоне в секунду.

{% endlist %}

## Посмотреть подробную статистику в {{ monium-name }} {#monitoring}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  Для перехода в [{{ monium-name }}]({{ link-monium }}) на странице зоны нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** ![image](../../_assets/console-icons/arrow-up-right-from-square.svg) или воспользуйтесь пошаговой инструкцией:

  1. Откройте [{{ monium-name }}]({{ link-monium }}).
  1. На панели сверху выберите [проект каталога](*monium-folder-project), в котором находится зона.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В открывшемся списке выберите **DNS — Zone overview**.
  1. В поле **DNS Zone** укажите [идентификатор нужной зоны](zone-get-info.md).
  1. Выберите временной промежуток, за который хотите посмотреть статистику.

{% endlist %}


Чтобы изменить графики или создать редактируемую копию дашборда, воспользуйтесь [инструкцией по работе с сервисными дашбордами](../../monium/operations/dashboard/service-dashboards.md).


[*monium-folder-project]: {% include [folder-project](../../_includes/monium/folder-project.md) %}
