---
title: How to connect external nodes to a {{ managed-k8s-name }} cluster
description: Follow this guide to connect external nodes to a {{ managed-k8s-name }} cluster.
---

# Connecting external nodes to the cluster

{% note info %}

Connecting [external nodes](../concepts/external-nodes.md) to a [{{ managed-k8s-name }} cluster](./index.md#kubernetes-cluster) is at the [Preview](../../overview/concepts/launch-stages.md) stage. You will not be charged for using them.

{% endnote %}

You can connect external servers to a {{ managed-k8s-name }} cluster using special {{ k8s }} API resources. The definitions ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) of these resources are automatically pre-installed in a {{ managed-k8s-name }} cluster.

{% note warning %}

For external nodes to connect to a {{ managed-k8s-name }} cluster, both the cluster and the connecting servers must meet [certain requirements](../concepts/external-nodes.md#requirements).

{% endnote %}

## Getting started {#before-you-begin}

1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) with any suitable configuration.

    To create an external node group, the {{ managed-k8s-name }} cluster must operate in [tunnel mode](../concepts/network-policy#cilium). This mode can be enabled only when creating the cluster.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Creating a node group {#node-group-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** and then **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Enter a name for the {{ managed-k8s-name }} node group.
  1. Enter the [IP address](../../vpc/concepts/address.md) of the connecting server accessible from the {{ managed-k8s-name }} cluster's [cloud network](../../vpc/concepts/network.md#network).
  1. Click **{{ ui-key.yacloud.k8s.node-groups.create.button_add-ip }}** to add more IP addresses if needed.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  1. Save the specification of the `NodeGroup` type object for the {{ managed-k8s-name }} group from the `mks.yandex.cloud/v1alpha1` API in `yandex-system` [namespace](../concepts/index.md#namespace) to a YAML file named `ext-nodegroup.yaml`:

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

If required, you can modify the node group, e.g., to add additional IP addresses.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Select the required {{ managed-k8s-name }} node group.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Make your changes and tap **{{ ui-key.yacloud.common.save }}**.

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

### Automated install {#automatic-setup}

1. In your {{ managed-k8s-name }} cluster, create a secret with a private SSH key for connection to the servers:

    ```bash
    kubectl -n yandex-system create secret generic <secret_name> --from-file=ssh-privatekey=<SSH_key_file_path> --type=kubernetes.io/ssh-auth
    ```

1. Specify the name of the secret in the node group specification:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. Go to the details of the relevant {{ managed-k8s-name }} node group.
      1. Click **{{ ui-key.yacloud.common.edit }}**.
      1. Select the desired secret from the drop-down list.
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

1. All {{ managed-k8s-name }} external nodes must allow `root` login access with the specified SSH key. If you use a {{ compute-name }} virtual machine as an external node, enable SSH access from `root` for it:

    1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM.
    1. Open the SSH configuration file:

        ```bash
        sudo vi /etc/ssh/sshd_config
        ```
    
    1. Set `PermitRootLogin` to `Yes` and save the changes.
    1. Open the file with the SSH key used for connection from `root`:

        ```bash
        sudo vi /root/.ssh/authorized_keys
        ```
    
    1. Delete everything other than the key from the file and save the changes. The final file should look like this:

        ```text
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK******
        ```

    1. Restart the SSH for the changes to take effect:

        ```bash
        sudo systemctl restart sshd
        ```

### Semi-automated installation {#semi-automatic-setup}

For semi-automated installation, you need to install on all {{ managed-k8s-name }} external nodes the basic component and the configuration required for subsequent installation of the system components.

1. After you [create a node group](#node-group-create), a secret becomes available in the {{ managed-k8s-name }} cluster. The secret contains `kubeconfig` you will need on the servers you are going to connect. Get the secret using `kubectl` configured to communicate with the {{ managed-k8s-name }} cluster and save it to a file:

   ```bash
   kubectl -n yandex-system get secret <node_group_name>-maintainer-kube-config -o json | jq -r '.data."kube-config"' | base64 -d
   ```

1. Save `kubeconfig` you just got on the server you are connecting:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo vi /etc/yandex-maintainer/kube.config # Use this file to save the contents of `kubeconfig` you got in the previous step.
   ```

1. Run the commands below on a connecting server:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## External node status checks {#check-status}

Once the system components have been installed, the servers will initiate {{ managed-k8s-name }} cluster connections.

A node connection to a {{ managed-k8s-name }} cluster is complete when new nodes with `Ready` status become available in the cluster.

To check node status:

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the details of the relevant {{ managed-k8s-name }} node group.
  1. Select the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.

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

  1. Go to the details of the relevant {{ managed-k8s-name }} node group.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Delete the IP addresses of the appropriate {{ managed-k8s-name }} nodes.
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

  To get a list of events, run the following command:

  ```bash
  kubectl -n yandex-system get events
  ```

{% endlist %}

If there is not enough information, review the system component logs on the appropriate server:

```bash
journalctl -u yandex-maintainer
journalctl -u kubelet
```

Keep in mind the external {{ managed-k8s-name }} node connection [requirements](../concepts/external-nodes.md#requirements).
