# Настроить регулярные напоминания

Чтобы сотрудники компании могли заранее легко и понятно оформлять отпуска и больничные, создайте очередь, форму заявки и настройте автоматическую проверку статуса заявок с отправкой напоминания сотрудникам отдела кадров в случае, если заявка вовремя не взята в работу.

## Создайте очередь

1. [Создайте очередь](manager/create-queue.md) с помощью шаблона <q>{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--hrProcesses }}</q>. 
1. В качестве имени укажите, например, `Vacations Queue`.
1. Настройте рабочий процесс для типа задачи `Отпуск`. 
1. Если нужно, создайте дополнительные типы задач и рабочие процессы.

## Настройте форму заявки

### Создайте форму 

1. На панели слева нажмите кнопку ![](../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_b-head.new_issue }}**.
1. В блоке **{{ ui-key.startrek.ui_components_PageCreateIssue.try-yandex-forms }}** нажмите кнопку **{{ ui-key.startrek.ui_components_PageCreateIssue.create-new }}**.
1. Создайте новую форму:
	* Укажите название `Заявка на отпуск`;
	* Добавьте описание, например `Форма заявки на отпуск`;
	* Нажмите кнопку **{{ ui-key.startrek.ui_components_PageCreateIssueForm.continue }}**.
1. Дождитесь загрузки страницы и нажмите кнопку **Полная версия {{ forms-full-name }}**.
1. Создайте форму заявки, например со следующими полями:
	* `ФИО` (короткий текст, обязательное поле);
	* `Отдел` (короткий текст, обязательное поле);
	* `Тип отпуска` (выпадающий список, обязательное поле). Добавьте опции в список, например:
		- `Оплачиваемый отпуск` 
		- `Неоплачиваемый отпуск`
		- `Декретный отпуск`
		- `Больничный`
	* `Начало` (Дата, обязательное поле);
	* `Конец` (Дата, обязательное поле);
1. Добавьте другие поля, если нужно.

### Настройте интеграцию с {{ tracker-name }} 

1. Нажмите кнопку **Настроить интеграции** и дождитесь загрузки страницы.
1. В поле **Тип задачи** выберите `Отпуск`.
1. В поле **Заголовок** нажмите ![](../_assets/tracker/svg/icon-add.svg) и выберите **Ответ на вопрос**. В появившемся диалоге в поле **Вопрос** выберите опцию **Тип отпуска** и нажмите кнопку **Сохранить**.
1. В поле **Описание** нажмите ![](../_assets/tracker/svg/icon-add.svg) и выберите **Ответы на вопрос**. В появившемся диалоге нажмите кнопку **Выбрать все**, в поле **Форматирование ответа** выберите **Форматированный**. Нажмите кнопку **Сохранить**.
1. Внизу нажмите кнопку **Добавить параметры задачи** и с помощью поля поиска выберите опцию **Дедлайн**.
1. В поле **Дедлайн** добавьте ответ на вопрос `Начало`.
1. Сохраните форму, нажав кнопку **Сохранить**.
1. Вернитесь в конструктор формы, нажав вверху страницы кнопку **В конструктор**.
1. Нажмите кнопку **Опубликовать** и в появившемся диалоге скопируйте ссылку на форму.
1. Вернитесь в настройки очереди `Vacations Queue` и нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-forms }}**.
1. Нажмите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_forms.add-btn }}** и заполните появившуюся форму, указав в поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_form-editor.form-link-label }}** полученную выше ссылку.
1. Сохраните интеграцию формы, нажав кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_form-editor.edit-btn }}**.

## Настройте автодействие

Для выполнения регулярных действий в очереди, в {{ tracker-name }} предусмотрены [автодействия](user/autoactions.md). Настройте регулярную проверку очереди `Vacations Queue` на наличие не взятых в работу заявок с помощью автодействия. Чтобы не перегружать сотрудников, ответственных за оформление отпусков, частыми напоминаниями, настройте отправку напоминаний раз в сутки и не раньше, чем за две недели до указанного в заявке начала отпуска.

1. Вернитесь в настройки очереди `Vacations Queue` и нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-autoactions }}**.
1. Дождитесь загрузки страницы и нажмите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoactions.button-create }}**.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.type-toggle-label }}** активируйте **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.type-toggle--update }}**.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.label_name }}** укажите, например, `vacation_warning`.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.label_time }}** настройте обновление раз в день (для целей тестирования лучше установить раз в час).
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.label_filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.filter-type--query }}** и используйте [язык запросов](user/query-filter.md):
	```
	Deadline: <= today() +14D Status: Новый
	```

	Условие сработает для задачи, у которой дата начала отпуска наступает через две недели или менее, а статус остается в состоянии <q>Новый</q>.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.label_actions }}** нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.action_add-action }}** и выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--comment }}**.
1. Нажмите кнопку призыва в комментарий ![](../_assets/tracker/summon.png) и в строке **{{ ui-key.startrek.blocks-desktop_comment-form.invite_to_comment }}** добавьте сотрудников, которые занимаются оформлением отпусков.
1. В поле комментария добавьте текст:
	```
	Отпуск не оформлен! Дедлайн: "not_var{{issue.dueDate}}".
	```
1. Чтобы сохранить автодействие, нажмите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.action_save }}**.

## Проверьте работу автодействия

1. На странице создания новой задачи справа вверху в поле **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.allow-empty-template }}** выберите опцию **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.never }}**.
1. Кликните виджет с названием `Отпуск`.
1. Заполните форму. В поле **Начало** укажите дату через неделю от сегодняшней.
1. Отправьте форму.
1. Убедитесь, что по истечении установленного в автодействии срока в задаче появился настроенный выше комментарий.
