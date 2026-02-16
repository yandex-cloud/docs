* [dataproc.agent](../../data-proc/security/index.md#dataproc-agent): To enable the service account to get info on cluster host states, [jobs](../../data-proc/concepts/jobs.md), and [log groups](../../logging/concepts/log-group.md).
* [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner): To enable the service account to work with an autoscaling instance group. This will enable [subcluster autoscaling](../../data-proc/concepts/autoscaling.md).

{% note tip %}

To restrict the permissions of a cluster's service account (its IAM token is available when running jobs):

1. Specify a separate service account for cluster autoscaling when [creating](../../data-proc/operations/cluster-create.md) or [updating](../../data-proc/operations/cluster-update.md) a cluster via {{ yandex-cloud }} CLI, {{ TF }}, or API.
1. Assign the `dataproc.provisioner` role to this account only.

{% endnote %}
