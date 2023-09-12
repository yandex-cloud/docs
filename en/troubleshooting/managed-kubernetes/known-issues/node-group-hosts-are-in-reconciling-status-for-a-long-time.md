# Hosts of the Managed Service for Kubernetes node groups stay in the Reconciling status for a long time

## Issue description {#issue-description}

Some (or all) VMs of your Managed Service for Kubernetes node group are in the Reconciling status for more than 20 minutes.

## Troubleshooting and reproducing issues {#diagnosis-and-reproduction}

* Check your quota consumption on Managed Service for Kubernetes. If the consumption level is approaching the current quotas, [request quota increase]({{ link-console-quotas }}). You must have the `quota-manager.requestOperator` `role` or higher (`editor` or admin).
* The quotas are not exceeded, check the state of VM instances belonging to the node group by the command:

```
yc managed-kubernetes node-group list-nodes <node_group_id> --format yaml
```

If the command output includes the `Kubelet stopped posting node status` message, it means that the instance belonging to the node group experienced a failure in the OS or application services that ensure operability of this host within the node group.

## Solution {#issue-resolution}

1. Use SSH to connect to the problem instance.
   To learn how to connect to another node over SSH, see the [documentation](https://cloud.yandex.ru/docs/managed-kubernetes/operations/node-connect-ssh).

2. Establish an interactive session with the problem instance and execute the following commands:

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

Make sure the services are in the `Active` status and their logs are error-free.

{% endnote %}

Alternatively, you can restart your instance from the management console or YC CLI.