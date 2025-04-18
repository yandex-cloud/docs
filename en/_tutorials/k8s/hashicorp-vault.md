# Using HashiCorp Vault to store secrets


[HashiCorp Vault](https://www.vaultproject.io/) is an open-source tool for securely storing and accessing secrets (e.g., passwords, certificates, and tokens).

Configure storage of secrets and access to them inside a {{ managed-k8s-full-name }} cluster using a {{ marketplace-full-name }} product called [HashiCorp Vault with {{ kms-name }}](/marketplace/products/yc/vault-yckms-k8s) support.

This guide describes a use case of mounting a secret from HashiCorp Vault using a [Container Storage Interface](https://kubernetes.io/docs/concepts/storage/volumes/#csi) (CSI) volume.

To enable access to a secret in a {{ managed-k8s-name }} cluster using HashiCorp Vault:
1. [Get your cloud ready](#before-you-begin).
1. [Install HashiCorp Vault](#install-vault).
1. [Log in to HashiCorp Vault](#login-vault).
1. [Create a secret](#create-secret).
1. [Configure the {{ k8s }} authentication method](#kubernetes-authentication).
1. [Install the SCI driver for the secret storage](#install-sci).
1. [Create a SecretProviderClass resource](#create-resource).
1. [Create a pod with a mounted secret](#create-pod).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* {{ kms-name }} fee: number of active key versions (with `Active` or `Scheduled For Destruction` for status) and completed cryptographic operations (see [{{ kms-name }} pricing](../../kms/pricing.md)).


## Get your cloud ready {#before-you-begin}

1. Create a {{ k8s }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and [node group](../../managed-kubernetes/concepts/index.md#node-group).

    {% list tabs group=instructions %}

    * Manually {#manual}

        1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
        1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
        1. [Create service accounts](../../iam/operations/sa/create.md):

            * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../resource-manager/concepts/resources-hierarchy.md#folder) for the [folder](../../managed-kubernetes/security/index.md#yc-api) where the {{ k8s }} cluster is created. This service account will be used to create the resources required for the {{ k8s }} cluster.
            * Service account with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) [role](../../iam/concepts/access-control/roles.md). Nodes will pull the required [Docker images](../../container-registry/concepts/registry.md) from the [registry](../../container-registry/concepts/docker-image.md) on behalf of this account.

            {% note tip %}

            You can use the same [service account](../../iam/concepts/users/service-accounts.md) to manage your {{ k8s }} cluster and its node groups.

            {% endnote %}

        1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. [Create a {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

    * Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) cluster configuration file to the same working directory. This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * {{ k8s }} cluster.
            * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group to operate.
            * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

                {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. Specify the following in the `k8s-cluster.tf` file:

            * [Folder ID](../../resource-manager/operations/folder/get-id.md).
            * {{ k8s }} version for the {{ k8s }} cluster and node groups.
            * {{ k8s }} cluster CIDR.
            * Name of the {{ managed-k8s-name }} cluster service account.

        1. Check that the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install HashiCorp Vault {#install-vault}

Install HashiCorp Vault using Helm and initialize the storage [according to instructions](../../managed-kubernetes/operations/applications/hashicorp-vault.md). In the installation command, specify the `hcv` namespace and add the extra parameters to activate the [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi) mechanism:

```bash
--namespace hcv \
--set "injector.enabled=false" \
--set "csi.enabled=true"
```

## Log in to HashiCorp Vault {#login-vault}

1. Run a HashiCorp Vault interactive shell session for the `hashicorp-vault-0` pod:

    ```bash
    kubectl exec -it hashicorp-vault-0 \
       --namespace hcv \
       -- /bin/sh
    ```

1. [Unseal](https://www.vaultproject.io/docs/concepts/seal#why) the storage:

    ```bash
    vault operator unseal
    ```

    Enter one of the recovery keys (`Recovery Key`) you got during [storage initialization](../../managed-kubernetes/operations/applications/hashicorp-vault.md#vault-init).

1. Log in to HashiCorp Vault using the root token:

    ```bash
    vault login
    ```

    Enter the root token (`Initial Root Token`) you got during storage initialization.

## Create a secret {#create-secret}

1. Enable the `kv` secret mechanism at the `secret` path:

    ```bash
    vault secrets enable -path=secret kv
    ```

1. Create a secret at `secret/db-pass`. Specify a password as a secret:

    ```bash
    vault kv put secret/db-pass password="12345678"
    ```

1. Make sure the secret is available for reading at `secret/db-pass`:

    ```bash
    vault kv get secret/db-pass
    ```

    Result:

    ```text
    ====== Data ======
    Key         Value
    ---         -----
    password    12345678
    ```

## Configure the {{ k8s }} authentication method {#kubernetes-authentication}

This method will allow you to log in using a {{ k8s }} service account token.

1. Enable the {{ k8s }} authentication method:

    ```bash
    vault auth enable kubernetes
    ```

1. Configure authentication with {{ k8s }} API address:

    ```bash
    vault write auth/kubernetes/config \
       kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
    ```

    The `KUBERNETES_PORT_443_TCP_ADDR` environment variable refers to the internal network address of the {{ k8s }} node.

1. Create a policy named `internal-app` that will allow the {{ k8s }} service account to read the secret created earlier:

    ```bash
    vault policy write internal-app - <<EOF
    path "secret/db-pass" {
      capabilities = ["read"]
    }
    EOF
    ```

1. Create the `database` role that will link the `internal-app` policy to the {{ k8s }} `webapp-sa` service account (you will create it later):

    ```bash
    vault write auth/kubernetes/role/database \
       bound_service_account_names=webapp-sa \
       bound_service_account_namespaces=hcv \
       policies=internal-app \
       ttl=20m
    ```

    Tokens returned after authentication will be valid for 20 minutes.

1. Exit HashiCorp Vault:

    ```bash
    exit
    ```

## Install the SCI driver for the secret storage {#install-sci}

1. Add a Helm repository named `secrets-store-csi-driver`:

    ```bash
    helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
    ```

1. Install the SCI driver:

    ```bash
    helm install csi secrets-store-csi-driver/secrets-store-csi-driver \
       --namespace=hcv \
       --set syncSecret.enabled=true
    ```

1. Make sure the driver is running and ready:

    ```bash
    kubectl get pods -n hcv -l "app=secrets-store-csi-driver"
    ```

    Result:

    ```text
    NAME                                 READY   STATUS    RESTARTS   AGE
    csi-secrets-store-csi-driver-nbxcd   3/3     Running   0          4m28s
    ```

## Create a SecretProviderClass resource {#create-resource}

1. Create a file named `spc-vault-database.yaml` with settings that are provided to the CSI provider:

    {% cut "spc-vault-database.yaml" %}

    ```yaml
    apiVersion: secrets-store.csi.x-k8s.io/v1
    kind: SecretProviderClass
    metadata:
      name: vault-database
    spec:
      provider: vault
      parameters:
        vaultAddress: "http://hashicorp-vault.hcv:8200"
        roleName: "database"
        objects: |
          - objectName: "db-password"
            secretPath: "secret/db-pass"
            secretKey: "password"
    ```

    {% endcut %}

1. Create a resource named `SecretProviderClass`:

    ```bash
    kubectl apply -f spc-vault-database.yaml -n hcv
    ```

## Create a pod with a mounted secret {#create-pod}

1. Create a service account named `webapp-sa` for the {{ k8s }} cluster:

    ```bash
    kubectl create serviceaccount webapp-sa \
       --namespace hcv
    ```

1. Create a file named `webapp-pod.yaml` containing the `webapp` pod configuration:

    {% cut "spc-vault-database.yaml" %}

    ```yaml
    kind: Pod
    apiVersion: v1
    metadata:
      name: webapp
    spec:
      serviceAccountName: webapp-sa
      containers:
      - image: jweissig/app:0.0.1
        name: webapp
        volumeMounts:
        - name: secrets-store-inline
          mountPath: "/mnt/secrets-store"
          readOnly: true
      volumes:
        - name: secrets-store-inline
          csi:
            driver: secrets-store.csi.k8s.io
            readOnly: true
            volumeAttributes:
              secretProviderClass: "vault-database"
    ```

    {% endcut %}

1. Create a pod named `webapp`:

    ```bash
    kubectl apply -f webapp-pod.yaml -n hcv 
    ```

1. Make sure the `webapp` pod is running and ready:

    ```bash
    kubectl get pod webapp -n hcv
    ```

    Result:

    ```text
    NAME     READY   STATUS    RESTARTS   AGE
    webapp   1/1     Running   0          5m25s
    ```

1. Display the secret password recorded to the file system at `/mnt/secrets-store/db-password`:

    ```bash
    kubectl exec webapp -n hcv -- cat /mnt/secrets-store/db-password
    ```

    Result:

    ```text
    12345678
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them.

{% list tabs group=instructions %}

* Manually {#manual}

    1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. [Delete the security groups](../../vpc/operations/security-group-delete.md).
    1. [Delete the subnet](../../vpc/operations/subnet-delete.md) and [network](../../vpc/operations/network-delete.md).
    1. [Delete the service accounts](../../iam/operations/sa/delete.md).
    1. [Delete the symmetric encryption key](../../kms/operations/key.md#delete).

* Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

## See also {#see-also}

* [HashiCorp Vault documentation](https://developer.hashicorp.com/vault/docs?product_intent=vault)
* [{#T}](../../managed-kubernetes/operations/applications/hashicorp-vault.md)
* [{#T}](../../managed-kubernetes/operations/applications/external-secrets-operator.md)
* [{#T}](../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md)
