# Installing HashiCorp Vault with {{ kms-name }} support

[HashiCorp Vault](https://www.vaultproject.io/) is an open source tool for securely storing and accessing secrets (such as passwords, certificates, and tokens).

The application image contains a pre-installed build of HashiCorp Vault with [added support for Auto Unseal](https://github.com/hashicorp/vault/compare/v1.8.2...yandex-cloud:v1.8.2+yckms) via [{{ kms-full-name }}](../../../kms/). The build is based on [HashiCorp Vault 1.8.2](https://github.com/hashicorp/vault/tree/v1.8.2).

To install HashiCorp Vault:
1. [Create a service account and keys](#sa-keys-create).
1. [Install HashiCorp Vault](#install).
1. [Initialize the vault](#vault-init).

## Creating a service account and keys {#sa-keys-create}

To use HashiCorp Vault, you need:
* A [service account](../../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../../iam/concepts/access-control/roles.md).
* An [authorized key](../../../iam/concepts/authorization/key.md).
* A [symmetric encryption key](../../../kms/concepts/key.md).
1. [Create a service account](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name vault-kms
   ```

1. [Create an authorized key](../../../iam/operations/authorized-key/create.md) for the service account and save it to a file named `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name vault-kms \
     --output authorized-key.json
   ```

1. [Create a {{ kms-name }} symmetric key](../../../kms/operations/key.md#create):

   ```bash
   yc kms symmetric-key create \
     --name example-key \
     --default-algorithm aes-256 \
     --rotation-period 24h
   ```

   Save the key ID (`id`). You will need it when installing the application.
1. [Assign the role](../../../iam/operations/roles/grant.md) `kms.keys.encrypterDecrypter` to the {{ kms-name }} key:

   ```bash
   yc resource-manager folder add-access-binding \
     --id <folder ID> \
     --service-account-name vault-kms \
     --role kms.keys.encrypterDecrypter
   ```

   You can fetch the folder ID with a [list of folders](../../../resource-manager/operations/folder/get-id.md).

## Installing HashiCorp Vault {#install}

{% list tabs %}

- Installation using {{ marketplace-full-name }}

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
  1. Under **Applications available for installation**, select [HashiCorp Vault 1.8.2 with {{ kms-name }} support](/marketplace/products/yc/vault-yckms-k8s) and click **Use**.
  1. Configure the application:
     * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
     * **Application name**: Enter an application name.
     * **Service account key for Vault**: Copy the contents of the `authorized-key.json` file to this field.
     * **{{ kms-short-name }} key ID for Vault**: Specify the [previously obtained](#sa-keys-create) {{ kms-name }} key ID.
  1. Click **Install**.

- Installation using a Helm chart

  1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).
  1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with HashiCorp Vault , run the following command:

     ```bash
     export HELM_EXPERIMENTAL_OCI=1 && \
     cat authorized-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
     helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/vault/chart/vault \
       --version <Helm chart version> \
       --untar && \
     helm install \
       --namespace hashicorp \
       --create-namespace \
       --set-file yandexKmsAuthJson=authorized-key.json \
       hashicorp ./vault/
     ```

     This command also creates a new `hashicorp` namespace required for HashiCorp Vault.

     You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/vault-yckms-k8s).

{% endlist %}

## Initializing the vault {#vault-init}

Once HashiCorp Vault is installed, you need to initialize one of its servers. The initialization process generates credentials required to [unseal](https://www.vaultproject.io/docs/concepts/seal#why) all the vault servers.

{% note info %}

While initializing the vault, there is no need to perform the `unseal` operation, since the application image is integrated with {{ kms-name }}.

For more information, see [Auto Unseal](../../../kms/tutorials/vault-secret.md) and the [HashiCorp Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#initialize-and-unseal-vault) documentation.

{% endnote %}

To initialize the vault:
1. Make sure that the application switched to `Running` and has `0/1` ready [pods](../../concepts/index.md#pod):

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Command result:

   ```text
   NAME              READY  STATUS   RESTARTS  AGE
   <vault pod name>  0/1    Running  0         58s
   ```

1. Initialize the vault:

   ```bash
   kubectl exec \
     --stdin=true \
     --tty=true <vault pod name> \
     -- vault operator init
   ```

   Command result:

   ```text
   Recovery Key 1: ulbugw4IKttmCCPprF6JwmUCyx1YfieCQPQiI2S0VV9o
   Recovery Key 2: S0kcValC6qSfEI4WJBovSbJWZntBUwtTrtisSIcS3n0e
   Recovery Key 3: t44ZRqbzLZNzfChinZNzLCNnwvFN/R52vbDq/UueHPPg
   ...

   Recovery key initialized with 5 key shares and a key threshold of 3. Please
   securely distribute the key shares printed above.
   ```

1. Query the list of application pods again and make sure that one pod is ready:

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Command result:

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   vault-yckms-k8s-0  1/1    Running  0         5m
   ```