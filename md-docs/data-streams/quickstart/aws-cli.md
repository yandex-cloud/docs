# AWS CLI

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/concepts/function.md) {{ sf-name }} или [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} при отправке данных в поток. Подробнее о [триггере для {{ yds-name }}](../../functions/operations/trigger/data-streams-trigger-create.md).

{% endnote %}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится поток данных.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
1. Выберите поток данных.
1. Нажмите **{{ ui-key.yacloud.data-streams.button_connect }}** и перейдите на вкладку **AWS CLI**.
1. Скопируйте пример команды для отправки сообщения и выполните ее. Поставка данных будет осуществляться по протоколу AWS Kinesis Data Streams.

   Пример команды:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /{{ region-id }}/aoegtvhtp8ob********/cc8004q4lbo6********/test \
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