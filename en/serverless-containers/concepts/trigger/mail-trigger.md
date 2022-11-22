# Email trigger

An email trigger launches a {{ serverless-containers-name }} [container](../container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to call its container.

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For the trigger to fire, the service account requires the `serverless.containers.invoker` role for the container invoked by the trigger.

## Email trigger message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## See also {#see-also_}

* [Email trigger that calls a {{ sf-name }} function](../../../functions/concepts/trigger/mail-trigger.md).
