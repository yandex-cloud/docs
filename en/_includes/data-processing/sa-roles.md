* [dataproc.agent](../../data-proc/security/index.md#dataproc-agent): To enable the service account to get info on cluster host states, [jobs](../../data-proc/concepts/jobs.md), and [log groups](../../logging/concepts/log-group.md).
* [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner): To enable the service account to work with an autoscaling instance group. This will enable [subcluster autoscaling](../../data-proc/concepts/autoscaling.md).
* [resource-manager.auditor](../../resource-manager/security/index.md#resource-manager-auditor) or higher for the folder where you want to create a {{ dataproc-name }} cluster: For connection to the cluster using [{{ oslogin }}](../../organization/concepts/os-login.md).

{% note tip %}

To restrict the permissions of a cluster's service account (its IAM token is available when running jobs):

1. Specify a separate service account for cluster autoscaling when [creating](../../data-proc/operations/cluster-create.md) or [updating](../../data-proc/operations/cluster-update.md) the cluster via the {{ yandex-cloud }} CLI, {{ TF }}, or API.
1. Assign the `dataproc.provisioner` role to this account only.

{% endnote %}
