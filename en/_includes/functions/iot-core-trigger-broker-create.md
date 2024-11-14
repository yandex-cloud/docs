Create a [trigger](../../functions/concepts/trigger/iot-core-trigger.md) for an {{ iot-name }} broker topic and process message copies using a {{ sf-name }} [function](../../functions/concepts/function.md).

{% note warning %}

The trigger must be in the same cloud as the broker whose topic it reads messages from.

{% endnote %}

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Broker](../../iot-core/concepts/index.md#broker) from the topic of which the trigger will collect message copies. If you do not have a broker, [create one](../../iot-core/operations/broker/broker-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot-broker }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:
      
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_broker }}** field, specify the broker.
        * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** field, specify an MQTT topic. If no MQTT topic is set, the trigger fires for all broker topics.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        {% include [batch-settings](batch-settings.md) %}

        {% include [batch-messages](batch-messages.md) %}

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

        {% include [function-settings](function-settings.md) %}
        
    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](repeat-request.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create iot-broker \
      --name <trigger_name> \
      --broker-id <broker_ID> \
      --mqtt-topic '<MQTT_topic>' \
      --batch-size <message_group_size> \
      --batch-cutoff <maximum_timeout> \
      --invoke-function-id <function_ID> \
      --invoke-function-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retry_attempts> \
      --retry-interval <interval_between_retry_attempts> \
      --dlq-queue-id <dead-letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--broker-id`: [Broker ID](../../iot-core/operations/broker/broker-list.md).
    * `--mqtt-topic`: MQTT topic you want to create a trigger for. This is an optional parameter. If this parameter is skipped, the trigger will fire for all broker topics.
    
    {% include [trigger-param](../iot-core/trigger-param-cf.md) %}
    
    {% include [trigger-cli-param](trigger-cli-param.md) %}

    Result:
    
    ```text
    id: a1sl0mkmimfj********
    folder_id: b1g88tflru0e********
    created_at: "2019-09-25T13:54:35.654935Z"
    name: iot-broker-trigger
    rule:
      iot_broker_message:
        broker_id: arenou2oj4**********
        mqtt_topic: topic-for-broker
        batch_settings:
          size: "1"
          cutoff: 0s
        invoke_function:
          function_id: d4eofc7n0m03********
          function_tag: $latest
          service_account_id: aje3932acd0c********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```

- API {#api}

  To create a trigger for {{ iot-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

## See also {#see-also}

* [{#T}](../../serverless-containers/operations/iot-core-trigger-broker-create.md)
* [{#T}](../../api-gateway/operations/trigger/iot-core-trigger-broker-create.md)
