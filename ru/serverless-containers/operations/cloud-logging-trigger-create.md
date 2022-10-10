# Создание триггера для {{ cloud-logging-full-name }}

Создайте [триггер для {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при добавлении записей в [лог-группу](../../logging/concepts/log-group.md).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* Лог-группа, при добавлении записей в которую триггер будет запускаться. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:
   
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **{{ cloud-logging-name }}**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки {{ cloud-logging-name }}** укажите:

        * лог-группу;
        * (опционально) типы ресурсов — ваши сервисы или сервисы {{ yandex-cloud }}, например `serverless.function`;
        * (опционально) идентификаторы ваших ресурсов или ресурсов {{ yandex-cloud }}, например контейнеров {{ serverless-containers-name }};
        * (опционально) уровни логирования.

       Триггер срабатывает, когда в указанную лог-группу добавляют записи, которые соответствуют всем опциональным настройкам. Если опциональная настройка не задана, триггер срабатывает при любом ее значении.

    1. (опционально) В блоке **Настройки группирования сообщений** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 100, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.

       Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **Настройки контейнера** выберите контейнер и укажите:

        {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также

* [Триггер для {{ cloud-logging-name }}, который запускает функцию {{ sf-name }}](../../functions/operations/trigger/cloud-logging-trigger-create.md).
