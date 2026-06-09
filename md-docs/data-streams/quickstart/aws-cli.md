# AWS CLI

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/concepts/function.md) Cloud Functions или [контейнер](../../serverless-containers/concepts/container.md) Serverless Containers при отправке данных в поток. Подробнее о [триггере для Data Streams](../../functions/operations/trigger/data-streams-trigger-create.md).

{% endnote %}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится поток данных.
1. Перейдите в сервис **Data Streams**.
1. Выберите поток данных.
1. Нажмите **Подключиться** и перейдите на вкладку **AWS CLI**.
1. Скопируйте пример команды для отправки сообщения и выполните ее. Поставка данных будет осуществляться по протоколу AWS Kinesis Data Streams.

   Пример команды:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test \
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