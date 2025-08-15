---
title: Guide for collecting and delivering {{ ydb-full-name }} data using Logstash
description: In this tutorial, you will learn how to collect and deliver {{ ydb-full-name }} data using Logstash.
---

# Logstash

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. Download and install [Logstash](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html).
1. Install the plugin for AWS Kinesis Data Streams protocol support. This protocol will be used for data delivery.

   ```bash
   sudo /usr/share/logstash/bin/logstash-plugin install logstash-output-kinesis
   ```

   {% note info %}

   The plugin utilizes the Amazon Kinesis Producer Library that requires [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) to operate. Download and install it for your platform. At startup, verify JDK version 1.8.235 or higher is installed.

   {% endnote %}

1. In the [management console]({{ link-console-main }}), select the folder containing your data stream.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
1. Select the data stream.
1. Click **{{ ui-key.yacloud.data-streams.button_connect }}** and navigate to the **Logstash** tab.
1. Copy the example configuration and paste it into the `/usr/share/logstash/bin/mypipeline.conf` file.

   Example configuration:

   ```text
   input {
     http {
       port => 8888
     }
   }
   output {
     stdout { codec => rubydebug}
     kinesis {
       stream_name => "/{{ region-id }}/aoegtvhtp8ob********/cc8004q4lbo6********/test"
       region => "ru-central-1"
       verify_certificate => false
       codec => json_lines
       randomized_partition_key => true
       access_key => "<access_key_ID>"
       secret_key => "<secret_key>"
       metrics_level => "none"
       endpoint => "https://yds.serverless.yandexcloud.net"
     }
   }
   ```

   {% include [aws-sdk-attr](../../_includes/data-streams/aws-sdk-attr.md) %}

1. Start data delivery:

   ```bash
   sudo /usr/share/logstash/bin/logstash -f mypipeline.conf
   ```

1. Send test data to Logstash:

   ```bash
   curl \
     --request PUT 'http://127.0.0.1:8888/kinesis' \
     --header "content-type: application/json" \
     --data '{"user_id":"user1", "score": 100}'
   ```

   If the setup is successful, the Logstash console will show a message confirming data receipt and its transmission to {{ yds-name }} via the AWS Kinesis Data Streams protocol:

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
   Stage 1 Triggers: { stream: '/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 0, UserRecords: 0, KinesisRecords: 0 }
   Stage 2 Triggers: { stream: '/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/logstash_stream', manual: 0, count: 0, size: 0, matches: 0, timed: 1, KinesisRecords: 1, PutRecords: 1 }
   (test) Average Processing Time: 723 ms
   ```
