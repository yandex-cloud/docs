# AWS CLI

В этом разделе вы узнаете, как отправлять отдельные сообщения с помощью [AWS CLI](https://aws.amazon.com/ru/cli/).

{{yds-full-name}} поддерживает протокол AWS Kinesis Data Streams. Поставка данных с помощью AWS CLI будет осуществляться по этому протоколу.

Чтобы отправить данные с помощью AWS CLI:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится поток данных.
1. В списке сервисов выберите **{{ yds-full-name }}**.
1. Нажмите на имя созданного ранее потока данных.
1. Нажмите **Подключиться** и перейдите на вкладку **AWS CLI**.
1. Скопируйте пример команды для отправки отдельного сообщения и выполните команду.

   Пример команды:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /ru-central1/aoegtvhtp8ob9rqq8sto/cc8004q4lbo6bv9iivr0/test \
     --cli-binary-format raw-in-base64-out \
     --data '{"user_id":"user1", "score": 100}' \
     --partition-key 1
   ```

   Результат:

   ```json
   {
      "ShardId": "shard-000001",
      "SequenceNumber": "3130",
      "EncryptionType": "NONE"
   }
   ```