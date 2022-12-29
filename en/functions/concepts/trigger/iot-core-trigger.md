# Trigger for {{ iot-short-name }} that passes messages to the {{ sf-name }} function

The [trigger](../trigger/) for {{ iot-short-name }} is designed for managing messages exchanged between devices and registries. The trigger is created for topics: it receives copies of messages from them and passes those copies to the {{ sf-name }} function for processing.

{% include [trigger](../../../_includes/iot-core/trigger.md) %}

A trigger for {{ iot-short-name }} needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function.

## Roles required for the proper operation of a trigger for {{ iot-short-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a trigger, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the trigger.

Read more about [access management](../../security/index.md).

## Trigger for {{ iot-short-name }} message format {#format}

Before the message is copied to a function, the trigger converts it to the following format:

{% include [iot-format](../../../_includes/functions/iot-format.md) %}

## See also {#see-also}

* [Trigger for {{ iot-name }} that passes messages to the {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/iot-core-trigger.md).
