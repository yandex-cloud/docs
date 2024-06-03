The `dataproc.agent` role allows the [service account](../../iam/concepts/users/service-accounts.md) linked to the Yandex Data Proc cluster to notify Data Proc of the cluster host state. You can assign this role to a service account linked to the Yandex Data Proc cluster.

Service accounts with this role can:
* Notify Yandex Data Proc of the [cluster](../../data-proc/concepts/index.md#resources) host state.
* Get info on [jobs](../../data-proc/concepts/jobs.md) and their progress statuses.
* Get info on [log groups](../../logging/concepts/log-group.md) and add entries to them.

Currently, you can only assign this role for a folder or cloud.
