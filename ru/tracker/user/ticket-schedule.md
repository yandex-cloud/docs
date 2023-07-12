# Создание задач по расписанию

В {{ tracker-name }} можно настроить регулярное создание задач по определенному шаблону. Например, каждую неделю создавать задачу на резервное копирование данных.

Задачи будут создаваться в очереди, в которой настроено автообновление. Автором задачи будет Робот сервиса Tracker.

{% note tip %}

Убедитесь, что у робота есть права на создание задач в выбранной очереди.

{% endnote %}

Чтобы настроить создание задач по расписанию:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %} 

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.title }}** и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.button-create }}**.

1. Выберите тип **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.type-toggle--create }}**.

1. Настройте периодичность создания задач:

    1. Выберите, в каких единицах будет задан период создания задач: часах, днях или неделях.

    1. Укажите период создания задач в выбранных единицах. Для этого в поле **{{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every }} ({{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every-week }})** введите число от 1 до 1000.

       Например, если вы укажете период <q>Каждый 4 день</q>, задача будет создаваться раз в четыре дня.

       ![](../../_assets/tracker/schedule-setup.png)

       Если вы задали период создания задач в днях, вы можете выбрать вариант **{{ ui-key.startrek.components_QueueAdminAutoactions_Cron.every-work-day }}** и [график работы](../manager/schedule.md).

       Если вы задали период создания задач в неделях, выберите дни недели, в которые будут создаваться задачи.

    1. Укажите даты и время, когда автоматическое создание задач начнет и закончит действовать. Если вы не укажете даты начала и окончания, автоматическое создание задач будет действовать постоянно.

1. В блоке **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions }}** нажмите кнопку **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions-create }}**.

1. В окне **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}** заполните поля шаблона для автоматического создания задач и нажмите кнопку **{{ ui-key.startrek.ui_components_FieldEdit.form-submit }}**.
 
1. Если вы хотите создавать несколько задач в одном автодействии, снова нажмите кнопку **{{ ui-key.startrek.components_QueueAdminAutoactions_CreateTicketForm.actions-create }}** и заполните поля новой задачи.

1. Чтобы сохранить автодействие, нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.



