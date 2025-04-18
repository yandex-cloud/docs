# Transferring {{ managed-k8s-full-name }} cluster logs to {{ cloud-logging-full-name }}


You can send [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) cluster logs to {{ cloud-logging-name }}:
* To enable sending [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) master logs, use the `master logging` setting when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a cluster. The setting is only available in the API, CLI, and {{ TF }}.
* To send [pod](../../managed-kubernetes/concepts/index.md#pod) and [service](../../managed-kubernetes/concepts/index.md#service) logs, use the [Fluent Bit application with the {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) plugin in the {{ managed-k8s-name }} cluster.


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for {{ cloud-logging-name }}: Writing and storing data (see [{{ cloud-logging-name }} pricing](../../logging/pricing.md)).


## Sending master logs to {{ managed-k8s-name }} in {{ cloud-logging-name }} using master logging {#master-logging}

To set up the transfer of {{ managed-k8s-name }} master logs to {{ cloud-logging-name }}:
1. [Enable the master logging setting](#enable-master-logging).
1. [Check the result](#check-result-master-logging).

If you no longer need the resources you created, [delete them](#clear-out-master-logging).

### Getting started {#before-you-begin-master-logging}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

  1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
  1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group) will be created.
  1. [Create service accounts](../../iam/operations/sa/create.md#create-sa):
     * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is created.
     * Service account for {{ managed-k8s-name }} nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) role for the folder containing the [Docker image](../../container-registry/concepts/docker-image.md) [registry](../../container-registry/concepts/registry.md). {{ managed-k8s-name }} nodes will pull the required Docker images from the registry on behalf of this account.

       {% note tip %}

       You can use the same service account for both operations.

       {% endnote %}

  1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the [{{ roles-logging-writer }}](../../logging/security/index.md#logging-writer) role to the service account for resources. This role is required by the {{ managed-k8s-name }} cluster to send logs to {{ cloud-logging-name }}.
  1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for the resources and nodes.
  1. [Configure security groups](../../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster.
  1. [Create a log group](../../logging/operations/create-group.md).

- {{ TF }} {#tf}

  1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Download the [file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Download the [k8s-cluster-with-master-logging.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cloud-logging/blob/main/k8s-cluster-with-master-logging.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory.

     This file describes:
     * [Network](../../vpc/concepts/network.md#network).
     * [Subnet](../../vpc/concepts/network.md#subnet).
     * [Security groups](../../managed-kubernetes/operations/connect/security-groups.md) and rules required for a {{ managed-k8s-name }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group):
       * Rules for service traffic.
       * Rules for accessing the {{ k8s }} API and managing a {{ managed-k8s-name }} cluster using `kubectl` through ports 443 and 6443.
       * Rules for accessing services from the internet.
     * [Service account](../../iam/concepts/users/service-accounts.md) for resources and {{ managed-k8s-name }} nodes and sending cluster logs to {{ cloud-logging-name }}.
     * {{ managed-k8s-name }} cluster.
     * {{ managed-k8s-name }} node group.
     * {{ cloud-logging-name }} [log group](../../logging/concepts/log-group.md).
  1. Specify the following in the configuration file:
     * [Folder ID](../../resource-manager/operations/folder/get-id.md).
     * [{{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) version for the {{ managed-k8s-name }} cluster and node groups.
     * Name of the service account for resources and {{ managed-k8s-name }} nodes and for sending cluster logs to {{ cloud-logging-name }}.
     * {{ cloud-logging-name }} log group name.
  1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
  1. Check that the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  1. Create the required infrastructure:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Enable the master logging setting {#enable-master-logging}

If you created the infrastructure manually, enable the `master logging` setting:
1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Run this command:

   ```bash
   {{ yc-k8s }} cluster update <cluster_name> \
     --master-logging enabled=true,`
       `log-group-id=<log_group_ID>,`
       `kube-apiserver-enabled=<send_kube-apiserver_logs:_true_or_false>,`
       `cluster-autoscaler-enabled=<send_cluster-autoscaler_logs:_true_or_false>,`
       `events-enabled=<send_{{ k8s }}_events:_true_or_false>`
       `audit-enabled=<send_audit_events:_true_or_false>
   ```

   Where:
   * `enabled`: Flag that enables sending logs.
   * `log-group-id`: ID of the [previously created](#before-you-begin-master-logging) log group to send the logs to.
   * `kube-apiserver-enabled`: Flag that enables sending [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) logs.
   * `cluster-autoscaler-enabled`: Flag that enables sending `cluster-autoscaler` logs.
   * `events-enabled`: Flag that enables sending {{ k8s }} events.
   * `audit-enabled`: Flag that enables sending audit events.

### Check the result {#check-result-master-logging}

[Check the transfer](../../logging/operations/read-logs.md) of {{ managed-k8s-name }} master logs to the {{ cloud-logging-name }} log group.

### Delete the resources you created {#clear-out-master-logging}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. If you reserved a static [public IP address](../../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster, release and [delete it](../../vpc/operations/address-delete.md).
  1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
  1. [Delete service accounts you created](../../iam/operations/sa/delete.md).
  1. [Delete the log group](../../logging/operations/delete-group.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

## Sending pod logs and service logs via Fluent Bit {#fluent-bit}

{% include notitle [config-k8s-fluent-bit-loggingt](../../_tutorials/containers/config-k8s-fluent-bit-logging.md) %}
