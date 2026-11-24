---
title: Как посмотреть статистику резервного копирования в {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть статистику резервного копирования в {{ backup-full-name }}.
---

# Посмотреть статистику резервного копирования


{{ backup-name }} автоматически передает в [{{ metrics-name }}](../../monium/metrics/overview.md) метрики количества [защищаемых ресурсов](../concepts/index.md#protected-resources) и объема хранилища, занятого резервными копиями.

Чтобы посмотреть статистику:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. [Перейдите]({{ link-monium }}) в {{ monium-name }}.
  1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), соответствующий [каталогу](../../resource-manager/concepts/resources-hierarchy.md#folder) с защищаемыми ресурсами.

      Идентификатор проекта имеет вид `folder__<идентификатор_каталога>`.
  1. На панели слева выберите ![layout-cells-large](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В открывшемся списке выберите сервисный дашборд **{{ backup-name }}**.
  1. В поле **Resource name** выберите защищаемый ресурс, для которого вы хотите посмотреть статистику.

      Чтобы посмотреть общую статистику по всем защищаемым ресурсам в каталоге, выберите `*`.
  1. Выберите временной промежуток, за который хотите посмотреть статистику.
  1. Если нужно обновить дашборд, нажмите кнопку ![arrows-rotate-right](../../_assets/console-icons/arrows-rotate-right.svg). Также рядом с кнопкой вы можете задать частоту автообновления статистики.

{% endlist %}

{% note tip %}

Кроме просмотра метрик вы можете [настроить](configure-alerts.md) алерты, чтобы получать уведомления об изменениях метрик.

{% endnote %}

#### Полезные ссылки {#see-also}

* [{#T}](configure-alerts.md)
* [{#T}](../metrics.md)
