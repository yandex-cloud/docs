# Connection method overview

You can connect to a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) using the following methods:
* Over the internet if you configured public access for the cluster [when creating it](../kubernetes-cluster/kubernetes-cluster-create.md).
* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md).

To connect to a cluster, you can use:
* [kubectl](#kubectl-connect).
* [Static configuration file](#static-conf-connect).

To connect to cluster nodes, follow the instructions in [{#T}](../node-connect-ssh.md).

## Configuring security groups {#configuring-security-groups}

[Security groups](security-groups.md) may block cluster connections. To manage a cluster using `kubectl`, rules that allow access to the {{ k8s }} API must be set up in security groups. For step-by-step instructions about setting up the rules, see [Rules to access the {{ k8s }} API](security-groups.md#rules-master).

## Connecting to a cluster {#kubectl-connect}

When connecting to a {{ k8s }} cluster, the user [logs in to {{ iam-full-name }}](../../../iam/concepts/authorization/index.md) and gets access according to the [assigned role](../../security/index.md#yc-api). To log in, you must install the [{{ yandex-cloud }} command line interface (CLI)](../../../cli/quickstart.md).
1. [Install `kubectl`](https://kubernetes.io/docs/tasks/tools/#kubectl).

1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Add credentials to the `kubectl` configuration file:
   * To connect to the cluster's internal IP address from the VM located in the same network:

     ```bash
     {{ yc-k8s }} cluster \
       get-credentials <cluster name or ID> \
       --internal
     ```

   * To connect to the cluster's external IP address on the internet:

     ```bash
     {{ yc-k8s }} cluster \
       get-credentials <cluster name or ID> \
       --external
     ```

   {% note info %}

   {% include [note-about-conf](../../../_includes/managed-kubernetes/note-about-conf.md) %}

   {% endnote %}

1. Make sure the cluster is accessible:

   ```bash
   kubectl cluster-info
   ```

   If `kubectl` is configured correctly, the command returns information about the cluster.

## Connecting using a static configuration {#static-conf-connect}

If for some reason you can't use the {{ yandex-cloud }} CLI, [connect to a cluster using static configuration files](create-static-conf.md).