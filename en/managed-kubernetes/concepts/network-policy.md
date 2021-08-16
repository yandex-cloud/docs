# Cluster network policies in {{ k8s }}

{{ k8s }} network policies let you configure networking between pod groups and network nodes. You can create network policies using the [Kubernetes Network Policy API](https://kubernetes.io/docs/concepts/services-networking/network-policies/) that sets rules for filtering traffic at the pod level. These rules determine which pods and services in a {{ k8s }} cluster can access each other.

Network policies help restrict access in {{ k8s }} clusters for multi-level applications to ensure that some services can't interact with others.

## Enabling network policies {#policy-enable}

You can enable network policies when creating a {{ k8s }} cluster:

* In the management console, select **Enable network policies**.
* Using the CLI, set the `--enable-network-policy` flag.
* Using the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

Once you're allowed to use network policies in the {{ k8s }} cluster, you can create a policy via the Kubernetes Network Policy API. For information about how to use network policies, see the [{#T}](../operations/running-network-policy.md) page.

{% note info %}

You can only configure network policies when creating a {{ k8s }} cluster.

{% endnote %}

## Limits {#limitations}

To enable network policies in your {{ k8s }} cluster, make sure that you have:

* A sufficient amount of resources in node groups.
  Using network policies requires additional memory and vCPU resources.

* Two or more nodes in the {{ k8s }} cluster.
  The recommended minimum {{ k8s }} cluster size to enable network policies is two nodes.
