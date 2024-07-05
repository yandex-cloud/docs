To disable access to nodes using SSH keys, do any one of the following:

* Enable access via {{ oslogin }}.
* [Change metadata](../../managed-kubernetes/operations/node-group/node-group-update.md#update-metadata) by deleting the metadata with the `ssh-keys` key.

   After deleting this metadata, you will not be able to connect to the {{ managed-k8s-name }} cluster nodes until you add one or more SSH keys.

