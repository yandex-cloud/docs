# Adding and updating Linux SSH keys on Managed Services for Kubernetes node group hosts

## Issue description {#case-description}
* When running a Managed Service for Kubernetes cluster, you need to add a new Linux user on hosts of a cluster node of your Managed Service for Kubernetes cluster.
* When running a Managed Service for Kubernetes cluster, your need to update an SSH key for an existing Linux user on hosts of a cluster node of your Managed Service for Kubernetes cluster.


## Solution {#case-solution}
To add a user or update an SSH key for the current user, update the node group keys.
Before running this operation, prepare a file with SSH keys for your users in the following format:

```
username:ssh-ed25519 AAAAB3NzaC***********zo/lP1ww== username
username2:ssh-ed25519 ONEMOREkey***********88OavEHw== username2
```

Then use YC CLI to execute the command:

```
yc managed-kubernetes node-group add-metadata \
  --name <node_group_name> \
  --metadata-from-file ssh-keys=<path_to_file_with_public_ssh_keys>
```

As a result of this command, the following operations will be applied to the cluster's node group:
* SSH keys of existing users will be updated with the new ones.
* New users will be created with the given SSH keys.

When updating SSH keys, the node group will switch to `Reconciling`, because the VMs belonging to this group will run metadata update.

{% note alert %}

In the process of metadata update for a Managed Services for Kubernetes cluster node group, the nodes in the affected group might become fully or partially unavailable for up to 20 minutes.

{% endnote %}