[Документация Yandex Cloud](../../index.md) > [Yandex Data Streams](../index.md) > [Начало работы](index.md) > Сбор и поставка данных > Logstash

# Logstash

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/concepts/function.md) Cloud Functions или [контейнер](../../serverless-containers/concepts/container.md) Serverless Containers при отправке данных в поток. Подробнее о [триггере для Data Streams](../../functions/operations/trigger/data-streams-trigger-create.md).

{% endnote %}

1. Скачайте и установите [Logstash](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html).
1. Установите плагин для поддержки протокола AWS Kinesis Data Streams. По этому протоколу будет осуществляться поставка данных.

   ```bash
   sudo /usr/share/logstash/bin/logstash-plugin install logstash-output-kinesis
   ```

   {% note info %}

   Плагин использует библиотеку Amazon Kinesis Producer Library. Для ее работы необходим [Java Development Kit (JDK)](https://www.oracle.com/ru/java/technologies/javase/javase-jdk8-downloads.html). Скачайте и установите его для вашей платформы. При запуске убедитесь, что используется версия JDK 1.8.235 или выше.

   {% endnote %}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится поток данных.
1. Перейдите в сервис **Data Streams**.
1. Выберите поток данных.
1. Нажмите **Подключиться** и перейдите на вкладку **Logstash**.
1. Скопируйте пример файла конфигурации и вставьте его в файл `/usr/share/logstash/bin/mypipeline.conf`.

   Пример файла конфигурации:

   ```text
   input {
     http {
       port => 8888
     }
   }
   output {
     stdout { codec => rubydebug}
     kinesis {
       stream_name => "/ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test"
       region => "ru-central-1"
       verify_certificate => false
       codec => json_lines
       randomized_partition_key => true
       access_key => "<идентификатор_ключа_доступа>"
       secret_key => "<секретный_ключ>"
       metrics_level => "none"
       endpoint => "https://yds.serverless.yandexcloud.net"
     }
   }
   ```

   Где:
   
   * `<идентификатор_ключа_доступа>` — идентификатор [статического ключа доступа](../../iam/concepts/authorization/access-key.md).
   * `<секретный_ключ>` — секретная часть статического ключа доступа.

1. Запустите поставку данных:

   ```bash
   sudo /usr/share/logstash/bin/logstash -f mypipeline.conf
   ```

1. Отправьте тестовые данные в Logstash:

   ```bash
   curl \
     --request PUT 'http://127.0.0.1:8888/kinesis' \
     --header "content-type: application/json" \
     --data '{"user_id":"user1", "score": 100}'
   ```

   Если настройка выполнена успешно, в консоли работы Logstash появится сообщение о получении данных и отправке их в Data Streams по протоколу AWS Kinesis Data Streams:

   ```text
   {
     "@version" => "1",
     "headers" => {
       "request_path" => "/kinesis",
       "http_version" => "HTTP/1.1",
       "content_type" => "application/json",
       "http_host" => "127.0.0.1:8888",
       "http_accept" => "*/*",
       "request_method" => "PUT",
       "content_length" => "18",
       "http_user_agent" => "curl/7.68.0"
     },
     "host" => "127.0.0.1",
     "json" => "message"
   }
   Stage 1 Triggers: { stream: '/ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 0, UserRecords: 0, KinesisRecords: 0 }
   Stage 2 Triggers: { stream: '/ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 1, KinesisRecords: 1, PutRecords: 1 }
   (test) Average Processing Time: 723 ms
   ```