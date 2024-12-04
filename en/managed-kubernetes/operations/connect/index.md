---
title: How to connect to a {{ k8s }} cluster in {{ managed-k8s-full-name }}
description: Follow this guide to connect to a {{ k8s }} cluster in {{ managed-k8s-name }}.
---

# Connection method overview

You can connect to a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) using the following methods:
* Over the internet if you configured public access for the cluster [when creating it](../kubernetes-cluster/kubernetes-cluster-create.md).
* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md).

To connect to a cluster, you can use:
* [kubectl](#kubectl-connect)
* [Static configuration file](#static-conf-connect)

To connect to cluster nodes, follow the instructions in [{#T}](../node-connect-ssh.md).

## Configuring security groups {#configuring-security-groups}

[Security groups](security-groups.md) may block cluster connections. To manage a cluster using `kubectl`, you must have rules in security groups that allow access to the {{ k8s }} API. If you need a step-by-step guide on setting up rules, see [Rules to access the {{ k8s }} API](security-groups.md#rules-master).

## Connecting to a cluster {#kubectl-connect}

When connecting to a {{ k8s }} cluster, the user [logs in to {{ iam-full-name }}](../../../iam/concepts/authorization/index.md) and is granted access based on the [assigned role](../../security/index.md#yc-api). To log in, you must install the [{{ yandex-cloud }} command-line interface (CLI)](../../../cli/quickstart.md).

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

To connect to a cluster:

1. Install [kubectl]({{ k8s-docs }}/tasks/tools/#kubectl).

1. Add credentials to the `kubectl` configuration file depending on the type of the IP address of the cluster you are connecting to:

   {% list tabs %}

   - Public IP address

      To get credentials to connect to the cluster's public IP address via the internet, run this command:

      ```bash
      {{ yc-k8s }} cluster \
         get-credentials <cluster_name_or_ID> \
         --external
      ```
 
      {% include [note-connect-button](../../../_includes/managed-kubernetes/note-connect-button.md) %}

      If you [created your cluster](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) with no public IP address, this cluster can only be connected to using its internal IP.

   - Internal IP address

      To get credentials to connect to the cluster's internal IP address from a VM located in the same network, run this command:

      ```bash
      {{ yc-k8s }} cluster \
         get-credentials <cluster_name_or_ID> \
         --internal
      ```
      
      {% include [note-connect-button](../../../_includes/managed-kubernetes/note-connect-button.md) %}

   {% endlist %}

   {% note info %}

   {% include [note-about-conf](../../../_includes/managed-kubernetes/note-about-conf.md) %}

   {% endnote %}

1. Make sure the cluster is accessible:

   ```bash
   kubectl cluster-info
   ```

   If `kubectl` is configured correctly, the command will return cluster information.

## Connecting using a static configuration {#static-conf-connect}

If you cannot use the {{ yandex-cloud }} CLI for some reason, [connect to a cluster using static configuration files](./create-static-conf.md).