[Документация Yandex Cloud](../index.md) > [Yandex Message Queue](index.md) > Начало работы > Быстрый старт

# Начало работы с Message Queue

Выполним основные действия с использованием [AWS CLI](https://aws.amazon.com/ru/cli/) — одного из [инструментов](instruments/index.md) для работы с Message Queue.

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI — утилиту командной строки для работы с Message Queue.
1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт с ролью `editor`.
1. [Создайте](../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
1. Настройте AWS CLI:

   1. Запустите интерактивную настройку профиля:
   
      ```bash
      aws configure
      ```
   
   1. Укажите полученный ранее идентификатор ключа сервисного аккаунта:
   
      ```bash
      AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
      ```
   
   1. Укажите полученный ранее секретный ключ сервисного аккаунта:
   
      ```bash
      AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
      ```
   
   1. Укажите имя региона по умолчанию `ru-central1`:
   
      ```bash
      Default region name [ru-central1]: ru-central1
      ```
   
   1. Укажите формат выходных данных по умолчанию `json`:
   
      ```bash
      Default output format [None]: json
      ```
   
   1. Чтобы посмотреть текущие настройки профиля, выполните команду:
   
      ```bash
      aws configure list
      ```
   
      Результат:
   
      ```text
            Name                    Value             Type    Location
            ----                    -----             ----    --------
         profile                <not set>             None    None
      access_key     ****************aBc1 shared-credentials-file
      secret_key     ****************DeF2 shared-credentials-file
          region              ru-central1      config-file    ~/.aws/config
      ```

1. Создайте очередь с именем `sample-queue`:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs create-queue \
       --queue-name <имя_очереди> \
       --endpoint <эндпоинт>
     ```

     Где:

     * `--queue-name` — имя создаваемой очереди, например `sample-queue`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.

     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.api.cloud.yandex.net/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

     Сохраните полученный URL очереди, он понадобится позднее.

   - Консоль управления

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать очередь.
     1. Перейдите в сервис **Message Queue**.
     1. Нажмите кнопку **Создать очередь**.
     1. Укажите имя очереди: `sample-queue`.

        Имя может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания. Имя очереди FIFO должно заканчиваться суффиксом `.fifo`. Длина имени не должна превышать 80 символов.

     1. Выберите тип `Стандартная`. Не изменяйте другие настройки.
     1. Нажмите кнопку **Создать**.
     1. Откройте созданную очередь.
     1. На вкладке **Обзор** в блоке **Общая информация** скопируйте URL очереди, он понадобится позднее.


   {% endlist %}

1. Отправьте сообщение в созданную очередь, используя сохраненный ранее URL очереди:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs send-message \
       --message-body "<текст_сообщения>" \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```

     Где:

     * `--message-body` — текст отправляемого в очередь сообщения, например, `Hello World`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.
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

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs receive-message \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```

     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.
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

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs delete-message \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
       --receipt-handle <идентификатор_получения>
     ```
     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.
     * `--queue-url` — URL очереди, из которой нужно удалить сообщение.
     * `--receipt-handle` — сохраненный ранее идентификатор получения сообщения `ReceiptHandle`.

   {% endlist %}

1. Удалите очередь:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs delete-queue \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```

     Где:

     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.
     * `--queue-url` — URL очереди, которую нужно удалить.

   - Консоль управления

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит очередь.
     1. Перейдите в сервис **Message Queue**.
     1. Нажмите значок ![image](../_assets/console-icons/ellipsis.svg) напротив нужной очереди и выберите **Удалить**.
     1. В открывшемся окне нажмите кнопку **Удалить**.

   {% endlist %}