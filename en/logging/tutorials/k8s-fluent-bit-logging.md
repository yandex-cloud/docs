---
title: "Transferring {{ managed-k8s-full-name }} cluster logs to {{ cloud-logging-name }}"
description: "The Fluent Bit log processor allows you to transfer the {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}. The Fluent Bit plugin for {{ cloud-logging-full-name }} module is used to transfer logs."
---

# Transferring the {{ managed-k8s-full-name }} cluster logs to {{ cloud-logging-name }}


You can send [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) logs to {{ cloud-logging-name }}:
* Use the `master logging` setting when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a cluster to enable [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master) log sending. The setting is only available in the API, CLI, and {{ TF }}.
* To send [pod](../../managed-kubernetes/concepts/index.md#pod) and [service](../../managed-kubernetes/concepts/index.md#service) logs, use the [Fluent Bit application with the {{ cloud-logging-name }} plugin](/marketplace/products/yc/fluent-bit) in the {{ managed-k8s-name }} cluster.

## Sending master logs to {{ managed-k8s-name }} in {{ cloud-logging-name }} using master logging {#master-logging}

To set up the transfer of {{ managed-k8s-name }} master logs to {{ cloud-logging-name }}:
1. [Enable the master logging setting](#enable-master-logging).
1. [Check the result](#check-result-master-logging).

If you no longer need the resources you created, [delete them](#clear-out-master-logging).

### Getting started {#before-you-begin-master-logging}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
   1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group) will be created.
   1. [Create service accounts](../../iam/operations/sa/create.md#create-sa):
      * [Service account](../../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources with the [{{ roles-editor }}](../../iam/roles-reference.md#editor) [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is created.
      * Service account for {{ managed-k8s-name }} nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) role for the folder with the [Docker image](../../container-registry/concepts/docker-image.md) [registry](../../container-registry/concepts/registry.md). {{ managed-k8s-name }} nodes will pull the required Docker images from the registry on behalf of this account.

         {% note tip %}

         You can use the same service account for both operations.

         {% endnote %}

   1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the [{{ roles-logging-writer }}](../../logging/security/index.md#logging-writer) role to the service account for resources. This role is required by the {{ managed-k8s-name }} cluster to send logs to {{ cloud-logging-name }}.
   1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md#node-group-create). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for the resources and nodes.
   1. [Configure security groups](../../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster.
   1. [Create a log group](../operations/create-group.md).

- {{ TF }} {#tf}

   1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-cluster-with-master-logging.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cloud-logging/blob/main/k8s-cluster-with-master-logging.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory.

      This file describes:
      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../managed-kubernetes/operations/connect/security-groups.md) and rules required for a {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group):
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing a {{ managed-k8s-name }} cluster with `kubectl` through ports 443 and 6443.
         * Rules for connecting to services from the internet.
      * [Service account](../../iam/concepts/users/service-accounts.md) for resources and {{ managed-k8s-name }} nodes and sending cluster logs to {{ cloud-logging-name }}.
      * {{ managed-k8s-name }} cluster.
      * {{ managed-k8s-name }} node group.
      * {{ cloud-logging-name }} [log group](../concepts/log-group.md).
   1. Specify the following in the configuration file:
      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * Name of the service account for resources and {{ managed-k8s-name }} nodes and for sending cluster logs to {{ cloud-logging-name }}.
      * {{ cloud-logging-name }} log group name.
   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Enable the master logging setting {#enable-master-logging}

If you manually created the infrastructure, enable the `master logging` setting:
1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Run this command:

   ```bash
   {{ yc-k8s }} cluster update <cluster_name> \
     --master-logging enabled=true,`
       `log-group-id=<log_group_ID>,`
       `kube-apiserver-enabled=<sending_kube-apiserver_logs:_true_or_false>,`
       `cluster-autoscaler-enabled=<sending_cluster-autoscaler_logs:_true_or_false>,`
       `events-enabled=<sending_{{ k8s }}_events:_true_or_false>`
       `audit-enabled=<sending_audit_events:_true_or_false>
   ```

   Where:
   * `enabled`: Flag that enables log sending.
   * `log-group-id`: ID of the [previously created](#before-you-begin-master-logging) log group to send the logs to.
   * `kube-apiserver-enabled`: Flag that enables [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) log sending.
   * `cluster-autoscaler-enabled`: Flag that enables `cluster-autoscaler` log sending.
   * `events-enabled`: Flag that enables {{ k8s }} event sending.
   * `audit-enabled`: Flag for sending audit events.

### Check the result {#check-result-master-logging}

[Check the transfer](../operations/read-logs.md) of {{ managed-k8s-name }} master logs to the {{ cloud-logging-name }} log group.

### Delete the resources you created {#clear-out-master-logging}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a static [public IP address](../../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster, release and [delete it](../../vpc/operations/address-delete.md).
   1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
   1. [Delete the created service accounts](../../iam/operations/sa/delete.md).
   1. [Delete the log group](../../logging/operations/delete-group.md).

- {{ TF }} {#tf}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster-with-master-logging.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster-with-master-logging.tf` configuration file will be deleted.

{% endlist %}

## Sending pod logs and service logs via Fluent Bit {#fluent-bit}

{% include notitle [Setting up Managed K8S Fluent Bit](../../_tutorials/containers/k8s-fluent-bit-logging.md) %}