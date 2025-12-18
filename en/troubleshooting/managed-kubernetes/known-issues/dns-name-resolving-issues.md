# Troubleshooting DNS name resolving issues in {{ managed-k8s-name }}


## Issue description {#issue-description}

The {{ managed-k8s-name }} cluster does not resolve FQDNs for either internal or external resources.

## Solution {#issue-resolution}

Check the {{ k8s }} version running on the master and worker nodes by running these commands:

```
yc managed-kubernetes cluster get $CLUSTER_ID | grep vers
yc managed-kubernetes node-group get $NODE_GROUP_ID | grep vers
```

{% note alert %}

If your cluster or node group version is outdated and missing from the list of supported versions (`yc managed-kubernetes list-versions`), update both before proceeding with the diagnostics.

{% endnote %}

If the cluster and node group are running a supported {{ k8s }} version, check whether CoreDNS works properly within the cluster.
To diagnose CoreDNS, you need to analyze the state of the cluster's system DNS pods using the `kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide` command.

{% cut "Example of the `kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide` command output" %}

  ```

  NAME                       READY   STATUS    RESTARTS   AGE   IP              NODE                        NOMINATED NODE   READINESS GATES
  coredns-85fd96f799-2zzvw   1/1     Running   5          21d   10.96.138.252   cl1*****************-yxeg   <none>           <none>
  coredns-85fd96f799-9lz6b   1/1     Running   3          20d   10.96.140.90    cl1*****************-icos   <none>           <none>
  ```

{% endcut %}

Check the statuses of the pods in the cluster. If any pod is not in the `RUNNING` status, use the `kubectl logs -l k8s-app=kube-dns -n kube-system --all-containers=true` command to check the system logs of all DNS pods in the cluster and find the source of the issues.

If the issue with CoreDNS persists, try one of the following solutions:

{% list tabs %}

- Increase the number of CoreDNS pods.
  
  Typically, a cluster has two CoreDNS pods, unless it is a single-node cluster with one pod. You can increase the number of CoreDNS replicas by updating the CoreDNS deployment autoscaling configuration and specifying the `linear` parameter:

  {% cut "Example of kube-dns-autoscaler deployment (`kubectl -n kube-system edit cm kube-dns-autoscaler`)" %}

  ```yaml
  apiVersion: v1
  data:
  linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}' # < These are autoscaling settings.
  kind: ConfigMap
  metadata:
  name: kube-dns-autoscaler
  namespace: kube-system
  selfLink: /api/v1/namespaces/kube-system/configmaps/kube-dns-autoscaler
  ```

  {% endcut %}

  You can learn more about the scaling configuration from {{ k8s }} developer guides on [this GitHub page](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#control-patterns-and-configmap-formats).

- Use NodeLocal DNS. 

  To reduce the load from DNS requests in a {{ managed-k8s-name }} cluster, enable NodeLocal DNS Cache. If a {{ managed-k8s-name }} cluster contains more than 50 nodes, use automatic DNS scaling.

  When NodeLocal DNS Cache is enabled, a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) is deployed in a {{ managed-k8s-name }} cluster. The caching agent (the `node-local-dns` pod) runs on each {{ managed-k8s-name }} node. User pods now send requests to the agent running on their {{ managed-k8s-name }} nodes.

  If the agent's cache contains the request, the agent returns a direct response. Otherwise, the system creates a TCP connection to `kube-dns` `ClusterIP`. By default, the caching agent makes cache-miss requests to `kube-dns` for the `cluster.local` [DNS zone](../../../dns/concepts/dns-zone.md) of the {{ managed-k8s-name }} cluster.

  Install [NodeLocal DNS]
(https://yandex.cloud/en/marketplace/products/yc/node-local-dns) using {{ marketplace-name }} as described in [this guide](../../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install) or manually by following [this tutorial](../../../managed-kubernetes/tutorials/node-local-dns.md).

{% endlist %}

{% note tip %}

You can also reliably troubleshoot DNS issues in your cluster by installing NodeLocal DNS Cache from {{ marketplace-full-name }} following these guides:

* [Getting started with {{ marketplace-name }}](../../../managed-kubernetes/operations/applications/marketplace.md)
* [Installing NodeLocal DNS](../../../managed-kubernetes/operations/applications/node-local-dns.md)

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. {{ managed-k8s-name }} cluster event log: `kubectl get events` output.
1. Cluster DNS service log: `kubectl logs -l k8s-app=kube-dns -n kube-system --all-containers=true` output.
1. Examples of DNS resolution errors in the cluster with the date and time of each issue.