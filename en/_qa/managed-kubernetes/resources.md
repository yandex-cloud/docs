#### What resources do I need to maintain a {{ k8s }} cluster with a group of, say, three nodes? {#required-resources}

Each [node](../../managed-kubernetes/concepts/index.md#node-group) needs resources to run the {{ k8s }} components that allow the node to work as part of the [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). For more information, see [{#T}](../../managed-kubernetes/concepts/node-group/allocatable-resources.md).

#### Can I change resources for each node in a {{ k8s }} cluster? {#change-resources}

You can only change resources for a node group. You can create groups with different configurations in a single {{ k8s }} cluster and spread them across multiple [availability zones](../../overview/concepts/geo-scope.md). For more information, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-update.md).

#### Who handles {{ k8s }} cluster scaling? {#scaling}

In {{ managed-k8s-name }}, you can enable [cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).

#### Do the {{ k8s }} cluster nodes need internet access? {#internet-access}

{% include [nodes-internet-access](../../_includes/managed-kubernetes/nodes-internet-access.md) %}

{% include [nodes-internet-access-additional](../../_includes/managed-kubernetes/nodes-internet-access-additional.md) %}