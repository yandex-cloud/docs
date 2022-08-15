The [Fluent Bit](https://fluentbit.io/) log processor lets you transfer the {{ managed-k8s-name }} cluster logs to [{{ cloud-logging-full-name }}](../logging/). The [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module is used to transfer logs.

To set up transfer of logs:
1. [Prepare the {{ k8s}}](#configure-cluster) cluster.
1. [Install and configure Fluent Bit](#fluent-bit-install).

## Before you start {#before-you-begin}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. [Create a service account](../iam/operations/sa/create.md) needed for Fluent Bit to run.
   1. [Assign it the role](../iam/operations/sa/assign-role-for-sa.md) `logging.writer`.
   1. Create an [authorized key](../iam/operations/sa/create-access-key.md) and save it to `key.json`:

      ```bash
      yc iam key create \
        --service-account-name <name of service account for Fluent Bit> \
        --output key.json
      ```

1. [Create a log group](../logging/operations/create-group.md).
1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with the {{ k8s }} version 1.21 or higher.

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Prepare the {{ k8s}} cluster {#configure-cluster}

1. Create the objects necessary for Fluent Bit to run:

   ```bash
   kubectl create namespace logging && \
   kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
   kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml && \
   kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
   ```

1. Create a secret including the key of the service account:

   ```bash
   kubectl create secret generic secret-key-json \
     --from-file=key.json \
     --namespace logging
   ```

## Install and configure Fluent Bit {#fluent-bit-install}

1. Create a folder for the service account key and copy the key there:

   ```bash
   sudo mkdir -p /etc/secret && \
   sudo cp key.json /etc/secret
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
         group_id        <log group ID>
         resource_id     <optional: {{ k8s }} cluster ID>
         message_key     log
         authorization   iam-key-file:/etc/secret/key.json
   ...
   ```

   You can request the log group ID with a [list of log groups in the folder](../logging/operations/list.md).

   If needed, enter [additional settings](https://github.com/yandex-cloud/fluent-bit-plugin-yandex#configuration-parameters) for Fluent Bit.

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

1. [Check the log transmission](../logging/operations/read-logs.md) of the {{ k8s}} cluster to {{ cloud-logging-name }}.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete the cluster {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a public static IP address for the cluster, [delete it](../vpc/operations/address-delete.md).
1. [Delete the log group](../logging/operations/delete-group.md).