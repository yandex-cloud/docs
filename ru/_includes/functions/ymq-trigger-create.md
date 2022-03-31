Создайте триггер для [очереди сообщений](../../message-queue/concepts/queue.md) сервиса {{ message-queue-full-name }} и обрабатывайте их с помощью [функции](../../functions/concepts/function.md) {{ sf-name }} или [контейнера](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

* Триггер можно создать только для стандартной очереди сообщений.
* Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
* Для одной очереди сообщений можно создать только один триггер.
 
{% endnote %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся: 

* Функция или контейнер, которые триггер будет запускать.

    * Если у вас нет функции:

        * [Создайте функцию](../../functions/operations/function/function-create.md).
        * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).

    * Если у вас нет контейнера:

        * [Создайте контейнер](../../serverless-containers/operations/create.md).
        * [Создайте ревизию контейнера](../../serverless-containers/operations/manage-revision.md#create).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов функции или контейнера;
    * на чтение из очереди, из которой триггер будет принимать сообщения;
    * (опционально) на запись в очередь [Dead Letter Queue](../../functions/concepts/dlq.md).

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Откройте сервис **{{ sf-name }}**.

    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Message Queue**.
        * Выберите, что будет запускать триггер — функцию или контейнер.

    1. В блоке **Настройки Message Queue** выберите очередь сообщений и сервисный аккаунт c правами на чтение из нее.

    1. (опционально) В блоке **Настройки группирования сообщений** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 10, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в функцию или контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. Если триггер будет запускать:

        * функцию, в блоке **Настройки функции** выберите ее и укажите:

            * [тег версии функции](../../functions/concepts/function.md#tag);
            * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться функция.

        * контейнер, в блоке **Настройки контейнера** выберите его и укажите:

            * [ревизию контейнера](../../serverless-containers/concepts/container.md#revision);
            * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет вызываться контейнер.

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, который запускает функцию, выполните команду:

    ```
    yc serverless trigger create message-queue \
      --name <имя триггера> \
      --queue <идентификатор очереди> \
      --queue-service-account-id <идентификатор сервисного аккаунта> \
      --invoke-function-id <идентификатор функции> \
      --invoke-function-service-account-id <идентификатор сервисного аккаунта> \
      --batch-size 1 \
      --batch-cutoff 10s
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        Чтобы узнать идентификатор очереди:

        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. Откройте сервис **{{ message-queue-name }}**.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **Общая информация**, в поле **ARN**.

    * `--invoke-function-id` — идентификатор функции.
    * `--queue-service-account-name` — сервисный аккаунт с правами на чтение из очереди сообщений.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в функцию или контейнер. Число сообщений при этом не превышает `batch-size`.

    Результат:
    ```
    id: dd0cspdch6dslu9n3i5g
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:14:45.762915Z"
    name: ymq-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
    ```

- API

    Создать триггер для {{ message-queue-full-name }} можно с помощью метода API [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- Functions

    {% include [check-result](check-result.md) %}

- Message Queue

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ message-queue-name }}**.
    1. Выберите очередь, для которой создали триггер.
    1. Перейдите в раздел **Мониторинг**. Посмотрите график **Сообщений в очереди**.

{% endlist %}
