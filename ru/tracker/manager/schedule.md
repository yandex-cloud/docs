# Графики работы

{% note warning %}

По умолчанию настраивать очередь может [только ее владелец](queue-access.md).

{% endnote %}

График работы позволяет установить время, когда активно [правило SLA](sla.md). В нерабочие часы таймер SLA работать не будет. Вы можете выбрать для правила один из стандартных графиков или создать свой.

{% note info %}

В системном графике **{{ ui-key.startrek.blocks-desktop_calendar-editor--working-time-select.option--daily24x7 }}** праздничные дни считаются нерабочими, таймер SLA в эти дни не работает.

{% endnote %}


## Создать график работы {#section_rlk_hkg_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-calendars }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.create-calendar }}**.

1. Нажмите на значок ![](../../_assets/tracker/icon-edit.png) и введите название графика. Нажмите ![](../../_assets/tracker/approve-checkmark.png), чтобы сохранить название.

1. Выберите часовой пояс.

1. Укажите режим работы.

1. Выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.holidays-title }}**, которые будут отличаться от основного графика работы. Для этого нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.no-holidays-title }}** и задайте параметры:

    - Выберите страну, чтобы применить производственный календарь вашего региона.

    - Добавьте **Исключения из правил SLA**, если ваш график работы отличается от производственного.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.action-save }}**.

Созданный график доступен в разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.custom-calendars }}**. Другие пользователи не смогут просмотреть или использовать ваш график.

## Редактировать график работы {#section_vkm_flh_x2b}

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %}

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-calendars }}**.

1. В разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.custom-calendars }}** нажмите на название нужного графика.

1. Нажмите кнопку ![](../../_assets/tracker/svg/icon-edit1.svg)  **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendars.edit-button }}**.

1. Внесите изменения и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_calendar-editor.action-save }}**.


