---
title: Как добавить виджет на дашборд в {{ monitoring-full-name }}
description: Из статьи вы узнаете, как добавить виджет на дашборд в {{ monitoring-name }}.
---

# Добавление виджета на дашборд

1. Откройте или [создайте дашборд](create.md).
1. Справа вверху нажмите ![image](../../../_assets/console-icons/plus.svg) и выберите виджет, который хотите добавить.
1. Укажите настройки виджета.
1. Справа вверху нажмите ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## График {#new}

1. Нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Настройте график, указав запросы и отображение метрик.
1. (Опционально) Добавьте [параметры](add-parameters.md) и настройте [повторение графиков](add-parameters.md#repeated-graphs).
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.apply }}**.

## Алерт {#alert}

Для добавления алерта на дашборд сначала [создайте алерт](../alert/create-alert.md).

1. Нажмите **Алерт**.
1. В списке выберите алерт и введите произвольный заголовок для него.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Эскалация {#escalation}

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}

Для добавления эскалации на дашборд сначала [создайте](../alert/create-escalation.md) политику эскалаций.

1. Нажмите **Эскалация**.
1. Введите произвольный заголовок для эскалации.
1. В списке выберите политику эскалаций.
1. (Опционально) Укажите, следует ли отображать на дашборде только запущенные эскалации или все эскалации.
1. (Опционально) Введите максимальное количество эскалаций, которое можно отобразить на дашборде.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Текст {#text}

1. Нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-text }}**.
1. Введите текст в поле ввода. При необходимости примените к тексту форматирование.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**.

## Заголовок {#heading}

1. Нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. Введите текст в поле ввода.
1. Выберите размер заголовка.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**.