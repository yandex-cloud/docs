# Создать триггер для {{ message-queue-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}

Создайте [триггер для очереди сообщений](../concepts/trigger/ymq-trigger.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

* Триггер можно создать только для стандартной очереди сообщений.
* Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
* Для одной очереди сообщений можно создать только один триггер.
 
{% endnote %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов контейнера;
    * на чтение из очереди, из которой триггер будет принимать сообщения;
    * (опционально) на запись в очередь [Dead Letter Queue](../../serverless-containers/concepts/dlq.md).

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

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
        * В поле **Тип** выберите **{{ message-queue-name }}**.
        * В поле **Запускаемый ресурс** выберите **Контейнер**.

    1. В блоке **Настройки {{ message-queue-name }}** выберите очередь сообщений и сервисный аккаунт с правами на чтение из нее.

    1. (Опционально) В блоке **Настройки группирования сообщений** укажите:

        * размер группы сообщений. Допустимые значения от 1 до 10, значение по умолчанию — 1.
        * максимальное время ожидания. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create message-queue \
      --name <имя_триггера> \
      --queue <идентификатор_очереди> \
      --queue-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --batch-size 1 \
      --batch-cutoff 10s
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        Чтобы узнать идентификатор очереди:

        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. Выберите сервис **{{ message-queue-name }}**.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **Общая информация**, в поле **ARN**.

    * `--invoke-container-id` — идентификатор контейнера.
    * `--queue-service-account-name` — сервисный аккаунт с правами на чтение из очереди сообщений.
    * `--invoke-container-service-account-id` — сервисный аккаунт с правами на вызов контейнера.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.

    Результат:

    ```text
    id: a1s5msktij**********
    folder_id: b1gmit33hg**********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: ymq-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:my-mq
        service_account_id: bfbqqeo6jk**********
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_container:
          container_id: bba5jb38o8**********
          service_account_id: bfbqqeo6jk**********
    status: ACTIVE
    ```

- API

  Чтобы создать триггер для {{ message-queue-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- {{ serverless-containers-name }}

    {% include [check-result](../../_includes/serverless-containers/check-result.md) %}

- {{ message-queue-name }}

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

   1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ message-queue-name }}**.
   1. Выберите очередь, для которой создали триггер.
   1. Перейдите в раздел **Мониторинг**. Посмотрите график **Сообщений в очереди**.

{% endlist %}

## См. также {#see-also}

* [Триггер для {{ message-queue-name }}, который передает сообщения в функцию {{ sf-name }}](../../functions/operations/trigger/ymq-trigger-create.md).
