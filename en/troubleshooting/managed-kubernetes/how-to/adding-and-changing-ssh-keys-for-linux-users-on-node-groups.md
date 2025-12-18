# How to add and update Linux SSH keys on {{ managed-k8s-name }} node group hosts


## Case description {#case-description}

* You need to add a new Linux user on hosts of the {{ managed-k8s-name }} cluster node group.
* Your need to update an SSH key for an existing Linux user on hosts of the {{ managed-k8s-name }} cluster node group.

## Solution {#case-resolution}

To add a user or update an SSH key for the current user, update the node group keys. Before running this operation, prepare a file with SSH keys for your users in the following format:

```
username:ssh-ed25519 AAAAB3NzaC***********zo/lP1ww== username
username2:ssh-ed25519 ONEMOREkey***********88OavEHw== username2
```

Then, use the YC CLI to run this command:

```
yc managed-kubernetes node-group add-metadata \
  --name <node_group_name> \
  --metadata-from-file ssh-keys=<path_to_file_with_public_SSH_keys>
```
As a result of this command, the following operations will be applied to the cluster's node group:

* Existing users will have their SSH keys updated.
* New users will be created with the specified SSH keys.

When updating SSH keys, the node group switches to `RECONCILING` as the VM instances of this group start updating their metadata.

{% note alert %}

Running a metadata update on a {{ managed-k8s-name }} cluster node group may cause the affected nodes to become partially or fully unavailable for up to 20 minutes.

{% endnote %}