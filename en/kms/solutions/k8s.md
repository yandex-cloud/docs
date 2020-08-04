# Encrypting secrets in {{ managed-k8s-full-name }}

Use {{ kms-short-name }} keys to encrypt secrets, that is, confidential information such as passwords, OAuth tokens, and SSH keys, in {{ managed-k8s-full-name }}. To do this, specify a {{ kms-short-name }} key when creating a cluster. This key will be used for encryption and decryption.

{% list tabs %}

- Management console

    Specify a key when creating a {{ k8s }} cluster:
    1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
    1. In the list of services, select **{{ managed-k8s-name }}**.
    1. Click **Create cluster**.
    1. In the **Encryption key** field, enter the required key or [create a new one](../operations/key.md#create).
    1. Fill in other parameters for [creating your cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
    1. Click **Create cluster**.

{% endlist %}

{{ managed-k8s-name }} interacts with {{ kms-short-name }} using the [{{ kms-short-name }} provider mechanism](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} supports the {{ kms-short-name }} plugin that is used to encrypt and decrypt data encryption keys (DEK) in {{ kms-short-name }}. Secrets are encrypted using standard {{ k8s }} tools.

## See also {#see-also}

* [Getting started with {{ managed-k8s-name }}](../../managed-kubernetes/quickstart.md).
* [{#T}](../concepts/envelope.md).
* [Creating secrets in Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).

