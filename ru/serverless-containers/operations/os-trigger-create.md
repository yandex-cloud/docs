# Создание триггера для {{ objstorage-name }}

Создайте [триггер для {{ objstorage-name }}](../concepts/trigger/os-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при создании, перемещении или удалении [объекта](../../storage/concepts/object.md) в бакете.

## Перед началом работы {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Бакет](../../storage/concepts/bucket.md), при событиях с объектами в котором триггер будет запускаться. Если у вас нет бакета, [создайте его](../../storage/operations/buckets/create.md).

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
        * В поле **Тип** выберите **{{ objstorage-name }}**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки {{ objstorage-name }}**:

        * В поле **Бакет** выберите бакет, для событий с объектами которого хотите создать триггер.
        * В поле **Типы событий** выберите события, после наступления которых триггер будет запускаться.
        * (опционально) В поле **Префикс ключа объекта** введите префикс для фильтрации.
        * (опционально) В поле **Суффикс ключа объекта** введите суффикс для фильтрации.

    1. В блоке **Настройки контейнера** выберите контейнер и укажите:

        {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. (опционально) В блоке **Настройки повторных запросов**:

        {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

    1. (опционально) В блоке **Настройки Dead Letter Queue** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **Создать триггер**.

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ objstorage-name }}, который запускает функцию {{ sf-name }}](../../functions/operations/trigger/os-trigger-create.md).
