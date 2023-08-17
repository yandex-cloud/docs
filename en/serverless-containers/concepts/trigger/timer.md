# Timer that invokes a {{ serverless-containers-name }} container

_Timer_ is a [trigger](../trigger/) that invokes a {{ serverless-containers-name }} [container](../container.md) on a schedule. The schedule is entered as a [cron expression](../../../_includes/functions/cron-expression.md#cron-expression). The cron expression uses [UTC time](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

A timer needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a container.

For more information about creating a timer, see [{#T}](../../operations/timer-create.md).

{% include [cron-expression](../../../_includes/functions/cron-expression.md) %}

## Roles required for timers to run correctly {#roles}

* To create a timer, you need a permission for the service account that runs the timer executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.
* To run a timer, the service account needs the `serverless.containers.invoker` role for the folder with the container to be invoked by the timer.

Read more about [access management](../../security/index.md).

## Timer message format {#format}

After the trigger is activated, it sends the following message to the container:

{% include [timer-format](../../../_includes/functions/timer-format.md) %}

## See also {#see-also}

* [Timer that invokes a {{ sf-name }} function](../../../functions/concepts/trigger/timer.md).