# Создание таймера

Создайте [таймер](../concepts/trigger/timer.md) — триггер, который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} по расписанию.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Выберите сервис **{{ serverless-containers-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Таймер**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки таймера** укажите расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).

    1. В блоке **Настройки контейнера** выберите его и укажите:

        {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также

* [Таймер для запуска функции {{ sf-name }}](../../functions/operations/trigger/timer-create.md).
