---
title: "Инструкция по сбору и поставке данных {{ ydb-full-name }} с помощью AWS CLI"
description: "Из статьи вы узнаете, как собирать и поставлять данные {{ ydb-full-name }} с помощью AWS CLI."
---

# AWS CLI

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится поток данных.
1. Выберите сервис **{{ yds-full-name }}**.
1. Выберите поток данных.
1. Нажмите **Подключиться** и перейдите на вкладку **AWS CLI**.
1. Скопируйте пример команды для отправки сообщения и выполните ее. Поставка данных будет осуществляться по протоколу AWS Kinesis Data Streams.

   Пример команды:

   ```bash
   aws kinesis \
     --endpoint https://yds.serverless.yandexcloud.net \
     put-record \
     --stream-name /{{ region-id }}/aoegtvhtp8ob9rqq8sto/cc8004q4lbo6bv9iivr0/test \
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
