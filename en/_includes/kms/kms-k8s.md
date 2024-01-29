Use {{ kms-short-name }} keys to encrypt secrets, that is, confidential information such as passwords, OAuth tokens, and SSH keys, in {{ managed-k8s-full-name }}. To do this, specify a {{ kms-short-name }} key when creating a cluster. This key will be used for encryption and decryption.

Make sure you specify the encryption key when creating a {{ k8s }} cluster, as you cannot add it when updating the cluster.

{% list tabs group=instructions %}

- Management console {#console}

   Specify a key when creating a {{ k8s }} cluster:
   1. In the [management console]({{ link-console-main }}), select the folder to create your {{ k8s }} cluster in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
   1. In the **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** field, enter the required key or [create a new one](../../kms/operations/key.md#create).
   1. Enter all the other parameters to [create your cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   You can specify a key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster in two ways:

   - Using the key ID:

      ```bash
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-id <key_ID> \
         ...
      ```

   - Using the key name:

      ```bash
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-name <key_name> \
         ...
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   Specify a key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster:

   1. Add a `kms_provider` block to the cluster description:

      ```hcl
      resource "yandex_kubernetes_cluster" "<cluster_name>" {
        ...
        kms_provider {
          key_id = "<key_id>"
        }
      }
      ```

   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a cluster.

      {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

   Specify the encryption key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster. To do this, use the [create](../../managed-kubernetes/api-ref/Cluster/create.md) REST API method for the [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) resource or the [ClusterService/Create](../../managed-kubernetes/api-ref/grpc/cluster_service.md#Create) gRPC API call.
   Provide the key ID in the respective parameter of the `kmsProvider` field.

{% endlist %}

{{ managed-k8s-name }} interacts with {{ kms-short-name }} using the [provider {{ kms-short-name }} mechanism](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} supports the {{ kms-short-name }} plugin that is used to encrypt and decrypt data encryption keys (DEK) in {{ kms-short-name }}. Secrets are encrypted using standard {{ k8s }} tools.
