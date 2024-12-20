---
title: Trigger for {{ yds-full-name }} that invokes a {{ sf-full-name }} function
description: In this article, you will learn about the trigger for {{ yds-name }} which calls the {{ sf-name }} function, the roles required for the trigger, and its message format.
---

# Trigger for {{ yds-name }} that invokes a {{ sf-name }} function

 [Trigger](../trigger/) for {{ yds-name }} calls a {{ sf-name }} [function](../function.md) when data is sent to a [stream](../../../data-streams/concepts/glossary.md#stream-concepts). 

A trigger for {{ yds-name }} needs [service accounts](../../../iam/concepts/users/service-accounts.md) to manage a stream and invoke a function. You can use the same service account for both operations.

For more information about creating a trigger for {{ yds-name }}, see [{#T}](../../operations/trigger/data-streams-trigger-create.md).

## Roles required for the proper operation of a trigger for {{ yds-name }} {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, service accounts need the following roles:
    * `{{ roles-functions-invoker }}` for the function the trigger invokes.
    * `yds.admin` for the stream that invokes the trigger when data is sent there.

## Format of the message from the trigger for {{ yds-name }} {#format}

{% include [trigger-message-format-note](../../../_includes/functions/trigger-message-format-note.md) %}

Once the trigger fires, it will send a message with the `messages` array to the function:

{% include [yds-format](../../../_includes/functions/yds-format.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/data-streams-trigger.md)
