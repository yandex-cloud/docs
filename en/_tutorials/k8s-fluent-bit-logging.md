# Configuring Fluent Bit for {{ cloud-logging-full-name }}

To set up the transfer of {{ managed-k8s-name }} pod and service logs to {{ cloud-logging-name }}:

1. [Install and configure Fluent Bit](#fluent-bit-install).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

- Manually

   1. If you do not have a network yet, [create one](../vpc/operations/network-create.md).
   1. If you do not have any subnets yet, [create them](../vpc/operations/subnet-create.md) in the availability zones where your {{ k8s }} cluster and node group will be created.
   1. [Create service accounts](../iam/operations/sa/create.md):
      * Service account for {{ k8s }} resources with the [{{ roles-editor }}](../iam/concepts/access-control/roles.md#editor) role for the folder where the {{ managed-k8s-name }} cluster is created.
      * Service account for {{ k8s }} nodes with the [{{ roles-cr-puller }}](../iam/concepts/access-control/roles.md#cr-images-puller) role for the folder with the Docker image [registry](../container-registry/concepts/registry.md). {{ managed-k8s-name }} nodes will pull the required Docker images from the registry on behalf of this account.

      {% note tip %}

      You can use the same service account for both operations.

      {% endnote %}

   1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md#node-group-create). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for the resources and nodes.
   1. [Configure security groups](../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster to run.
   1. [Create a log group](../logging/operations/create-group.md).

- Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-cluster-with-log-group.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster-with-log-group.tf) cluster configuration file to the same working directory.

      This file describes:

      * [Network](../vpc/concepts/network.md#network).
      * [Subnet](../vpc/concepts/network.md#subnet).
      * [Security groups](../managed-kubernetes/operations/connect/security-groups.md) and rules required for the cluster, node group, and {{ managed-k8s-name }} instance to run:
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
         * Rules for connecting to services from the internet.
      * [Service account](../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
      * [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster).
      * [{{ managed-k8s-name }} node group](../managed-kubernetes/concepts/index.md#node-group).
      * {{ cloud-logging-name }} [log group](../logging/concepts/log-group.md).
   1. Specify the following in the configuration file:
      * [Folder ID](../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * Name of the service account for {{ managed-k8s-name }} resources and nodes.
      * {{ cloud-logging-name }} log group name.
   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Install and configure Fluent Bit {#fluent-bit-install}

{% list tabs %}

- Using {{ yandex-cloud }}

   Install Fluent Bit by following [this guide](../managed-kubernetes/operations/applications/fluentbit.md). In the application settings, specify the ID of the log group you [created earlier](#before-you-begin). You can request the log group ID with a [list of log groups in the folder](../logging/operations/list.md).

- Manually

   1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}
   1. Create the objects required for Fluent Bit to run:

      ```bash
      kubectl create namespace logging && \
      kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
      kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml && \
      kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml
      ```

   1. Create a secret including the key of the [service account](../iam/concepts/users/service-accounts.md):

      ```bash
      kubectl create secret generic secret-key-json \
        --from-file=key.json \
        --namespace logging
      ```

   1. Download the `config.yaml` configuration file:

      ```bash
      wget https://raw.githubusercontent.com/knpsh/yc-logging-fluent-bit-example/main/config.yaml
      ```

   1. Enter the log output parameters in the `data.output-elasticsearch.conf` section in `config.yaml`:

      ```yaml
      ...
        output-elasticsearch.conf: |
          [OUTPUT]
            Name            yc-logging
            Match           *
            group_id        <log_group_ID>
            resource_id     <optional:_{{ k8s }}_cluster_ID>
            message_key     log
            authorization   iam-key-file:/etc/secret/key.json
      ...
      ```

      You can request the [log group](../logging/concepts/log-group.md) ID with a [list of log groups in the folder](../logging/operations/list.md).

      Specify [additional settings](https://github.com/yandex-cloud/fluent-bit-plugin-yandex#configuration-parameters) for Fluent Bit, if required.
   1. Create Fluent Bit objects:

      ```bash
      kubectl apply -f config.yaml
      ```

      Result:

      ```text
      configmap/fluent-bit-config created
      daemonset.apps/fluent-bit created
      ```

   1. Make sure the Fluent Bit status changed to `Running`:

      ```bash
      kubectl get pods -n logging
      ```

{% endlist %}

## Check the result {#check-result}

[Test the transfer of logs](../logging/operations/read-logs.md) of {{ managed-k8s-name }} pods and services to your {{ cloud-logging-name }} log group.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

   1. [Delete the {{ k8s }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a static [public IP address](../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster, release and [delete it](../vpc/operations/address-delete.md).
   1. [Delete the created subnets](../vpc/operations/subnet-delete.md) and [networks](../vpc/operations/network-delete.md).
   1. [Delete the created service accounts](../iam/operations/sa/delete.md).
   1. [Delete the log group](../logging/operations/delete-group.md).

- Using {{ TF }}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster-with-log-group.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster-with-log-group.tf` configuration file will be deleted.

{% endlist %}
