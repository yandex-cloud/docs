# Logstash

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. Download and install [Logstash](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html).

1. Install the plugin to support the AWS Kinesis Data Streams protocol. This protocol will be used for streaming data.

   ```bash
   sudo /usr/share/logstash/bin/logstash-plugin install logstash-output-kinesis
   ```

   {% note info %}

   The plugin uses the Amazon Kinesis Producer Library. It requires the [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/downloads/#java8) to work. Download and install it for your platform. At startup, make sure that you are using JDK version 1.8.235 or higher.

   {% endnote %}

1. In the [management console]({{ link-console-main }}), select the folder where the stream is located.

1. Select **{{ yds-full-name }}**.

1. Select the stream.

1. Click **Connect** and go to the **Logstash** tab.

1. Copy the sample configuration file and paste it into the `/usr/share/logstash/bin/mypipeline.conf` file.

   {% include [aws-sdk-attr](../../_includes/data-streams/aws-sdk-attr.md) %}

   Sample configuration file:

   ```text
   input {
     http {
       port => 8888
     }
   }
   output {
     stdout { codec => rubydebug}
     kinesis {
       stream_name => "/{{ region-id }}/aoegtvhtp8ob9rqq8sto/cc8004q4lbo6bv9iivr0/test"
       region => "ru-central-1"
       verify_certificate => false
       codec => json_lines
       randomized_partition_key => true
       access_key => "<key_id>"
       secret_key => "<secret>"
       metrics_level => "none"
       endpoint => "https://yds.serverless.yandexcloud.net"
     }
   }
   ```

1. Start data delivery:

   ```bash
   sudo /usr/share/logstash/bin/logstash -f mypipeline.conf
   ```

1. Send test data to Logstash:

   ```bash
   curl -H "content-type: application/json" -XPUT 'http://127.0.0.1:8888/kinesis' -d '{"user_id":"user1", "score": 100}'
   ```

   If the setup was a success, a message will appear in the Logstash console about receiving data and sending it to {{ yds-name }} over the AWS Kinesis Data Streams protocol:

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
   Stage 1 Triggers: { stream: '/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 0, UserRecords: 0, KinesisRecords: 0 }
   Stage 2 Triggers: { stream: '/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 1, KinesisRecords: 1, PutRecords: 1 }
   (test) Average Processing Time: 723 ms
   ```

