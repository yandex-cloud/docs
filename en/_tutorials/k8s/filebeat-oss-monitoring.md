# Cluster monitoring with Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) is a plugin for collecting and forwarding logs to the {{ OS }} ecosystem. Installed in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), Filebeat collects cluster and [pod](../../managed-kubernetes/concepts/index.md#pod) logs, and forwards them to [{{ mos-full-name }}](../../managed-opensearch/).

To set up {{ managed-k8s-name }} cluster monitoring with Filebeat OSS:

1. [Install Filebeat OSS](#filebeat-oss-install).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* {{ mos-name }} cluster fee: using computing resources allocated to hosts (including hosts with the `MANAGER` role) and disk space (see [{{ mos-name }} pricing](../../managed-opensearch/pricing.md)).
* Fee for public IP addresses for {{ mos-name }} cluster hosts and {{ managed-k8s-name }} cluster nodes if public access is enabled for them (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. Create a {{ managed-k8s-name }} cluster and a [node group](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
     1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and node group will be created.

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) cluster and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

   - {{ TF }} {#tf}

     1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Download the [file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. This file describes:
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * {{ managed-k8s-name }} cluster.
        * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the following in the configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * [{{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) version for the {{ managed-k8s-name }} cluster and node groups.
        * {{ managed-k8s-name }} cluster CIDR.
        * Service account name. The name must be unique within the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
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

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Create a {{ mos-name }} cluster with any suitable configuration](../../managed-opensearch/operations/cluster-create.md).

## Install Filebeat OSS {#filebeat-oss-install}

Install Filebeat OSS by following [this guide](../../managed-kubernetes/operations/applications/filebeat-oss.md).

## Check the result {#check-result}

Make sure that the {{ mos-name }} cluster is receiving logs from the {{ managed-k8s-name }} cluster:

{% list tabs group=programming_language %}

- Bash {#bash}

  Run this command:

  ```bash
  curl \
    --user admin:<Managed_Service_for_{{ OS }}_cluster_admin_user_password> \
    --cacert CA.pem \
    --request GET 'https://<name_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/_cat/indices?v'
  ```

- {{ OS }} Dashboards {#opensearch}

  1. Connect to the {{ mos-name }} cluster using [{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards).
  1. Select the `Global` tenant.
  1. Open the control panel by clicking ![os-dashboards-sandwich](../../_assets/os-dashboards-sandwich.svg).
  1. Under **{{ OS }} Plugins**, select **Index Management**.
  1. Go to **Indexes**.

{% endlist %}

The list should contain `filebeat-7.12.1-<log_date>` indexes with the {{ managed-k8s-name }} cluster logs.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them.

[Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
  1. [Delete the created service account](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
