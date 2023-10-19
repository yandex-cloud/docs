# Trigger for {{ iot-short-name }} that sends messages to the {{ sf-name }} function

A [trigger](../trigger/) for {{ iot-short-name }} is designed for managing messages exchanged between devices, registries, and brokers. The trigger is created for topics: it receives copies of messages from them and delivers those copies to the {{ sf-name }} function for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function.

For more information about creating a trigger for {{ iot-short-name }}, see [{#T}](../../operations/trigger/iot-core-trigger-create.md) and [{#T}](../../operations/trigger/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* For the trigger to fire, the service account needs the `{{ roles-functions-invoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#format}

Before the message is copied to a function, the trigger converts it to the format below.

### Device {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Broker {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages to the {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/iot-core-trigger.md).