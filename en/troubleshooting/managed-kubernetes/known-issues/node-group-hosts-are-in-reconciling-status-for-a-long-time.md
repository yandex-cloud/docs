# {{ managed-k8s-name }} node group hosts stay in the `RECONCILING` status for a while


## Issue description {#issue-description}

Some (or all) VMs of your {{ managed-k8s-name }} node group remain in the `RECONCILING` status for more than 20 minutes.

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

* Check your quota consumption for {{ managed-k8s-name }}. If the consumption level is approaching the current quotas, [request a quota increase]({{ link-console-quotas }}). For this, you must have the `quota-manager.requestOperator` role or higher, such as `{{ roles-editor }}` or `{{ roles-admin }}`.
* If the quotas are not exceeded, check the state of VMs belonging to the node group through this command:

```
yc managed-kubernetes node-group list-nodes <node_group_id> --format yaml
```

If the command output includes the `Kubelet stopped posting node status` message, it means the VM belonging to the node group experienced a failure in the OS or application services that ensure operability of this host within the node group.

## Solution {#issue-resolution}

Follow these steps to fix the issue:

1. Connect to the VM in question over SSH. You can learn how to do it in [this {{ managed-k8s-name }} guide](../../../managed-kubernetes/operations/node-connect-ssh.md).
1. Establish an interactive session with the problematic VM and run the following commands:
   ```
   sudo service containerd restart
   sudo service kubelet restart
   ```

{% note info %}

To check the service status, use the following commands:
```
service containerd status
service kubelet status
```
Make sure the services are `ACTIVE` and their logs are error-free.

{% endnote %}

Alternatively, you can restart your VM from the [management console]({{ link-console-main }}) or YC CLI.