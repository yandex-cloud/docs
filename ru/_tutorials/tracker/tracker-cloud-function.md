# Интеграция {{ tracker-name }} с {{ sf-short-name }}

В данном руководстве описана интеграция средств автоматизации {{ tracker-name }} с сервисом {{ sf-short-name }} на примере суммирования затраченного времени родительской задачи по всем дочерним подзадачам.

Чтобы настроить автоматическое обновление суммарного значения затраченного времени родительской задачи при изменении этой величины в любой из дочерних подзадач:

1. [Зарегистрируйте приложение](#register-app).
1. [Получите токен доступа к приложению](#get-token).
1. [Получите ID организации для доступа к API](#get-tracker-id).
1. [Создайте функцию {{ sf-name }}](#create-function).
1. [Настройте триггер](#setup-trigger).
1. [Протестируйте автоматическое обновление данных](#test-updates).

## Перед началом работы {#before-you-begin}

{% note info %}

Для прохождения сценария вам понадобятся учетные записи:

* в {{ yandex-cloud }} с платежным аккаунтом;
* в {{ tracker-name }} в организации, подключенной к сервису {{ ya-360 }}, и [ролью](../../organization/security/index.md#service-roles) не ниже `{{ roles-organization-admin }}`.

{% endnote %}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за использование функции (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Зарегистрируйте приложение {#register-app}

1. В браузере перейдите по адресу ` https://oauth.yandex.ru/client/new ` и авторизуйтесь под учетной записью в {{ tracker-name }}.
1. В форме **Создать приложение**:
	1. В поле **Название вашего сервиса** введите название, например `TimeUpdater`;
	1. В разделе **Платформы приложения** активируйте **Веб-сервисы** и в поле **Redirect URI** введите адрес ` https://oauth.yandex.ru/verification_code `;
	1. В разделе **Доступ к данным** в поле ввода начните печатать `tracker`, затем из выпадающего списка выберите:
		* `Чтение из Трекера`;
		* `Запись в Трекер`.
1. Нажмите кнопку **Создать приложение**;
1. Дождитесь загрузки страницы с информацией о приложении и скопируйте идентификатор приложения из поля **ClientID**. 

## Получите токен доступа к приложению {#get-token}

1. В браузере перейдите по адресу:
	```
	https://oauth.yandex.ru/authorize?response_type=token&client_id=<идентификатор_приложения> 
	```
	Где значение параметра `client_id` — идентификатор приложения из поля **ClientID** со страницы информации о созданном в предыдущем пункте приложении.
1. Дождитесь загрузки страницы и скопируйте токен.
1. Сохраните токен — он понадобится при создании функции.

## Получите ID организации для доступа к API {#get-tracker-id}

1. Перейдите в [{{ tracker-name }}](https://tracker.yandex.ru/). Нажмите кнопку **Войти в Tracker**.
1. На правой панели нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}**.
1. В разделе **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.access-and-payment }}** нажмите **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.
1. В блоке **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.source-title }}** скопируйте и сохраните идентификатор организации — он понадобится при создании функции.

## Создайте функцию {{ sf-name }} {#create-function}

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. В левом верхнем углу нажмите кнопку ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Выберите **Бессерверные вычисления** → **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
1. Укажите название функции, например `timeupdater`.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** выберите среду выполнения `Python / 3.9`.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**.
1. Прикрепите [тестовый архив](https://github.com/yandex-cloud/yc-architect-solution-library/raw/main/yc-tracker/tracker-summarize-spent/build/tracker-summarize-spent.zip).
1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.
1. В разделе **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** в поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** добавьте:
   * `ORG` — идентификатор организации {{ ya-360 }}.
   * `TOKEN` — токен доступа к приложению.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
1. Дождитесь загрузки страницы и в поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** скопируйте и сохраните ссылку для вызова функции.
	Пример ссылки:
	```
	https://functions.yandexcloud.net/d4e94uav31086c******
	```
1. Активируйте опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.

## Настройте триггер {#setup-trigger}

### Создайте очередь

1. На панели слева выберите ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_components_TrackerSearch.queues }}** → **{{ ui-key.startrek.blocks-desktop_b-head.new-queue }}**.
1. Выберите шаблон очереди, например **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset-title--development-preset }}**.
1. Задайте имя, например `Function Test`.
1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_queue-new-presets.create }}**.

### Создайте триггер

1. На странице очереди в правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.
1. На панели слева выберите **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.group-title--automatization }}** → **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**.
1. В поле **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_name }}** введите название триггера, например `timeupdater`.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}** выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-timetracking }}**  → **Затрачено времени**.
1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}** выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }}**.
1. В открывшейся форме в поле **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-url }}** введите:
	```
	https://functions.yandexcloud.net/<идентификатор_функции>?id=not_var{{issue.key}}
	```
	Где `https://functions.yandexcloud.net/<идентификатор_функции>` — ссылка для вызова функции, которую вы сохранили при создании функции.
	Пример:
	```
	https://functions.yandexcloud.net/d4e94uav31086c******?id=not_var{{issue.key}}
	```
1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_create }}**.

## Протестируйте автоматическое обновление данных {#test-updates}

### Создайте задачи

1. Создайте родительскую задачу, для которой будет суммироваться затраченное время подзадач:
	1. На странице очереди `Function Test` нажмите кнопку **{{ ui-key.startrek.blocks-desktop_guide.ticket--main--action_new--title }}**. 
	1. В открывшейся форме в поле **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** введите название задачи, например `Parent Task`.
	1. Нажмите кнопку **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.create }}**.
1. Создайте подзадачи:
	1. На странице задачи `Parent Task` в правом верхнем углу в меню **{{ ui-key.startrek.ui_components_IssueMenu.title }}** выберите **{{ ui-key.startrek.ui_components_IssueMenu.create-subissue }}**.
	1. В открывшейся форме в поле **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** введите название подзадачи, например `Subtask-1`.
	1. Аналогичным образом создайте еще одну или несколько подзадач с названиями `Subtask-2`, `Subtask-3` и т. д.

### Внесите данные о затраченном времени в подзадачах

1. На странице подзадачи `Subtask-1` в правом верхнем углу в меню **{{ ui-key.startrek.ui_components_IssueMenu.title }}** выберите **{{ ui-key.startrek.ui_components_IssueMenu.add-worklog }}**.
1. В открывшемся диалоге в поле **{{ ui-key.startrek.ui_components_AddWorklogDialog.duration-label }}** укажите любое время, например `1h25m`.
1. Аналогичным образом добавьте затраченное время в других подзадачах.

### Убедитесь в корректной работе функции 

1. Перейдите на страницу задачи `Parent Task`.
1. Убедитесь, что в блоке параметров задачи в разделе **{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** в поле **{{ ui-key.startrek-backend.fields.issue.spent-key-value }}** учтено указанное в подзадаче время.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите функцию {{ sf-name }}](../../functions/operations/function/function-delete.md).
