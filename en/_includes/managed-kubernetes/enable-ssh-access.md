To enable access to nodes using SSH keys:

1. Make sure that access via {{ oslogin }} is disabled.
1. Make sure that the node group metadata contains at least one SSH key. If needed, add or delete keys by [changing the metadata](../../managed-kubernetes/operations/node-group/node-group-update.md#update-metadata) with the `ssh-keys` key.
