# Email trigger that invokes a {{ serverless-containers-name }} container

An email [trigger](../trigger/) launches a {{ serverless-containers-name }} [container](../container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a container.

For more information about creating an email trigger, see [{#T}](../../operations/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/serverless-containers/batching-messages.md) %}

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For the trigger to fire, the service account requires the `serverless.containers.invoker` role for the container invoked by the trigger.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Email trigger message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## See also {#see-also}

* [Email trigger that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/mail-trigger.md).
