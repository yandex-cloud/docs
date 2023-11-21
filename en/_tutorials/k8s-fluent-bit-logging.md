{% note info %}

You can enable sending [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) logs to [{{ cloud-logging-full-name }}](../logging/) by specifying the `master logging` setting when [creating](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a cluster. The setting is only available in the CLI, {{ TF }}, and API.

{% endnote %}

The [Fluent Bit](https://fluentbit.io/) log processor allows you to transfer the {{ managed-k8s-name }} cluster logs to {{ cloud-logging-name }}. The [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module is used to transfer logs.

To set up log transfer:
1. [Prepare the {{ managed-k8s-name }} cluster](#configure-cluster).
1. [Install and configure Fluent Bit](#fluent-bit-install).

## Getting started {#before-you-begin}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. [Create a service account](../iam/operations/sa/create.md), which is required for Fluent Bit.
   1. [Assign it the role](../iam/operations/sa/assign-role-for-sa.md) `logging.writer`.
   1. Create an [authorized key](../iam/operations/authorized-key/create.md) and save it to a file named `key.json`:

      ```bash
      yc iam key create \
        --service-account-name <name_of_service_account_for_Fluent_Bit> \
        --output key.json
      ```

1. [Create a log group](../logging/operations/create-group.md).
1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with [{{ k8s }} version](../managed-kubernetes/concepts/release-channels-and-updates.md) 1.21 or higher.

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Install and configure Fluent Bit {#fluent-bit-install}

{% list tabs %}

- Using {{ yandex-cloud }}

   1. Install Fluent Bit by following the [instructions](../managed-kubernetes/operations/applications/fluentbit.md).
   1. [Check transmission of {{ managed-k8s-name }} cluster logs](../logging/operations/read-logs.md) to {{ cloud-logging-name }}.

- Manually

   1. Create the objects required for Fluent Bit to run:

      {% list tabs %}

      - For clusters with {{ k8s }} versions 1.21 and lower:

         ```bash
         kubectl create namespace logging && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role.yaml && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding.yaml
         ```

      - For clusters with {{ k8s }} versions 1.22 and higher:

         ```bash
         kubectl create namespace logging && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml && \
         kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml
         ```

      {% endlist %}

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

   1. [Check transmission of {{ managed-k8s-name }} cluster logs](../logging/operations/read-logs.md) to {{ cloud-logging-name }}.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a [public static IP address](../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster, [delete it](../vpc/operations/address-delete.md).
1. [Delete the log group](../logging/operations/delete-group.md).