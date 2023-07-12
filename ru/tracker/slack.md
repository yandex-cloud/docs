# Slack

Предположим, что нужно автоматически отправлять уведомления в мессенджер, когда у задачи меняется статус. Например, чтобы отслеживать готовность релизов к тестированию. Для этого можно [настроить триггер](user/trigger.md), который будет отслеживать статусы задач типа <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}</q> и отправлять HTTP-запрос, когда статус задачи изменится на <q>{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}</q>.

Чтобы отправлять уведомления из {{ tracker-name }} в чат команды, настройте в Slack внешнее приложение и создайте триггер, который будет отправлять сообщения в мессенджер с помощью HTTP-запросов.

## Шаг 1. Настройка Slack {#slack-setup}

1. Авторизуйтесь в Slack.

1. Подключите {{ tracker-name }} к Slack как внешнее приложение (Slack App):

    1. Перейдите по ссылке [Create your Slack app](https://api.slack.com/apps/new).

    1. Придумайте название приложения, например <q>Tracker</q>.

    1. Выберите workspace, к которому будет подключен {{ tracker-name }}.

    1. Нажмите кнопку **Create App**.

1. В настройках нового Slack App включите опцию **Incoming Webhooks** → **Activate Incoming Webhooks**.

1. Обновите страницу с настройками приложения.

1. Нажмите кнопку **Add New Webhook to Workspace**.

1. Выберите канал, в который {{ tracker-name }} будет отправлять сообщения и нажмите кнопку **Authorize**.

1. На странице настроек приложения в разделе **Webhook URLs for Your Workspace** появится адрес, по которому {{ tracker-name }} будет отправлять сообщения. Адрес выглядит примерно так:
    ```
    https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
    ```
    Скопируйте этот адрес, он понадобится при настройке интеграции со стороны {{ tracker-name }}.

## Шаг 2. Настройка {{ tracker-name }} {#tracker-setup}

1. Авторизуйтесь в {{ tracker-name }}. У вас должны быть права на администрирование очереди, для которой вы будете настраивать триггер.

1. Перейдите в настройки очереди и в разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** нажмите кнопку [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**](user/create-trigger.md).

1. Введите название триггера, например <q>Уведомления в Slack</q>.

1. Настройте условия срабатывания триггера так, чтобы он срабатывал, когда задача типа **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** переходит в статус **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**:
 
    1. Выберите опцию **{{ ui-key.startrek.blocks-desktop_trigger-condition.title }}** → **{{ ui-key.startrek.blocks-desktop_trigger-condition.condition-type--and_short }}**.

    1. Добавьте условие **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.table-head--type }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** → **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}**.

    1. Добавьте условие **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.content-header--status }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**.

    ![](../_assets/tracker/slack-trigger-example.png)

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** и выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.title_webhook }}**.

1. Настройте запрос:
    - Метод: **POST**.
    - Адрес: адрес, который вы получили после настройки интеграции со стороны Slack.
    - Способ авторизации: **NoAuth**.
    - Тип содержимого: **application/json**.
    - Тело запроса:
        ```
        {
            "link_names": true,
            "text": "@tracker, пора тестировать задачу <{{ link-tracker }}not_var{{issue.key}}|not_var{{issue.key}}>: not_var{{issue.summary}}"
        }
        ```
        Чтобы добавить в тело запроса значения полей задачи, справа от поля ввода нажмите кнопку **{ }** и выберите имя поля.
    - Заголовки оставьте пустыми.

    ![](../_assets/tracker/slack-webhook-example.png)

1. Сохраните триггер.

Чтобы проверить работу триггера, переведите задачу типа **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** в статус **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}**. Триггер отправит в чат команды сообщение со ссылкой на задачу и текстом: <q>Пора тестировать задачу TEST-123: Настроить триггеры</q>.


