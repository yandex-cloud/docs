# Trigger for {{ iot-short-name }} that sends messages to a {{ sf-name }} function

A [trigger](../trigger/) for {{ iot-short-name }} manages messages exchanged between devices, registries, and brokers. You create this trigger for topics: it receives copies of messages from topics and sends those to the {{ sf-name }} function for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}
 
A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function. 

For more information about creating a trigger for {{ iot-short-name }}, see [{#T}](../../operations/trigger/iot-core-trigger-create.md) and [{#T}](../../operations/trigger/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger runs the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [{{ roles-editor }}](../../../iam/roles-reference.md#editor) roles or higher.
* For the trigger to fire, the service account needs the `{{ roles-functions-invoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#format}

Before the message is copied to a function, the trigger converts it to the format below.

### Device {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Broker {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/data-recording.md)
* [{#T}](../../tutorials/monitoring.md)

## See also {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/iot-core-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/iot-core-trigger.md)
