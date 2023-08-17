# Как отредактировать задачу

Чтобы изменить задачу, перейдите на ее страницу. Если у вас не хватает прав для редактирования, [запросите их](../faq.md#section_xgr_zng_4bb) у владельца очереди  или [администратора](../role-model.md) вашей организации.

{% note info %}

Страницы задач обновляются в реальном времени. Если кто-то изменит или прокомментирует задачу, страница которой открыта, вы увидите уведомление об этом в правом нижнем углу страницы.

{% endnote %}

## Изменить название задачи {#edit-name}

Нажмите на название задачи. Отредактируйте текст и нажмите кнопку **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

## Изменить описание задачи {#edit-description}

Справа от описания задачи нажмите значок ![](../../_assets/tracker/icon-edit.png) и отредактируйте текст. Для форматирования текста используйте [разметку YFM](../user/markup.md). Чтобы сохранить изменения, нажмите кнопку **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

В описании задачи можно указать ключ любой другой задачи — тогда {{ tracker-name }} автоматически их свяжет. Связанная задача отобразится на вкладке **{{ ui-key.startrek.ui_components_IssueTabs.links-tab }}**. 


В описании задачи также можно [прикрепить изображение или файл](attach-file.md).  

## Изменить параметры задачи {#edit-fields}

[Параметры задачи](../user/create-param.md#default-fields) отображаются на вкладке **{{ ui-key.startrek.ui_components_IssueTabs.fields-tab }}**. Чтобы изменить значение параметра, нажмите на значок ![](../../_assets/tracker/mobile-params-open.png). Введите значение и нажмите кнопку **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

{% note info %}
  
Если вы не видите нужных параметров, перейдите в веб-приложение и на панели справа добавьте их с помощью кнопки ![](../../_assets/tracker/task-params-btn.png) **{{ ui-key.startrek.blocks-desktop_fields-switcher.switcher-title }}**. 

{% endnote %}

Параметры **{{ ui-key.startrek-backend.fields.issue.priority-key-value }}**, **{{ ui-key.startrek-backend.fields.issue.type-key-value }}**, **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}** и **{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }}** также расположены на вкладке **{{ ui-key.startrek.ui_components_IssueTabs.description-tab }}**. Чтобы отредактировать их значения, нажмите на название параметра, укажите значение и нажмите кнопку **{{ ui-key.startrek.ui_components_settings_IssueUpdatesSettings.save }}**.

## Изменить статус задачи {#edit-status}

Чтобы изменить статус задачи, под названием задачи откройте выпадающий список и выберите статус.

## Настроить отображение задачи {#edit-display}

Чтобы вам было удобнее работать в {{ tracker-name }}, настройте внешний вид страницы задачи: язык интерфейса, отображение пользователей и дат, порядок комментариев. Для этого перейдите в веб-интерфейс в раздел [**{{ ui-key.startrek.blocks-desktop_m-head.my-settings }}**](../user/personal.md).

## Другие действия над задачами  

В задачи можно добавлять комментарии, связи, файлы и выполнять другие действия:

* [{#T}](comments.md)
* [{#T}](checklist.md)
* [{#T}](ticket-links.md)
* [{#T}](attach-file.md)
