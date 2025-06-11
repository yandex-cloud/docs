---
title: Tutorial on collecting and delivering {{ ydb-full-name }} data using Fluentd
description: In this tutorial, you will learn how to collect and deliver {{ ydb-full-name }} data using Fluentd.
---

# Fluentd

{% include [trigger](../../_includes/data-streams/trigger.md) %}

1. Download and install [Fluentd](https://www.fluentd.org/download).
1. Install the Fluentd plugin to support the AWS Kinesis Data Streams protocol. This protocol will be responsible for streaming data.

   ```bash
   sudo fluent-gem install fluent-plugin-kinesis
   ```

1. In the [management console]({{ link-console-main }}), select the folder with the stream.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
1. Select the data stream.
1. Click **{{ ui-key.yacloud.data-streams.button_connect }}** and go to the **Fluentd** tab.
1. Copy the configuration file example and paste it into the `/etc/td-agent/td-agent.conf` file.

   Example of the configuration file:

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

       aws_key_id <access_key_ID>
       aws_sec_key <secret_key>

       # kinesis stream name
       stream_name /{{ region-id }}/aoegtvhtp8ob********/cc8004q4lbo6********/test

       # region
       region ru-central-1

       endpoint https://yds.serverless.yandexcloud.net

       <buffer>
         flush_interval 5s
       </buffer>
     </store>
   </match>
   ```

   {% include [aws-sdk-attr](../../_includes/data-streams/aws-sdk-attr.md) %}

1. Send the test data to Fluentd:

   ```bash
   curl \
    --request POST \
    --data 'json={"user_id":"user1", "score": 100}' \
    http://localhost:8888/kinesis
   ```

   If the setup is successful, the Fluentd `/var/log/td-agent/td-agent.log` operation log will include a message about receiving the data and sending it to {{ yds-full-name }} over the AWS Kinesis Data Streams protocol:

   ```text
   kinesis: {"json":"message"}
   DEBUG -- : [Aws::Kinesis::Client 200 0.628973 0 retries] put_records(stream_name:"/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/fluentd_stream",records:[{data:"{\"message\":\"Write chunk 5c0cf5c556654e99cac84*********** /   2 records /    0 KB\"}\n",partition_key:"6ec03a4e3ba832c85e802***********"},{data:"{\"message\":\"Finish writing chunk\"}\n",partition_key:"8ada32f7373e1ab4c48fb***********"},{data:"{\"json\":\"message\"}\n",partition_key:"70f21f2decfc90b6f1975***********"}])
   ```
