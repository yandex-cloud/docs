# Trigger for {{ yds-name }} that invokes a {{ serverless-containers-name }} container

 [Trigger](../trigger/) for {{ yds-name }} calls a {{ serverless-containers-name }} [container](../container.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). 

A trigger for {{ yds-name }} needs [service accounts](../../../iam/concepts/users/service-accounts.md) to manage a stream and invoke a container. You can use the same service account for both operations.

For more information about creating a trigger for {{ yds-name }}, see [{#T}](../../operations/data-streams-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* To run a trigger, service accounts need the following roles:
   * `serverless.containers.invoker` for the container that the trigger invokes.
   * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

After the trigger is activated, it sends a message to the container. The message format depends on the source and is an array of `messages`:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## See also {#see-also}

* [Trigger for {{ yds-name }} that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/data-streams-trigger.md).