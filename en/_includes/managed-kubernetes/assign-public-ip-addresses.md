To grant internet access to {{ managed-k8s-name }} cluster nodes, do one of the following:
* Assign a [public IP address](../../vpc/concepts/address.md#public-addresses) to the cluster nodes, specifying `--network-interface ipv4-address=nat` or `--network-interface ipv6-address=nat`.
* [Enable access to {{ managed-k8s-name }} nodes from the internet](../../managed-kubernetes/operations/node-group/node-group-update.md#node-internet-access) after creating a node group.
