# Email trigger that invokes a {{ sf-name }} function

An email [trigger](../trigger/) launches a {{ sf-name }} [function](../function.md) when an email arrives. The service automatically generates an email address when creating the trigger.

An email trigger requires a [service account](../../../iam/concepts/users/service-accounts.md) to call its function.

For more information about creating an email trigger, see [{#T}](../../operations/trigger/mail-trigger-create.md).

{% include [batching-messages](../../../_includes/functions/batching-messages.md) %}

## Roles required for email trigger to run properly {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For the trigger to fire, the service account requires the `{{ roles-functions-invoker }}` role for the function invoked by the trigger.
* {% include [attachments-requirements](../../../_includes/functions/attachments-requirements.md) %}

## Email trigger message format {#format}

After the trigger is activated, it sends the following message to the function:

{% include [mail-format](../../../_includes/functions/mail-format.md) %}

## See also {#see-also}

* [Email trigger that launches a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/mail-trigger.md).
