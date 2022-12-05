# {{ iot-short-name }} trigger that passes messages to the {{ serverless-containers-name }} container

The [trigger](../trigger/) for {{ iot-short-name }} is designed for managing messages exchanged between devices and registries. The trigger is created for [topics](../../../iot-core/concepts/topic/index.md): it receives copies of messages from them and passes those copies to the {{serverless-containers-name }} container for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke the container.

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the trigger.

Read more about [access management](../../security/index.md).

## {{ iot-short-name }} trigger message format {#format}

Before the message is copied to a container, the trigger converts it to the following format:

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

## See also {#see-also}

* [{{ iot-name }} trigger that passes messages to the {{ sf-name }} function](../../../functions/concepts/trigger/iot-core-trigger.md).
