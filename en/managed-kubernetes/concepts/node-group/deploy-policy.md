# Node group deployment policy in {{ managed-k8s-name }}

When [modifying](../../operations/node-group/node-group-update.md) a node group (including during a [{{ k8s }} version update](../../operations/update-kubernetes.md#node-group-upgrade)), you may need to stop, reboot, or delete the group's nodes. As soon as you do it, the group will enter the `Reconciling` status, and the nodes will become unavailable.

With a _deployment policy_, you can control the number of available nodes in the group during such operations. You set the policy with a pair of parameters, `max_expansion` and `max_unavailable`, which you configure when [creating](../../operations/node-group/node-group-create.md) or [modifying](../../operations/node-group/node-group-update.md) a node group.

#|
|| **Parameter** | **Description** ||
|| `max_expansion` | Maximum number of nodes by which you can expand the group when modifying or updating it.

These nodes are not temporary and are created with the new parameters specified for the group, e.g., designating the computing resources or {{ k8s }} version.

The minimum value is `0` (node group expansion prohibited), the maximum value is `100`, and the default value is `3`.

If the node group expansion is prohibited, you should allow the group to have unavailable nodes. ||
|| `max_unavailable` | Maximum number of unavailable nodes when the group is being modified or updated.

The minimum value is `0` (the group must not have unavailable nodes), the maximum value is `100`, and the default value is `0`.

If the group must not have any unavailable nodes, you should allow expanding the node group. ||
|#

The `max_expansion` and `max_unavailable` parameters are interrelated, and at least one of them must have a non-zero value.

When you modify or update a node group, the cluster follows the deployment policy specified for it. The cluster's behavior will vary depending on how the policy is configured:

{% include [deploy-policy-concept-behavior](../../../_includes/managed-kubernetes/deploy-policy/concept-behavior.md) %}

### See also {#see-also}

* [{#T}](../../operations/node-group/node-group-update.md#configure-deploy-policy)
* [{#T}](./cluster-autoscaler.md)
* [{#T}](../../operations/update-kubernetes.md)