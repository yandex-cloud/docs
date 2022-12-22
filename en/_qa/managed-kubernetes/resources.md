# Resources

#### What resources are needed to maintain a {{ k8s }} cluster with a group of, say, three nodes? {#required-resources}

Each [node](../../managed-kubernetes/concepts/index.md#node-group) needs resources to run the components in charge of running the node as part of the [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). For more information, see [{#T}](../../managed-kubernetes/concepts/node-group/allocatable-resources.md).

#### Can I change resources for each node in a {{ k8s }} cluster? {#change-resources}

You can change resources only for a node group. You can create groups with different configurations in a {{ k8s }} cluster and place them in different [availability zones](../../overview/concepts/geo-scope.md). For more information, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-update.md).

#### Who monitors the scaling of a {{ k8s }} cluster? {#scaling}

In {{ managed-k8s-name }}, you can enable [automatic cluster scaling](../../managed-kubernetes/concepts/autoscale.md#ca).