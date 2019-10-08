# Начало работы

Выполним основные действия с использованием AWS CLI — одного из [инструментов](instruments/index.md) для работы c Message Queue.

1. Установите [AWS CLI](https://aws.amazon.com/ru/cli/) — утилиту командной строки для работы с Message Queue.
1. Создайте [сервисный аккаунт](../iam/operations/sa/create.md) с ролью `editor`.
1. Создайте [статические ключи доступа](../iam/operations/sa/create-access-key.md). Сразу сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа будут недоступны.
1. Настройте AWS CLI.

   {% list tabs %}

   - AWS CLI
  
     Задайте конфигурацию AWS CLI с помощью команды `aws configure`, используя идентификатор и секретный ключ сервисного аккаунта:
  
     ```
     $ aws configure
     AWS Access Key ID [****************kzJl]: <идентификатор ключа сервисного аккаунта>
     AWS Secret Access Key [****************I3AO]: <идентификатор ключа сервисного аккаунта>
     Default region name [eu-west-1]: ru-central1
     Default output format [None]:
     ```
  
   {% endlist %}

1. Создайте очередь с именем `sample-queue`:

   {% list tabs %}

   - AWS CLI
  
     ```
     $ aws sqs create-queue --queue-name sample-queue \
                 --endpoint https://message-queue.api.cloud.yandex.net/
     {
         "QueueUrl": "https://message-queue.api.cloud.yandex.net/aoeaql9r10cd9cfue7v6/000000000000002n034r/sample-queue"
     }
     ```
  
   - Консоль управления
  
     1. Откройте раздел **Message Queue**.
     1. Нажмите кнопку **Создать очередь**.
     1. Укажите имя очереди: `sample-queue`.
  
        {% include [name](../_includes/message-queue/ymq-name.md) %}
     1. Выберите тип **Стандартная**. Не изменяйте другие настройки
     1. Нажмите кнопку **Создать очередь**.
  
   {% endlist %}

1. Отправьте в созданную очередь сообщение, используя URL очереди из параметра `QueueUrl` из ответа на предыдущий запрос:

   {% list tabs %}

   - AWS CLI
  
     ```
     $ aws sqs send-message --message-body "Hello World!" \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoeaql9r10cd9cfue7v6/000000000000002l034r/sample-queue
     {
         "MD5OfMessageBody": "67e63db14341b5a696596634bbf19796",
         "MessageId": "765ff4d2-fa4bc83-6cfcc68e-21a49"
     }
     ```
  
   {% endlist %}

1. Примите сообщение из очереди:

   {% list tabs %}

   - AWS CLI
  
     ```
     $ aws sqs receive-message \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue
     {
         "Messages": [
             {
                 "MessageId": "948de7-9ec8d787-cbf3465c-c",
                 "ReceiptHandle": "EAEggbjIg_8sKAM",
                 "MD5OfBody": "ed076287532e86365e841e92bfc50d8c",
                 "Body": "Hello World!",
                 "Attributes": {
                     "ApproximateFirstReceiveTimestamp": "1545927269377",
                     "ApproximateReceiveCount": "1",
                     "SentTimestamp": "1545922344034"
                 }
             }
         ]
     }
     ```
  
   {% endlist %}

1. Удалите сообщение из очереди.

   После обработки сообщения следует удалять из очередей, чтобы приложения не обрабатывали сообщения повторно.

   Чтобы удалить принятое сообщение из очереди, используйте значение параметра `ReceiptHandle` из ответа на предыдущий запрос:

   {% list tabs %}

   - AWS CLI
  
     ```
     $ aws sqs delete-message \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
                 --receipt-handle EAEggbjIg_8sKAM
     ```
  
   {% endlist %}

1. Удалите очередь:

   {% list tabs %}
   - AWS CLI
  
     ```
     $ aws sqs delete-queue \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
                 --endpoint https://message-queue.api.cloud.yandex.net/
     ```
  
   - Консоль управления
  
     1. Откройте раздел **Message Queue**.
     1. Нажмите значок ![image](../_assets/vertical-ellipsis.svg) в строке очереди, которую требуется удалить.
     1. В открывшемся меню нажмите кнопку **Удалить**.
     1. В открывшемся окне нажмите кнопку **Удалить**.
   {% endlist %}
