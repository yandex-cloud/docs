1. Откройте [{{ monium-name }}]({{ link-monium }}).
1. На панели сверху выберите [проект каталога](*monium-folder-project) с балансировщиком или прокси-сервером. В этом проекте будут созданы канал уведомлений и алерт.
1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![bell](../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}**.
1. В правом верхнем углу нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud_monitoring.notification-methods.create-button.channel }}**.
1. Задайте имя канала уведомлений.
1. (Опционально) Укажите уровни алертов, для которых канал будет работать по умолчанию.
1. В поле **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите метод отправки уведомлений.
1. В появившемся поле выберите получателей уведомлений.

    {% note info %}

    {% include [notifications-requirements](../monium/notifications-requirements.md) %}

    {% endnote %}

1. Нажмите **{{ ui-key.yacloud_monitoring.channel.button_save }}**.
