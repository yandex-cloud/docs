# Trigger for {{ iot-short-name }} that sends messages to WebSocket connections

A [trigger](../trigger/) for {{ iot-short-name }} manages messages exchanged between devices, registries, and brokers. It is created for topics: it receives copies of messages from the topics and sends the messages to [WebSocket connections](../extensions/websocket.md) for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} requires a [service account](../../../iam/concepts/users/service-accounts.md) to send messages to WebSocket connections.

For more information about creating a trigger for {{ iot-short-name }}, see [{#T}](../../operations/trigger/iot-core-trigger-create.md) and [{#T}](../../operations/trigger/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/api-gateway/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [{{ roles-editor }}](../../../iam/roles-reference.md#editor) roles or higher.
* To activate a trigger, the service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#format}

Before sending a message copy to WebSocket connections, the trigger converts it to the format below.

### Device {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Broker {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages to a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/iot-core-trigger.md)
* [Trigger for {{ iot-name }} that sends messages to a {{ sf-name }} function](../../../functions/concepts/trigger/iot-core-trigger.md)
