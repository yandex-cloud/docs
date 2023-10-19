---
title: "Начало работы с {{ message-queue-full-name }} (очередями сообщений)"
description: "В этой инструкции вы научитесь выполнять основные действия с очередями сообщений в {{ message-queue-full-name }}. Для начала установите AWS CLI — утилиту командной строки для работы с {{ message-queue-name }}."
---

# Начало работы с {{ message-queue-name }}

Выполним основные действия с использованием [AWS CLI](https://aws.amazon.com/ru/cli/) — одного из [инструментов](instruments/index.md) для работы с {{ message-queue-name }}.

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI — утилиту командной строки для работы с {{ message-queue-name }}.
1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт с ролью `editor`.
1. [Создайте](../iam/operations/sa/create-access-key.md) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
1. Настройте AWS CLI:

   {% include [configure-aws-cli](../_includes/message-queue/configure-aws-cli.md) %}

1. Создайте очередь с именем `sample-queue`:

   {% list tabs %}

   - AWS CLI
  
     ```bash
     aws sqs create-queue \
       --queue-name <имя_очереди> \
       --endpoint <эндпоинт>
     ```

     Где:

     * `--queue-name` — имя создаваемой очереди, например `sample-queue`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.

     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000002n034r/sample-queue"
     }
     ```

     Сохраните полученный URL очереди, он понадобится позднее.

   - Консоль управления
  
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать очередь.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
     1. Укажите имя очереди: `sample-queue`.
  
        {% include [name](../_includes/message-queue/ymq-name.md) %}

     1. Выберите тип `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}`. Не изменяйте другие настройки.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
     1. Откройте созданную очередь.
     1. На вкладке **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** скопируйте URL очереди, он понадобится позднее.

  
   {% endlist %}

1. Отправьте сообщение в созданную очередь, используя сохраненный ранее URL очереди:

   {% list tabs %}

   - AWS CLI

     ```bash
     aws sqs send-message \
       --message-body "<текст_сообщения>" \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```

     Где:

     * `--message-body` — текст отправляемого в очередь сообщения, например, `Hello World`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--queue-url` — URL очереди, в которую будет отправлено сообщение.

     Результат:
     
     ```json
     {
         "MD5OfMessageBody": "67e63db14341b5a696596634********",
         "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
     }
     ```

   {% endlist %}

1. Примите сообщение из очереди:

   {% list tabs %}

   - AWS CLI
  
     ```bash
     aws sqs receive-message \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```

     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--queue-url` — URL очереди, из которой нужно получить сообщение.

     Результат:

     ```json
     {
         "Messages": [
             {
                 "MessageId": "948de7-9ec8d787-c*******-*",
                 "ReceiptHandle": "EAEggbj********",
                 "MD5OfBody": "ed076287532e86365e841e92********",
                 "Body": "Hello World",
                 "Attributes": {
                     "ApproximateFirstReceiveTimestamp": "15459********",
                     "ApproximateReceiveCount": "1",
                     "SentTimestamp": "15459********",
                     "SenderId": "abcdefkbh72is78********"
                 }
             }
         ]
     }
     ```

     Сохраните значение параметра `ReceiptHandle`, оно понадобится позднее.

   {% endlist %}

1. Удалите сообщение из очереди.

   Сообщения после обработки следует удалять из очереди, чтобы приложения не обрабатывали их повторно.

   Чтобы удалить принятое из очереди сообщение, используйте сохраненное ранее значение параметра `ReceiptHandle`:

   {% list tabs %}

   - AWS CLI
  
     ```bash
     aws sqs delete-message \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
       --receipt-handle <идентификатор_получения>
     ```
     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--queue-url` — URL очереди, из которой нужно удалить сообщение.
     * `--receipt-handle` — сохраненный ранее идентификатор получения сообщения `ReceiptHandle`.

   {% endlist %}

1. Удалите очередь:

   {% list tabs %}

   - AWS CLI
  
     ```bash
     aws sqs delete-queue \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```
  
     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--queue-url` — URL очереди, которую нужно удалить.

   - Консоль управления
  
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит очередь.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
     1. Нажмите значок ![image](../_assets/horizontal-ellipsis.svg) напротив нужной очереди и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

   {% endlist %}
