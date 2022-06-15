# Connecting external nodes to the cluster

{% note info %}

Connecting [external nodes](../concepts/external-nodes.md) to a {{ managed-k8s-name }} [cluster](./index.md#kubernetes-cluster) is at the [Preview](../../overview/concepts/launch-stages.md) stage. Using this functionality is free of charge.

{% endnote %}

You can connect external servers to a {{ managed-k8s-name }} cluster using special {{ k8s }} API resources. The definitions ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) of these resources are automatically pre-installed in a cluster.

## Requirements for connecting external resources to a cluster {#requirements}

For external nodes to connect to a {{ managed-k8s-name }} cluster, both the cluster and the connecting servers must meet [certain requirements](../concepts/external-nodes.md#requirements).

## Connection overview

To connect external nodes, you need to [create a node group object](#node-group-create) in the {{ k8s }} API of the cluster to connect to.

Once you have created a group object, you can [add nodes](#add-node) to and [delete nodes](#remove-node) from the cluster.

If you have connection issues, please see the [Troubleshooting](external-nodes-connect.md#troubleshooting) section.

## Creating a node group {#node-group-create}

{% list tabs %}

- Management console

  1. On the {{ k8s }} cluster page, go to **Nodes manager**.
  1. Click **Create node group**, then **External**.
  1. Enter a node group name.
  1. Click **Add**.

- CLI

  In the {{ k8s }} API of the cluster to connect to, create a `NodeGroup` object under the API `mks.yandex.cloud/v1alpha1` group in the `system` [namespace](./index.md#namespace):

  ```yaml
  apiVersion: mks.yandex.cloud/v1alpha1
  kind: NodeGroup
  metadata:
    name: external-node-group
    namespace: system
  ```

{% endlist %}

## Adding nodes to a cluster {#add-node}

{% list tabs %}

- Management console

  1. On the {{ k8s }} cluster page, go to **Nodes manager** tab.
  1. Select the desired node group.
  1. Click **Edit**.
  1. Enter the address of the connecting server accessible from a cluster's cloud network.
  1. Click **Add IP address** to add more addresses if necessary.
  1. Click **Save**.

- CLI

  In the node group object specification, list the IP addresses of the connecting servers accessible from a cluster's cloud network.

  ```bash
  kubectl -n system edit nodegroup external-node-group
  ```

  >Example:
  >
  >```yaml
  >apiVersion: mks.yandex.cloud/v1alpha1
  >kind: NodeGroup
  >metadata:
  >  name: external-node-group
  >  namespace: system
  >spec:
  >  ips: # list the IP addresses of the connecting servers accessible from a cluster's cloud network.
  >  - 10.130.0.4
  >  - 10.130.1.5
  >```

{% endlist %}

Afterwards, you need to [install system components on the connecting servers](#node-setup).

After the system components are installed, the servers will initiate cluster connections.

A node connection to a {{ managed-k8s-name }} cluster is complete when new nodes in a `Ready` state become available in the cluster:

{% list tabs %}

- Management console

  1. Go to the details of the relevant node group.
  1. Select the **Nodes** tab.

- CLI

  ```bash
  kubectl get node -o wide -w

  NAME       STATUS  ROLES   AGE    VERSION  INTERNAL-IP  EXTERNAL-IP  OS-IMAGE            KERNEL-VERSION    CONTAINER-RUNTIME
  ...
  ext-node2  Ready   <none>  4m03s  v1.20.6  10.130.0.4   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ext-node1  Ready   <none>  4m25s  v1.20.6  10.130.1.5   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ```

{% endlist %}

### Installing system components on connecting servers {#node-setup}

You can use one of two methods to install system components and to add nodes to a cluster:
* [Automated install](#automatic-setup).
* [Semi-automated install](#semi-automatic-setup).

#### Automated install {#automatic-setup}

For an automated installation, you need to create a secret containing a private server connection SSH key in your cluster. Create a secret:

```bash
kubectl -n system create secret generic <secret name> --from-file=ssh-privatekey=<file path> --type=kubernetes.io/ssh-auth
```

In the `NodeGroup` resource specification, include the name of the relevant secret:

{% list tabs %}

- Management console

  1. Go to the details of the relevant node group.
  1. Click **Edit**.
  1. Select the desired secret from the drop-down list.
  1. Click **Save**.

- CLI

  ```bash
  kubectl -n system edit nodegroup external-node-group
  ```

  ```yaml
  apiVersion: mks.yandex.cloud/v1alpha1
  kind: NodeGroup
  metadata:
    name: external-node-group
    namespace: system
  spec:
    ips:
    ...
    provisionBySsh:
      sshKeySecret: <secret name>
  ```

{% endlist %}

Connection as `root` and the specified SSH key must be available on all the external nodes.

#### Semi-automated install {#semi-automatic-setup}

For a semi-automated installation, you need to set all the external nodes up with the basic component and the configuration that will assure the subsequent installation of the system components.

1. Creating a NodeGroup object makes a secret available in a cluster. The secret contains `kubeconfig` to use on connecting servers. Get it using `kubectl` configured to communicate with the cluster and save it to a file:

   ```bash
   kubectl -n system get secret <NodeGroup object name>-maintainer-kube-config -o json | jq -r '.data."kube-config"' | base64 -d
   ```

1. Save the downloaded `kubeconfig` on a connecting server:

   ```bash
   sudo mkdir -p /etc/maintainer
   sudo vi /etc/maintainer/kube.config # Use this file to save the contents of `kubeconfig` retrieved in the previous step.
   ```

1. Run the commands below on a connecting server:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl -o /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## Deleting external nodes from a cluster {#remove-node}

{% list tabs %}

- Management console

  1. Go to the details of the relevant node group.
  1. Click **Edit**.
  1. Delete the IP addresses of the desired nodes.
  1. Click **Save**.

- CLI

  To disconnect nodes, delete their IP addresses from the `spec.ips` field of `NodeGroup`:

  ```bash
  kubectl -n system edit nodegroup
  ```

{% endlist %}

## Troubleshooting {#troubleshooting}

If there are issues, review the events in the `system` namespace first:

{% list tabs %}

- Management console

  1. On the cluster page, go to **Events** tab.
  1. Select the `system` namespace.

- CLI

  ```bash
  kubectl -n system get events
  ```

{% endlist %}

If there is not enough information, review the system component logs on the appropriate server:

```bash
journalctl -u maintainer
journalctl -u kubelet
```

Do not forget the external node connection [requirements](../concepts/external-nodes.md#requirements).