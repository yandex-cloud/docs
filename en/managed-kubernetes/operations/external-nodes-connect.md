---
title: How to connect external nodes to a {{ managed-k8s-name }} cluster
description: Follow this guide to connect external nodes to a {{ managed-k8s-name }} cluster.
---

# Connecting external nodes to a cluster

{% note info %}

Connecting [external nodes](../concepts/external-nodes.md) to a [{{ managed-k8s-name }} cluster](./index.md#kubernetes-cluster) is at the [Preview](../../overview/concepts/launch-stages.md) stage. You will not be charged for using them.

{% endnote %}

You can connect external servers as nodes to a {{ managed-k8s-name }} cluster using special {{ k8s }} API resources. The definitions ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) of these resources are automatically pre-installed in a {{ managed-k8s-name }} cluster.

{% note warning %}

For external nodes to connect to a {{ managed-k8s-name }} cluster, both the cluster and the connecting servers must meet [certain requirements](../concepts/external-nodes.md#requirements).

{% endnote %}

## Getting started {#before-you-begin}

1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

    To create an external node group, the {{ managed-k8s-name }} cluster must operate in [tunnel mode](../concepts/network-policy.md#cilium). You can only enable this mode when creating the cluster.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Creating a node group {#node-group-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** and then **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Enter a name for the {{ managed-k8s-name }} node group.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_ips }}** field, specify the [IP address](../../vpc/concepts/address.md) of the server you are connecting, available from the {{ managed-k8s-name }} cluster's [cloud network](../../vpc/concepts/network.md#network).
  1. Click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-ip }}** to add more IP addresses if needed.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  1. Save the specification of the `NodeGroup` type object for the {{ managed-k8s-name }} group from the `mks.yandex.cloud/v1alpha1` API in the `yandex-system` [namespace](../concepts/index.md#namespace) to a YAML file named `ext-nodegroup.yaml`:

     ```yaml
     apiVersion: mks.yandex.cloud/v1alpha1
     kind: NodeGroup
     metadata:
       name: external-node-group
       namespace: yandex-system
     spec:
       ips: # List the IP addresses of the connecting servers accessible from the {{ managed-k8s-name }} cluster's cloud network.
       - 10.130.0.4
       - 10.130.1.5  
     ```

  1. Create a {{ managed-k8s-name }} node group:

     ```bash
     kubectl apply -f ext-nodegroup.yaml
     ```

{% endlist %}

### Updating a node group {#edit-node-group}

If required, you can edit the node group, e.g., add more IP addresses.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the {{ managed-k8s-name }} node group.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the group as needed and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  To edit a {{ managed-k8s-name }} node group specification, run this command:

  ```bash
  kubectl -n yandex-system edit nodegroup external-node-group
  ```

{% endlist %}

## Installing system components {#node-setup}

To connect servers to a {{ managed-k8s-name }} cluster, you need to install their system components.

You can install system components using one of the following methods:

* [Automated installation](#automatic-setup)
* [Semi-automated installation](#semi-automatic-setup)

### Automated installation {#automatic-setup}

With automated installation, the {{ managed-k8s-name }} cluster connects to the server over SSH and installs all required system components all by itself.

To run an automated installation:

1. In your {{ managed-k8s-name }} cluster, create a secret with a private SSH key for connection to the servers:

    ```bash
    kubectl -n yandex-system create secret generic <secret_name> \
      --from-file=ssh-privatekey=<SSH_key_file_path> \
      --type=kubernetes.io/ssh-auth
    ```

1. Specify the name of the secret in the node group specification:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
      1. Select the new {{ managed-k8s-name }} node group from the list.
      1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
      1. In the **{{ ui-key.yacloud.k8s.node-group.overview.label_secret }}** field, select the new secret from the drop-down list.
      1. Click **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      1. Run this command:

          ```bash
          kubectl -n yandex-system edit nodegroup external-node-group
          ```
      
      1. Edit the specification:

          ```yaml
          apiVersion: mks.yandex.cloud/v1alpha1
          kind: NodeGroup
          metadata:
            name: external-node-group
            namespace: yandex-system
          spec:
            ips:
            ...
            provisionBySsh:
              sshKeySecret:
                name: <secret_name>
                namespace: yandex-system
          ```

    {% endlist %}

### Semi-automated installation {#semi-automatic-setup}

With semi-automated installation, you prepare the server manually by installing the `maintainer` component and setting up access for the {{ managed-k8s-name }} cluster. With that done, the `maintainer` component will automatically download and install the remaining system components.

To run a semi-automated installation:

1. Use `kubectl` to get a secret containing `kubeconfig` for the server you are connecting and save it to a file:

   ```bash
   kubectl -n yandex-system get secret <node_group_name>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   This secret becomes available after the [node group is created](#node-group-create) in the {{ managed-k8s-name }} cluster.

1. Move the `kube.config` file to the server:

   ```bash
   scp kube.config root@<server_public_IP_address>:/
   ```

1. Connect to the server:

   ```bash
   ssh root@<server_public_IP_address>
   ```

1. Create a folder named `/etc/yandex-maintainer` and move the `kube.config` file into it:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo mv /kube.config /etc/yandex-maintainer/
   ```

1. Run the commands below on a connecting server:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## External node status checks {#check-status}

Once the system components have been installed, the servers will initiate {{ managed-k8s-name }} cluster connections. Once the connection is complete, the new cluster nodes will get the `Ready` status.

To check the node status:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click the name of the new {{ managed-k8s-name }} node group.
  1. Navigate to the **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}** tab.
  1. Check that the new {{ managed-k8s-name }} node is now `Ready`.
  1. Open the new node and go to the **{{ ui-key.yacloud.k8s.node.overview.label_events }}** tab.
  1. Check that all server connection steps have been successful.

- CLI {#cli}

  Run this command:

  ```bash
  kubectl get node -o wide -w
  ```

  Result:

  ```text
  NAME       STATUS  ROLES   AGE    VERSION  INTERNAL-IP  EXTERNAL-IP  OS-IMAGE            KERNEL-VERSION    CONTAINER-RUNTIME
  ...
  ext-node2  Ready   <none>  4m03s  v1.20.6  10.130.0.4   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ext-node1  Ready   <none>  4m25s  v1.20.6  10.130.1.5   <none>       Ubuntu 20.04.3 LTS  5.4.0-42-generic  docker://20.10.8
  ```

{% endlist %}

## Disabling external nodes {#remove-node}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the new {{ managed-k8s-name }} node group from the list.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Delete the IP addresses of the {{ managed-k8s-name }} nodes you created.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Run this command:

      ```bash
      kubectl -n yandex-system edit nodegroup
      ```

  1. Delete the IP addresses of the nodes from the `spec.ips` field.

{% endlist %}

## Troubleshooting {#troubleshooting}

If there are any issues, review the events in the `yandex-system` namespace first:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_events }}** tab.
  1. Select the `yandex-system` namespace.

- CLI {#cli}

  To get a list of events, run this command:

  ```bash
  kubectl -n yandex-system get events
  ```

{% endlist %}

If there is not enough information, review the system component logs on the relevant server:

```bash
journalctl -u yandex-maintainer
journalctl -u kubelet
```

Consider the external {{ managed-k8s-name }} node connection [requirements](../concepts/external-nodes.md#requirements).


## See also {#see-also}

* [Configuring WireGuard gateways to connect external nodes](external-nodes-connect-wireguard.md)
* [Configuring IPSec gateways to connect external nodes](external-nodes-connect-ipsec.md)
