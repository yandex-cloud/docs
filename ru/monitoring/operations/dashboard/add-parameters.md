---
title: Как добавить параметр дашборда в {{ monitoring-full-name }}
description: Из статьи вы узнаете, как добавить параметр дашборда в {{ monitoring-name }}.
---

# Добавление параметра дашборда

[Параметры](../../concepts/visualization/dashboard.md#parameterization) позволяют создавать интерактивные дашборды, содержание которых изменяется в зависимости от выбора пользователя.

{% include [dash-parameters](../../../_includes/monitoring/dash-parameters.md) %}

Чтобы добавить параметр дашборда:

1. Откройте [главную страницу сервиса]({{ link-monitoring }}).
1. В левой части окна выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
1. Выберите нужный дашборд.
1. В верхней части страницы нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_monitoring.actions.common.edit }}**.
1. Нажмите ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}**.
1. В окне **{{ ui-key.yacloud_monitoring.dashboard.settings.dashboard-settings }}** перейдите на вкладку ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_monitoring.component.parametrizer.parameters }}**.
1. Нажмите **{{ ui-key.yacloud_monitoring.component.parametrizer.add }}**.
1. Настройте параметр и нажмите **{{ ui-key.yacloud_monitoring.component.parametrizer.save }}**.

[Подставить параметр](../../concepts/visualization/dashboard.md#templates) можно при [добавлении виджета на дашборд](add-widget.md).