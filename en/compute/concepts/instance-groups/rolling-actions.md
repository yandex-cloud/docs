# Restarting and recreating instances in a group one by one

Instances in a group can be automatically [restarted](../../operations/instance-groups/rolling-restart.md) or [recreated](../../operations/instance-groups/rolling-recreate.md) one by one based on the parameters specified in the instance group [deployment policy](./policies/deploy-policy.md). These actions can apply both to all instances in the group and to specified instances only.

For example, if the maximum number of unhealthy instances per group set in the deployment policy is `1`, then, when restarting or recreating instances one by one, only one instance will be unavailable at any given time and each next instance will be restarted or recreated only after the status of the previous instance changes to `Running`.

_Restarting group instances one by one_ may be useful, for example, when updating the VM software. This feature allows performing automatic software updates with no downtime of the instance group resources for end users.

_Recreating group instances one by one_ may be useful, for example, when migrating an instance group to a different [availability zone](../../../overview/concepts/geo-scope.md). This feature allows recreating instances in a group automatically with no downtime of the instance group resources for end users.

{% include [ig-opportunistic-warning](../../../_includes/compute/ig-opportunistic-warning.md) %}

To restart or recreate instances in a group one by one, use the {{ yandex-cloud }} [CLI](../../../cli/quickstart.md) or make an API request.

### See also {#see-also}

* [{#T}](../../operations/instance-groups/rolling-restart.md)
* [{#T}](../../operations/instance-groups/rolling-recreate.md)
