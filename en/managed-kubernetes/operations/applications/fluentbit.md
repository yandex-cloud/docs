# Installing Fluent Bit with a plugin for {{ cloud-logging-name }}

[Fluent Bit](https://www.fluentbit.io/) is an open-source multi-platform tool for collecting and processing logs. Fluent Bit collects, parses, and filters messages from a variety of inputs and saves them to storage. Messages then go to the router, which defines the output to send them to. Plugins are used to work with various inputs and outputs.

[The plugin for {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) enables you to export logs generated in a {{ managed-k8s-name }} cluster, including at the pod level, to {{ cloud-logging-full-name }}.

## Creating a service account {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md), which is required for Fluent Bit.
1. [Assign it the](../../../iam/operations/sa/assign-role-for-sa.md) `logging.writer` and `monitoring.editor` roles.
1. Create an [authorized key](../../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

## Installing Fluent Bit using {{ marketplace-full-name }} {#install-fb-marketplace}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Fluent Bit with a plugin for {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Target log group ID**: Specify an [ID of the log group](../../../logging/operations/list.md) to which Fluent Bit logs will be saved.
   * **Cluster ID**: Specify a [cluster ID](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Service account key for {{ cloud-logging-name }}**: Paste the contents of the `sa-key.json` file.
1. Click **Install**.

## Installation using a Helm chart {#install-fb-helm}

1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Fluent Bit, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/fluent-bit/fluent-bit-cloud-logging \
     --version 1.0-3 \
     --untar && \
   helm install \
     --namespace fluentbit \
     --create-namespace \
     --set loggingGroupId=<log group ID> \
     --set loggingFilter=<cluster ID> \
     --set-file auth.json=sa-key.json \
     fluentbit ./fluent-bit-cloud-logging/
   ```

   This command also creates a new `fluentbit` namespace required for Fluent Bit.

## See also {#see-also}

* [Fluent Bit documentation](https://docs.fluentbit.io/manual).
* [{{ cloud-logging-name }} documentation](../../../logging/).