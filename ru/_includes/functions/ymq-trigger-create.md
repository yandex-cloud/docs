Создайте триггер для [очереди сообщений](../../message-queue/concepts/queue.md) сервиса {{ message-queue-full-name }} и обрабатывайте их с помощью [функции](../../functions/concepts/function.md) {{ sf-name }}.

{% note warning %}

* Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
* Для одной очереди сообщений можно создать только один триггер.
 
{% endnote %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся: 
1. [Функция](../../functions/concepts/function.md), которой триггер будет передавать сообщения на обработку. Если у вас нет функции:
    * [Создайте функцию](../../functions/operations/function/function-create.md).
    * [Создайте версию функции](../../functions/operations/function/version-manage.md#func-version-create).
1. [Очередь сообщений](../../message-queue/concepts/queue.md), из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).
1. Сервисные аккаунты с правами на чтение из очереди сообщений и вызов функции. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. Перейдите на вкладку **Триггеры**.
    1. Нажмите кнопку **Создать триггер**.
    1. В блоке **Базовые параметры**:
        * Введите имя и описание триггера.
        * В поле **Тип** выберите **Message Queue**.
    1. В блоке **Настройки Message Queue** выберите очередь сообщений и сервисный аккаунт c правами на чтение из нее.
    1. В блоке **Настройки группирования сообщений** укажите размер группы сообщений и максимальное время ожидания. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет указанного размера группы или истечет максимальное время ожидания.
    1. В блоке **Настройки функции**:
        * Выберите функцию, которую будет вызывать триггер.
        * Укажите [тег версии функции](../../functions/concepts/function.md#tag).
        * Укажите сервисный аккаунт, от имени которого будет вызываться функция.
    1. Нажмите кнопку **Создать триггер**.

- CLI

    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы создать триггер, выполните команду:

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

    где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.
    Чтобы узнать идентификатор очереди:
        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. Откройте сервис {{ message-queue-full-name }}.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **Общая информация**, в поле **ARN**.
    * `--invoke-function-id` — идентификатор функции.
    * `--queue-service-account-name` — сервисный аккаунт с правами на чтение из очереди сообщений.
    * `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    * `--batch-size` — размер группы сообщений. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер отправит группу сообщений в функцию, когда число сообщений в очереди достигнет `batch-size` или истечет `batch-cutoff`.

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
    1. Откройте сервис **Message Queue**.
    1. Выберите очередь, для которой создали триггер.
    1. Перейдите в раздел **Мониторинг**. Посмотрите график **Сообщений в очереди**.

{% endlist %}
