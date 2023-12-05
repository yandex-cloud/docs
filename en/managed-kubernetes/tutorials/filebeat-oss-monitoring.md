# Monitoring a {{ managed-k8s-name }} cluster using Filebeat OSS

[Filebeat OSS](https://www.elastic.co/beats/filebeat) is a plugin for collecting and forwarding logs to the {{ OS }} ecosystem. Installed in a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster), Filebeat collects cluster and [pod](../concepts/index.md#pod) logs, and forwards them to [{{ mos-full-name }}](../../managed-opensearch/).

To set up {{ managed-k8s-name }} cluster monitoring with Filebeat OSS:
1. [{#T}](#filebeat-oss-install).
1. [{#T}](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create a {{ managed-k8s-name }} cluster and a [node group](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs %}

   - Manually

      1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
      1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet), [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and node group will be created.
      1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.
      1. [Create a rule for connecting to the services from the internet](../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) and apply it to the {{ managed-k8s-name }} cluster's node group.

   - Using {{ TF }}

      1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. The file describes:
         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security group](../operations/connect/security-groups.md) and rules required for a {{ managed-k8s-name }} cluster and node group:
            * Rules for service traffic.
            * Rules for accessing the {{ k8s }} API and managing a {{ managed-k8s-name }} cluster with `kubectl` through ports 443 and 6443.
            * Rules for connecting to services from the internet.
            * {{ managed-k8s-name }} cluster.
            * [Service account](../../iam/concepts/users/service-accounts.md) required for a {{ managed-k8s-name }} cluster and node group.
      1. Specify the following in the configuration file:
         * [Folder ID](../../resource-manager/operations/folder/get-id.md).
         * [{{ k8s }} version](../concepts/release-channels-and-updates.md) for a {{ managed-k8s-name }} cluster and node groups.
         * {{ managed-k8s-name }} cluster CIDR.
         * Name of the service account. It must be unique within the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
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

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Create a {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md) with any suitable configuration.

## Install Filebeat OSS {#filebeat-oss-install}

Install Filebeat OSS by following [this guide](../operations/applications/filebeat-oss.md).

## Check the result {#check-result}

Make sure that the {{ mos-name }} cluster is receiving logs from the {{ managed-k8s-name }} cluster:

{% list tabs %}

- Bash

   Run this command:

   ```bash
   curl \
     --user admin:<admin_password_to_Managed_Service_for_{{ OS }}_cluster> \
     --cacert CA.pem \
     --request GET 'https://<{{ OS }}_DATA_host_name>:{{ port-mos }}/_cat/indices?v'
   ```

- {{ OS }} Dashboards

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

Delete the other resources, depending on the method used to create them:

{% list tabs %}

- Manually

   1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
   1. [Delete the created service account](../../iam/operations/sa/delete.md).

- Using {{ TF }}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

{% endlist %}