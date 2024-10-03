# Email trigger that invokes a {{ serverless-containers-name }} container

An email [trigger](../trigger/) launches a {{ serverless-containers-name }} [container](../container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a container.

For more information about creating an email trigger, see [{#T}](../../operations/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, the service account requires the `serverless.containers.invoker` role for the container invoked by the trigger.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Email trigger message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## See also {#see-also}

* [{#T}](../../../functions/concepts/trigger/mail-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/mail-trigger.md)
