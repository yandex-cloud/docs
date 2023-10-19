# Trigger for {{ iot-short-name }} that sends messages to the {{ serverless-containers-name }} container

A [trigger](../trigger/) for {{ iot-short-name }} is designed for managing messages exchanged between devices, registries, and brokers. The trigger is created for [topics](../../../iot-core/concepts/topic/index.md): it receives copies of messages from them and sends these copies to the {{ serverless-containers-name }} container for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

For more information about creating a trigger for {{ iot-short-name }}, see [{#T}](../../operations/iot-core-trigger-create.md) and [{#T}](../../operations/iot-core-trigger-broker-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ iot-short-name }} message format {#format}

Before copying a message to a container, the trigger converts the copy to the below format.

### Device {#device}

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

### Broker {#broker}

{% include [iot-format](../../../_includes/functions/iot-format-broker.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that sends messages to the {{ sf-name }} function](../../../functions/concepts/trigger/iot-core-trigger.md).
