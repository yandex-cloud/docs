# Telegram

Предположим, что нужно автоматически отправлять уведомления в мессенджер, когда у задачи меняется статус. Например, чтобы отслеживать готовность релизов к тестированию. Для этого можно [настроить триггер](user/trigger.md), который будет отслеживать статусы задач типа <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}</q> и отправлять HTTP-запрос, когда статус задачи изменится на <q>{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}</q>.

В мессенджере Telegram для автоматической отправки сообщений в групповые чаты и отдельным пользователям используются боты. Чтобы отправлять уведомления из {{ tracker-name }} в Telegram, создайте телеграм-бота и настройте триггер, который будет отправлять сообщения от имени бота с помощью HTTP-запросов.

## Шаг 1. Настройка телеграм-бота {#bot-setup}

1. Создайте нового телеграм-бота:

    1. В мессенджере Telegram добавьте в контакты бота `@BotFather` и отправьте ему сообщение `/start`.

    1. Отправьте боту сообщение `/newbot` и следуйте инструкциям: придумайте для бота отображаемое имя (например, `My Company`) и имя аккаунта (например, `MyCompanyBot`). Имя аккаунта должно иметь окончание `bot`.

    В ответ вы получите сообщение об успешном создании бота. В сообщении будет указан токен — секретный код, который потребуется для обращения к вашему боту через API. Токен имеет вид `1234567890:ABC123-defHIJ...`

1. Добавьте созданного бота в групповой чат Telegram, в который вы хотите отправлять оповещения из {{ tracker-name }}.
    Если вы хотите получать оповещения из {{ tracker-name }} в личных сообщениях, начните чат с ботом.

1. Узнайте идентификатор чата Telegram, в который вы хотите отправлять оповещения. Для этого можно использовать специальных ботов, например `@myidbot`:
    - Чтобы узнать идентификатор группового чата, добавьте в этот чат бота и отправьте ему сообщение `/getgroupid`. Обратите внимание, что идентификатор группового чата начинается с минуса `-`. 
    - Чтобы узнать идентификатор вашего аккаунта для отправки личных сообщений, начните чат с ботом и отправьте ему сообщение `/getid`. 


Подробнее о настройке телеграм-бота можно узнать на сайте [https://core.telegram.org/bots](https://core.telegram.org/bots).

## Шаг 2. Настройка {{ tracker-name }} {#tracker-setup}

1. Авторизуйтесь в {{ tracker-name }}. У вас должны быть права на администрирование очереди, для которой вы будете настраивать триггер.

1. Перейдите в настройки очереди и в разделе **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** нажмите кнопку [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**](user/create-trigger.md).

1. Введите название триггера, например <q>Уведомления в Telegram</q>.

1. Настройте условия срабатывания триггера так, чтобы он срабатывал, когда задача типа **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** переходит в статус **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**:

    1. Выберите опцию **{{ ui-key.startrek.blocks-desktop_trigger-condition.title }}** → **{{ ui-key.startrek.blocks-desktop_trigger-condition.condition-type--and_short }}**.

    1. Добавьте условие **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.table-head--type }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** → **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}**.

    1. Добавьте условие **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.content-header--status }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**.
    
    ![](../_assets/tracker/slack-trigger-example.png)

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** и выберите **{{ ui-key.startrek.blocks-desktop_trigger-action.title_webhook }}**.

1. Настройте запрос:
    - Метод — **POST**.
    - Адрес: `https://api.telegram.org/bot<токен>/sendMessage`
        В адрес подставьте значение токена, который вы получили при [настройке телеграм-бота](#bot-setup).
    - Способ авторизации — **NoAuth**.
    - Тип содержимого — **application/json**.
    - Тело запроса:
        ```
        {
            "chat_id": "<ID чата>",
            "text": "Пора тестировать задачу [not_var{{issue.key}}: not_var{{issue.summary}}]({{ link-tracker }}not_var{{issue.key}})"
        }
        ```
        В качестве значения параметра `chat_id` укажите идентификатор чата, который вы получили при [настройке телеграм-бота](#bot-setup).
        Чтобы добавить в тело запроса значения полей задачи, справа от поля ввода нажмите кнопку **{ }** и выберите имя поля.
    - Заголовки оставьте пустыми.
    
    {% note info %}

    Если вы хотите использовать в HTTP-запросе другие методы и параметры, вы можете найти описание API телеграм-ботов на сайте [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api).

    {% endnote %}

    ![](../_assets/tracker/telegram-trigger-request.png)

1. Сохраните триггер.


Чтобы проверить работу триггера, переведите задачу типа **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** в статус **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}**. Триггер отправит в чат Telegram сообщение с текстом: <q>Пора тестировать задачу TEST-123: Настроить триггеры ({{ link-tracker-example-1 }})</q>.

