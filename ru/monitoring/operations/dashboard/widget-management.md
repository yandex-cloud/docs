---
title: Как управлять элементами дашборда в {{ monitoring-full-name }}
description: Из статьи вы узнаете, как управлять элементами дашборда в {{ monitoring-name }}.
---

# Управление виджетами

Вы можете управлять виджетами на дашборде, например: дублировать, копировать на другой дашборд, делиться ссылкой на виджет. Для каждого типа виджетов доступен свой набор действий.

## График {#graph}

1. На главной странице сервиса выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и откройте дашборд или [создайте](../dashboard/create.md) дашборд. 
1. [Добавьте](../dashboard/add-widget.md#graph) и настройте график. 
1. Нажмите ![image](../../../_assets/console-icons/ellipsis.svg) в правом верхнем углу виджета. 
1. В появившемся меню выберите один из пунктов:

    - **{{ ui-key.yacloud_monitoring.actions.common.edit }}** — изменить запрос, тип графика и остальные параметры.
    - **{{ ui-key.yacloud_monitoring.actions.common.duplicate }}** — создать копию виджета на текущем дашборде.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}** — создать копию виджета на выбранном дашборде.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.addToSelection }}** — добавить виджет в список выбранных. После выбора нескольких виджетов их можно копировать в буфер и вставить на дашборд.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.share }}** — передать график в одном из форматов:
      - **Публикация** — ссылка на дашборд в сервисе {{ monitoring-name }}.
      - **Экспорт** — сохранить в `CSV` или `JSON`.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.share-screenshot-key-value }}**:
      - **Скопировать скриншот в буфер** — сохранить снимок графика в формате `PNG` в буфер обмена.
      - **Скопировать ссылку на скриншот** — сохранить снимок графика в формате `PNG` в хранилище {{ monitoring-name }} и скопировать в буфер ссылку на него.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.fix-time }}** — установить для графика постоянный временной диапазон: `1 час`, `1 день`, `1 неделя`, `1 месяц`.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.display-legend }}** — отобразить легенду графика.
    - **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}** — создать алерт по запросу графика.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.delete-key-value }}** — удалить виджет.

## Алерт {#alert}

1. Откройте или [создайте](../dashboard/create.md) дашборд. 
1. [Добавьте](../dashboard/add-widget.md#alert) и настройте алерт.
1. Нажмите ![image](../../../_assets/console-icons/ellipsis.svg) в правом верхнем углу виджета. 
1. В появившемся меню выберите один из пунктов:

    - **{{ ui-key.yacloud_monitoring.dashboard.dash.setup }}** — открыть меню редактирования алерта.
    - **{{ ui-key.yacloud_monitoring.actions.common.duplicate }}** — создать копию виджета на текущем дашборде.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}** — создать копию виджета на выбранном дашборде.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.addToSelection }}** — добавить виджет в список выбранных.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.share-screenshot-key-value }}**:
      - **Скопировать скриншот в буфер** — сохранить снимок виджета в формате `PNG` в буфер обмена.
      - **Скопировать ссылку на скриншот** — сохранить снимок виджета в формате `PNG` в хранилище {{ monitoring-name }} и скопировать в буфер ссылку на него.
    - **{{ ui-key.yacloud_monitoring.dashboard.widget.delete-key-value }}** — удалить виджет.
