---
title: How to work with private Docker image registries in {{ managed-k8s-full-name }}
description: Follow this guide to set up access to private Docker image registries in {{ managed-k8s-name }}.
---

# Working with private Docker image registries

{{ managed-k8s-name }} supports integration with private Docker image registries [{{ container-registry-full-name }}](../tutorials/container-registry.md) and [{{ cloud-registry-full-name }}](../../cloud-registry/concepts/index.md). {{ managed-k8s-name }} authenticates with these registries using the [cloud service account](../concepts/index.md#service-accounts) assigned to the node group. This is the preferred and most secure method because authentication takes place automatically via short-lived [IAM tokens](../../iam/concepts/authorization/iam-token.md).

You can assign a service account to a node group when [creating](./kubernetes-cluster/kubernetes-cluster-create.md) or [updating](./kubernetes-cluster/kubernetes-cluster-update.md) a {{ managed-k8s-name }} cluster.

For the service account to be able to access the registries, [assign](../../iam/operations/sa/assign-role-for-sa.md) to it the following roles for the registry folder:

* [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) for {{ container-registry-name }}.
* [cloud-registry.artifacts.puller](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller) for {{ cloud-registry-name }}.

With such an integration, you do not need to include any authentication data in the pod manifest, for example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: {{ registry }}/<registry_ID>/<Docker_image_name>:<tag>
```

If, for any reason, you cannot use a service account with the mentioned roles for authentication in {{ container-registry-name }} or {{ cloud-registry-name }}, use an [authorized key](../../iam/concepts/authorization/key.md) with an unlimited TTL.

{% note warning %}

A long-lived key is less secure than IAM tokens.

{% endnote %}

To authenticate with the registry using a key:

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Create an authorized key and save it to a file named `key.json`:

    ```bash
    yc iam key create \
      --service-account-name <service_account_name> \
      --output key.json
    ```

1. Create a secret with the key data:

    ```bash
    kubectl create secret docker-registry yc-registry-secret \
      --docker-server={{ registry }} \
      --docker-username=json_key \
      --docker-password="$(cat key.json)" \
      --namespace=<namespace>
    ```

1. Create a YAML file for the manifest with a link to the new secret:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: private-reg
    spec:
      containers:
      - name: private-reg-container
        image: {{ registry }}/<registry_ID>/<Docker_image_name>:<tag>
      imagePullSecrets:
      - name: yc-registry-secret
    ```

1. Apply the new configuration:

    ```bash
    kubectl apply -f <YAML_file_path>
    ```

1. Make sure the image is successfully pulled from the registry:

    ```bash
    kubectl get pods
    ```

    Result:

    ```text
    NAME           READY   STATUS             RESTARTS   AGE
    private-reg    1/1     Running            0          7s
    ```
