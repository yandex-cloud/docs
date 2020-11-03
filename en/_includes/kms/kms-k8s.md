Use {{ kms-short-name }} keys to encrypt secrets, that is, confidential information such as passwords, OAuth tokens, and SSH keys, in {{ managed-k8s-full-name }}. To do this, specify a {{ kms-short-name }} key when creating a cluster. This key will be used for encryption and decryption.

Make sure you specify the encryption key when creating a {{ k8s }} cluster, as you can't add it when updating the cluster.

{% list tabs %}

- Management console

    Specify a key when creating a {{ k8s }} cluster:
    1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
    1. In the list of services, select **{{ managed-k8s-name }}**.
    1. Click **Create cluster**.
    1. In the **Encryption key** field, enter the required key or [create a new one](../../kms/operations/key.md#create).
    1. Fill in other parameters for [creating your cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
    1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can specify a key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster in two ways.

  - Using the key ID:

      ```bash
      yc k8s create --kms-key-id <encryption key ID> \
      ...
      ```

  - Using the key name:

      ```bash
      yc k8s create --kms-key-name <encryption key name> \
      ...
      ```

- API

    Specify the encryption key when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster. To do this, use the [create](../../managed-kubernetes/api-ref/Cluster/create.md) method for the [Cluster](../../managed-kubernetes/api-ref/Cluster) resource.

{% endlist %}

{{ managed-k8s-name }} interacts with {{ kms-short-name }} using the [{{ kms-short-name }} provider mechanism](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} supports the {{ kms-short-name }} plugin that is used to encrypt and decrypt data encryption keys (DEK) in {{ kms-short-name }}. Secrets are encrypted using standard {{ k8s }} tools.
