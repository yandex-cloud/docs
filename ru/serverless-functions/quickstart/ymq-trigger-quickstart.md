# Создание триггера для очереди сообщений

Создайте триггер для чтения сообщений из очереди сервиса {{ message-queue-full-name }} и обрабатывайте их с помощью функции {{ sf-full-name }}.

{% note important %}

- Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
- Для одной очереди сообщений можно создать только один триггер.
 
{% endnote %}

- [Перед началом работы](#before-begin).
- [Создайте триггер](#trigger-create).
- [Проверьте результат](#check-result).

## Перед началом {#before-begin}

Для создания [триггера](../concepts/trigger.md) вам понадобятся: 
1. Сервисные аккаунты с правами на чтение из очереди сообщений и вызов функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций. Если у вас нет сервисных аккаунтов, [создайте их](../../iam/operations/sa/create.md).
1. [Очередь сообщений](../../message-queue/concepts/queue.md), из которой триггер будет забирать сообщения. Если у вас еще нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).
1. [Функция](../concepts/function.md), которой триггер будет передавать сообщения на обработку. Если у вас еще нет функции:
    - [Создайте функцию](../operations/function/function-create.md).
    - [Создайте версию функции](../operations/function/version-manage.md#func-version-create).

## Создайте триггер {#trigger-create}

Создайте триггер, который будет забирать сообщения из {{ message-queue-name }} и передавать их в функцию {{ sf-name }} для дальнейшей обработки.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Создайте триггер: 
    
    - `--name` — имя триггера.
    - `--queue-arn` — ARN (Amazon Resource Name) очереди.
    - `--invoke-function-id` — уникальный идентификатор функции. 
    - `--queue-service-account-name` — сервисный аккаунт с правами на чтение сообщений из очереди.
    - `--invoke-function-service-account-id` — сервисный аккаунт с правами на вызов функции.
    - `--batch-size`— размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1. 
       
    ```
    $ yc serverless trigger create message-queue \
        --name test-trigger \
        --queue-arn yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq \
        --queue-service-account-id bfbqqeo6jkpls2tse5o6 \
        --invoke-function-id b09e5lu91ta21vdrrgma \
        --invoke-function-service-account-id bfbqqeo6jkpls2tse5o6 \
        --batch-size 10
    id: dd0cspdch6dslu9n3i5g
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:14:45.762915Z"
    name: test-trigger
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6        
    ```
    
{% endlist %}

## Проверьте результат {#check-result}

Проверьте, что триггер работает корректно, в сервисе {{ message-queue-name }} или в {{ sf-name }}.

{% list tabs %}

- Message Queue

    Проверьте, что количество сообщений в очереди уменьшается, проверив статистику очереди: 
    1. Откройте раздел **Message Queue**.
    1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке очереди, для которой был создан триггер.
    1. Перейдите в раздел **Статистика**. Обратите внимание на график **Сообщений в очереди**.

- Functions
    
    Проверьте, что функция была запущена, посмотрев логи функции:  
    1. Посмотрите логи функции, в них должна отображаться информация о вызове функции. В данном примере функция выводит информацию об обработанных сообщениях. 
    
        ```
        $ yc serverless function logs b09e5lu91ta21vdrrgma
        
        2019-08-28 12:26:50     START RequestID: a5e4f3a3-9533-4eca-820c-82887258da46 Version: b09m126ee29375fq7qva
        2019-08-28 12:26:51     MESSAGE_BATCH
        2019-08-28 12:26:51     [
        2019-08-28 12:26:51       {
        2019-08-28 12:26:51         "event_metadata": {
        2019-08-28 12:26:51           "event_id": "1cc52025-f485e7bd-32441eed-3bce2ebc",
        2019-08-28 12:26:51           "event_type": "yandex.cloud.events.messagequeue.QueueMessage",
        2019-08-28 12:26:51           "created_at": {
        2019-08-28 12:26:51             "seconds": 1566995011,
        2019-08-28 12:26:51             "nanos": 111000000
        2019-08-28 12:26:51           },
        2019-08-28 12:26:51           "cloud_id": "aoegtvhtp8ob9rqq8sto",
        2019-08-28 12:26:51           "folder_id": "aoek49ghmknnpj1ll45e"
        2019-08-28 12:26:51         },
        2019-08-28 12:26:51         "details": {
        2019-08-28 12:26:51           "queue_arn": "yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq",
        2019-08-28 12:26:51           "message_id": "1cc52025-f485e7bd-32441eed-3bce2ebc",
        2019-08-28 12:26:51           "content_hash": "ed076287532e86365e841e92bfc50d8c",
        2019-08-28 12:26:51           "body": "SGVsbG8gV29ybGQh",
        2019-08-28 12:26:51           "system_attributes": {
        2019-08-28 12:26:51             "ApproximateFirstReceiveTimestamp": "1566995209950",
        2019-08-28 12:26:51             "ApproximateReceiveCount": "1",
        2019-08-28 12:26:51             "SentTimestamp": "1566995011111"
        2019-08-28 12:26:51           }
        2019-08-28 12:26:51         }
        2019-08-28 12:26:51       }
        2019-08-28 12:26:51     ]
        2019-08-28 12:26:51     END RequestID: a5e4f3a3-9533-4eca-820c-82887258da46
        2019-08-28 12:26:51     REPORT RequestID: a5e4f3a3-9533-4eca-820c-82887258da46 Duration: 444.728 ms Billed Duration: 500 ms Memory Size: 128 MB Max Memory Used: 13 MB
        ```

{% endlist %}

## Что дальше {#what-is-next}

- Ознакомьтесь с [концепциями триггеров](../concepts/trigger.md).
- Посмотрите, что можно делать с триггерами в [пошаговых инструкциях](../operations/index.md).
