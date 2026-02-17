---
title: Создание дашборда в {{ monitoring-full-name }}
description: Для создания дашборда в {{ monitoring-full-name }} необходимо на главной странице сервиса нажать на Создать дашборд. Добавьте виджет на дашборд. Нажмите Заголовок в блоке Добавить виджет, или нажмите Добавить в заголовке дашборда, а затем Заголовок. Введите текст в поле ввода. Выберите размер заголовка. Нажмите Добавить. Виджет с заголовком добавится на дашборд. Нажмите Сохранить в правом верхнем углу. Введите имя дашборда и нажмите Сохранить.
---

# Создание и управление дашбордом в {{ monitoring-name }}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvgvuhu34zple6f3vj?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=TvLdfcPCOHw).



Дашборды — это визуальные панели, которые позволяют быстро оценить состояние и производительность ваших облачных ресурсов. Вы можете воспользоваться готовыми дашбордами, которые предоставляют многие сервисы, или создать свой собственный. 

Для более удобной работы с дашбордами используйте [лейблы](#labels). Они помогают фильтровать дашборды и быстрее находить нужные данные.


## Создание дашборда {#create}

Для создания [дашборда](../../concepts/visualization/dashboard.md) выполните следующее:

1. На главной странице сервиса нажмите **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. Добавьте [виджет](../../concepts/visualization/widget.md) на дашборд. Например, виджет **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
    1. Нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
    1. Введите текст в поле ввода.
    1. Выберите размер заголовка.
    1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**. Виджет с заголовком добавится на дашборд.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}** в правом верхнем углу.
1. Введите имя дашборда и нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

## Настройка дашборда {#settings}

1. Откройте [главную страницу сервиса]({{ link-monitoring }}).
1. В левой части окна выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
1. Выберите нужный дашборд.
1. Справа вверху нажмите ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}** и выберите один из вариантов:
   * **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.general }}**. В этом окне можно настроить:
     * **Заголовок** — отображается вверху дашборда.
     * **Имя** — используется в URL-ссылке на дашборд. Если имя не указано, в ссылке будет использоваться заголовок дашборда.
     * **Описание** — дополнительная информация о дашборде.
     * **{{ ui-key.yacloud_monitoring.dashboard.settings.general.labels.title }}** — [лейблы](#labels) для более гибкого поиска дашбордов.
   * **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.json }}** — редактирование дашборда в формате JSON.
   * **{{ ui-key.yacloud_monitoring.component.parametrizer.parameters }}** — в этом окне можно добавить [параметры](add-parameters.md) для интерактивных дашбордов.
   * **{{ ui-key.yacloud_monitoring.wizard.tab.links-key-value }}** — в этом окне можно добавить ссылки на внешние ресурсы или другие дашборды.
1. Справа вверху нажмите ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.dashboard.dash.save }}**.

## Настройка лейблов на дашборде {#labels}

Для настройки лейблов на дашборде выполните следующее:

1. Откройте [главную страницу сервиса]({{ link-monitoring }}).
1. В левой части окна выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
1. Выберите нужный дашборд.
1. Справа вверху нажмите ![image](../../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.header.action.settings }}** и выберите **{{ ui-key.yacloud_monitoring.dashboard.settings.tab.general }}**.
1. В открывшемся окне в блоке **{{ ui-key.yacloud_monitoring.dashboard.settings.general.labels.title }}** введите значения лейблов в формате `ключ=значение`.
1. Нажмите **{{ ui-key.yacloud_monitoring.navigation.dialogs.button_save }}**.
1. Справа вверху нажмите ![image](../../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.dashboard.dash.save }}**.


## Поиск дашбордов {#search}

Искать дашборды в списке можно по основным параметрам дашборда: **ID** (идентификатор), **Заголовок**, **Имя**, **Описание**, **Лейблы**.

Для поиска дашбордов выполните следующее:

1. Откройте [главную страницу сервиса]({{ link-monitoring }}).
1. В левой части окна выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
1. В поле **{{ ui-key.yacloud_monitoring.component.entities-list.common-filter-placeholder }}** введите ключ или значение лейбла, заголовок, имя или описание.

#### Что дальше {#what-is-next}
- [{#T}](add-widget.md)
- [Концепции дашбордов](../../concepts/visualization/dashboard.md)
