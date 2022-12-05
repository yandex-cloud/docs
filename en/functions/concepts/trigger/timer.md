# Timer that invokes a {{ sf-name }} function

_Timer_ is a [trigger](../trigger/) that calls a {{ sf-name }} [function](../function.md) on a schedule. The schedule is entered as a [cron expression](#cron-expression). The cron expression uses [Coordinated Universal Time](https://ru.wikipedia.org/wiki/Всемирное_координированное_время) (UTC).

A timer needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a function.

{% include [cron-expression](../../../_includes/functions/cron-expression.md) %}

## Roles required for timers to run correctly {#roles}

* To create a timer, you need a permission for the service account that runs the timer executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a timer, the service account needs the `{{ roles-functions-ivoker }}` role for the folder containing the function called by the timer.

Read more about [access management](../../security/index.md).

## Timer message format {#format}

After the trigger is activated, it sends the following message to the function:

{% include [timer-format](../../../_includes/functions/timer-format.md) %}

## See also {#see-also}

* [Timer that calls a {{ serverless-containers-name }} container](../../../serverless-containers/concepts/trigger/timer.md).
