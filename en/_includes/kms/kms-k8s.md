Use {{ kms-short-name }} keys to encrypt secrets, that is, confidential information such as passwords, OAuth tokens, and SSH keys, in {{ managed-k8s-full-name }}. To do this, specify a {{ kms-short-name }} key when creating a cluster. This key will be used for encryption and decryption.

Make sure you specify the encryption key when creating a {{ k8s }} cluster, as you can't add it when updating the cluster.

{% list tabs %}

- Management console

   Specify a key when creating a {{ k8s }} cluster:
   1. In the [management console]({{ link-console-main }}), select the folder to create your cluster in {{ k8s }}.
   1. In the list of services, select **{{ managed-k8s-name }}**.
   1. Click **Create cluster**.
   1. In the **Encryption key** field, enter the required key or [create a new one](../../kms/operations/key.md#create).
   1. Fill in other parameters for [creating your cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   You can specify a key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster in two ways:

   - Using the key ID:

      ```bash
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-id <encryption key ID> \
         ...
      ```

   - Using the key name:

      ```bash
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-name <encryption key name> \
         ...
      ```

- API

   Specify the encryption key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster. To do this, use the [create](../../managed-kubernetes/api-ref/Cluster/create.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) resource or the [ClusterService/Create](../../managed-kubernetes/api-ref/grpc/cluster_service.md#Create) gRPC API call.
   Provide the key ID in the respective parameter of the `kmsProvider` field.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Specify a key when [creating a cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md){{ k8s }}:

   1. Add a `kms_provider` block to the cluster description:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster name>" {
        ...
        kms_provider {
          key_id = "<encryption key ID>"
        }
      }
      ```

   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a cluster.

      {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}

Interacts {{ managed-k8s-name }} with {{ kms-short-name }} using the [provider {{ kms-short-name }} mechanism](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} supports the {{ kms-short-name }} plugin that is used to encrypt and decrypt data encryption keys (DEK) in {{ kms-short-name }}. Secrets are encrypted using standard {{ k8s }} tools.
