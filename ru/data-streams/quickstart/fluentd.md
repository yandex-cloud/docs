---
title: "Инструкция по сбору и поставке данных {{ ydb-full-name }} с помощью Fluentd"
description: "Из статьи вы узнаете, как собирать и поставлять данные {{ ydb-full-name }} с помощью Fluentd."
---

# Fluentd

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. Скачайте и установите [Fluentd](https://www.fluentd.org/download).
1. Установите плагин Fluentd для поддержки протокола AWS Kinesis Data Streams. По этому протоколу будет осуществляться поставка данных.

   ```bash
   sudo td-agent-gem install fluent-plugin-kinesis
   ```

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится поток данных.
1. Выберите сервис **{{ yds-full-name }}**.
1. Выберите поток данных.
1. Нажмите **Подключиться** и перейдите на вкладку **Fluentd**.
1. Скопируйте пример файла конфигурации и вставьте его в файл `/etc/td-agent/td-agent.conf`.

   {% include [aws-sdk-attr](../../_includes/data-streams/aws-sdk-attr.md) %}

   Пример файла конфигурации:

   ```xml
   <system>
     log_level debug
   </system>
   <source>
     @type http
     @id input_http
     port 8888
   </source>
   <match kinesis>
     @type copy
     <store>
       @type stdout
     </store>
     <store>
       @type kinesis_streams

       aws_key_id <key_id>
       aws_sec_key <secret>

       # kinesis stream name
       stream_name /{{ region-id }}/aoegtvhtp8ob9rqq8sto/cc8004q4lbo6bv9iivr0/test

       # region
       region ru-central-1

       endpoint https://yds.serverless.yandexcloud.net 

       <buffer>
         flush_interval 5s
       </buffer>
     </store>
   </match>
   ```

1. Отправьте тестовые данные в Fluentd:

   ```bash
   curl -X POST -d 'json={"user_id":"user1", "score": 100}'  http://localhost:8888/kinesis
   ```

   Если настройка выполнена успешно, в логе работы Fluentd `/var/log/td-agent/td-agent.log` появится сообщение о получении данных и отправке их в {{yds-full-name}} по протоколу AWS Kinesis Data Streams:

   ```text
   kinesis: {"json":"message"}
   DEBUG -- : [Aws::Kinesis::Client 200 0.628973 0 retries] put_records(stream_name:"/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/fluentd_stream",records:[{data:"{\"message\":\"Write chunk 5c0cf5c556654e99cac84b6e231347ba /   2 records /    0 KB\"}\n",partition_key:"6ec03a4e3ba832c85e80290161c1df8e"},{data:"{\"message\":\"Finish writing chunk\"}\n",partition_key:"8ada32f7373e1ab4c48fb96da43d59cf"},{data:"{\"json\":\"message\"}\n",partition_key:"70f21f2decfc90b6f19752cd6e66e611"}])
   ```
