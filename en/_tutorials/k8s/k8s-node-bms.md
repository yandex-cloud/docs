# Connecting a {{ baremetal-full-name }} server as an external node to a {{ managed-k8s-full-name }} cluster


{% note info %}

Connecting [external nodes](../../managed-kubernetes/concepts/external-nodes.md) to a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) is currently at the [Preview stage](../../overview/concepts/launch-stages.md) and free of charge.

{% endnote %}

You can connect {{ baremetal-name }} [servers](../../baremetal/concepts/servers.md) to a {{ managed-k8s-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [as external nodes](../../managed-kubernetes/operations/external-nodes-connect.md) using special {{ k8s }} API resources. The definitions of these resources ([CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)) are automatically pre-installed to the {{ managed-k8s-name }} cluster. These resources allow the cluster to manage connections of nodes located in other {{ yandex-cloud }} network segments, e.g., the {{ baremetal-name }} [VRF network](../../baremetal/concepts/network.md#vrf-segment). Network connectivity between the VRF network of the {{ baremetal-name }} server and the {{ managed-k8s-name }} cluster's virtual network is ensured via [{{ interconnect-full-name }}](../../interconnect/).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for the {{ managed-k8s-name }} master (see [{{ managed-k8s-full-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for {{ managed-k8s-name }} standard cluster nodes (if any): use of computing resources and storage (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* VM fee: use of computing resources and storage (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

  {% note info %}

  Your operating system fee depends on its type (see [{{ compute-name }} pricing](../../compute/pricing.md#instance-os)).

  {% endnote %}

* Fee for using a [public IP address](../../vpc/concepts/address.md#public-addresses) for a VM (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* {{ baremetal-name }} server lease fee (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).


To connect a {{ baremetal-name }} server as an external node to a {{ managed-k8s-name }} cluster:
1. [Get ready for work](#before-you-begin).
1. [Create an external node group](#node-group-create).
1. [Install system components on your {{ baremetal-name }} server](#node-setup).
1. [Check the external node status](#check-status).

See also [How to cancel a lease and delete resources](#clear-out).

## Getting started {#before-you-begin}

1. [Create](../../iam/operations/sa/create.md) a service account with the [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent), [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin), and [k8s.tunnelClusters.agent](../../managed-kubernetes/security/index.md#k8s-tunnelclusters-agent) roles for the folder you are creating the {{ managed-k8s-name }} cluster in.

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) of any suitable configuration, operating in [tunnel mode](../../managed-kubernetes/concepts/network-policy.md#cilium). When doing so, specify the service account you created earlier.

   {% note warning %}

   Tunnel mode can only be activated at the step of creating a cluster.

   {% endnote %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create a VRF segment and a private {{ baremetal-name }} subnet](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#setup-vrf).

1. [Lease a {{ baremetal-name }} server](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#rent-bms) with an `Ubuntu 24.04` OS image and internet access.

   You can also use {{ baremetal-name }} servers with other operating systems.

1. [Create a VM](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-vm).

1. [Create a routing instance](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#request-routing-instance).

1. [Create a private connection](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#create-private-connection).

## Creating an external node group {#node-group-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** and then **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-custom }}**.
  1. Enter a name for the {{ managed-k8s-name }} node group.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_ips }}** field, specify the private IP address of the {{ baremetal-name }} server you are connecting.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Installing system components on a {{ baremetal-name }} server {#node-setup}

To connect servers to a {{ managed-k8s-name }} cluster, you need to install their system components.

You can install system components in any of the following ways:

* [Automated installation](#automatic-setup)
* [Semi-automated installation](#semi-automatic-setup)

### Automated installation {#automatic-setup}

With automated installation, the {{ managed-k8s-name }} cluster connects to the {{ baremetal-name }} server over SSH and installs all required system components all by itself.

To run an automated installation:

1. In your {{ managed-k8s-name }} cluster, create a secret with a private SSH key for connection to the {{ baremetal-name }} server:

    ```bash
    kubectl -n yandex-system create secret generic <secret_name> \
      --from-file=ssh-privatekey=<SSH_key_file_path> \
      --type=kubernetes.io/ssh-auth
    ```

    {% note warning %}

    If you have lost the private SSH key specified when leasing the server, you can [add](../../baremetal/operations/servers/add-new-ssh-key.md) a new public SSH key to the server's root user account.

    {% endnote %}

1. Specify the name of the secret in the node group specification:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
      1. Select the new {{ managed-k8s-name }} node group from the list.
      1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
      1. In the **{{ ui-key.yacloud.k8s.node-group.overview.label_secret }}** field, select the new secret from the drop-down list.
      1. Click **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

### Semi-automated installation {#semi-automatic-setup}

With semi-automated installation, you prepare the {{ baremetal-name }} server manually by installing the `maintainer` component and setting up access for the {{ managed-k8s-name }} cluster. With that done, the `maintainer` component will automatically download and install the remaining system components.

To run a semi-automated installation:

1. Use `kubectl` to get a secret containing `kubeconfig` for the {{ baremetal-name }} server you are connecting and save it to a file:

   ```bash
   kubectl -n yandex-system get secret <node_group_name>-maintainer-kube-config \
     -o json | jq -r '.data."kube-config"' | base64 -d > kube.config
   ```

   This secret becomes available after the [node group is created](#node-group-create) in the {{ managed-k8s-name }} cluster.

1. Move the `kube.config` file to the {{ baremetal-name }} server:

   ```bash
   scp kube.config root@<baremetal_server_public_IP>:/
   ```

1. Connect to the {{ baremetal-name }} server:

   ```bash
   ssh root@<server_public_IP_address>
   ```

1. Create a folder named `/etc/yandex-maintainer` and move the `kube.config` file into it:

   ```bash
   sudo mkdir -p /etc/yandex-maintainer
   sudo mv /kube.config /etc/yandex-maintainer/
   ```

1. Run the following commands on the {{ baremetal-name }} server:

   ```bash
   sudo mkdir -p /home/kubernetes/bin
   sudo curl --output /home/kubernetes/bin/maintainer https://{{ s3-storage-host }}/mk8s-maintainer/v1/maintainer
   sudo chmod +x /home/kubernetes/bin/maintainer
   sudo /home/kubernetes/bin/maintainer install
   ```

## External node status check {#check-status}

Once the system components are installed, the {{ baremetal-name }} server will initiate the {{ managed-k8s-name }} cluster connection.

To make sure the {{ baremetal-name }} server is successfully connected:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the {{ managed-k8s-name }} cluster page, go to the **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click the name of the new {{ managed-k8s-name }} node group.
  1. Navigate to the **{{ ui-key.yacloud.k8s.node-group.overview.label_tab-nodes }}** tab.
  1. Check that the new {{ managed-k8s-name }} node is now `Ready`.
  1. Open the new node and go to the **{{ ui-key.yacloud.k8s.node.overview.label_events }}** tab.
  1. Check that all server connection steps have been successful.

{% endlist %}

## How to cancel a lease and delete resources {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.
* [Delete](../../iam/operations/sa/delete.md) the service accounts you created.
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Cancel](../../baremetal/operations/servers/server-lease-cancel.md) your {{ baremetal-name }} server lease renewal. After canceling the lease, the server will remain active until the paid period ends, after which it will be automatically deleted.
* [Delete](../../baremetal/tutorials/bm-vrf-and-vpc-interconnect.md#clear-out) the private connection.

## See also {#see-also}

* [Connecting external nodes to a cluster](../../managed-kubernetes/operations/external-nodes-connect.md)
* [Configuring WireGuard gateways to connect external nodes](../../managed-kubernetes/operations/external-nodes-connect-wireguard.md)
* [Configuring IPSec gateways to connect external nodes](../../managed-kubernetes/operations/external-nodes-connect-ipsec.md)
