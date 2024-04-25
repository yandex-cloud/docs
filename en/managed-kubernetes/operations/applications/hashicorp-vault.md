# Installing HashiCorp Vault with {{ kms-name }} support


[HashiCorp Vault](https://www.vaultproject.io/) is an open-source tool for securely storing and accessing secrets (e.g., passwords, certificates, and tokens).

The application image contains a pre-installed build of HashiCorp Vault with added support for [Auto Unseal](https://developer.hashicorp.com/vault/docs/concepts/seal#auto-unseal) via [{{ kms-full-name }}](../../../kms/). The build is based on [HashiCorp Vault](https://github.com/hashicorp/vault/tags) of the appropriate version.

To install HashiCorp Vault:
1. [Create a service account and keys](#sa-keys-create).
1. [Install HashiCorp Vault](#install).
1. [Initialize the vault](#vault-init).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Creating a service account and keys {#sa-keys-create}

To use HashiCorp Vault, you need:
* [Service account](../../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../../iam/concepts/access-control/roles.md)
* [Authorized key](../../../iam/concepts/authorization/key.md)
* [Symmetric encryption key](../../../kms/concepts/key.md)
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
     --id <folder_ID> \
     --service-account-name vault-kms \
     --role kms.keys.encrypterDecrypter
   ```

   You can fetch the folder ID with a [list of folders](../../../resource-manager/operations/folder/get-id.md).

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**![Marketplace](../../../_assets/console-icons/shopping-cart.svg) tab.
1. Under **Applications available for installation**, select [HashiCorp Vault with {{ kms-name }} support](/marketplace/products/yc/vault-yckms-k8s) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter a name for the application.
   * **Service account key for Vault**: Copy the contents of the `authorized-key.json` file to this field.
   * **{{ kms-short-name }} key ID for Vault**: Specify the [previously obtained](#sa-keys-create) {{ kms-name }} key ID.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with HashiCorp Vault, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat authorized-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_vault-yckms-k8s.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_vault-yckms-k8s.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file yandexKmsAuthJson=authorized-key.json \
     hashicorp ./vault/
   ```

   This command also creates a new namespace required for HashiCorp Vault.

## Initializing the vault {#vault-init}

Once HashiCorp Vault is installed, you need to initialize one of its servers. The initialization process generates credentials required to [unseal](https://www.vaultproject.io/docs/concepts/seal#why) all the vault servers.

{% note info %}

While initializing the vault, there is no need to perform the `unseal` operation, because the application image is integrated with {{ kms-name }}.

For more information, see [Auto Unseal](../../../kms/tutorials/vault-secret.md) and the [HashiCorp Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#initialize-and-unseal-vault) documentation.

{% endnote %}

To initialize the vault:
1. Make sure that the application switched to `Running` and has `0/1` ready [pods](../../concepts/index.md#pod):

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Result:

   ```text
   NAME              READY  STATUS   RESTARTS  AGE
   <vault_pod_name>  0/1    Running  0         58s
   ```

1. Initialize the vault:

   ```bash
   kubectl exec \
     --stdin=true \
     --tty=true <vault_pod_name> \
     -- vault operator init
   ```

   Result:

   ```text
   Recovery Key 1: ulbugw4IKttmCCPprF6JwmUCyx1YfieCQPQi********
   Recovery Key 2: S0kcValC6qSfEI4WJBovSbJWZntBUwtTrtis********
   Recovery Key 3: t44ZRqbzLZNzfChinZNzLCNnwvFN/R52vbD*/*******
   ...

   Recovery key initialized with 5 key shares and a key threshold of 3. Please
   securely distribute the key shares printed above.
   ```

1. Query the list of application pods again and make sure that one pod is ready:

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Result:

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   vault-yckms-k8s-0  1/1    Running  0         5m
   ```

## See also {#see-also}

* [HashiCorp Vault documentation](https://developer.hashicorp.com/vault/docs?product_intent=vault).
* [{{ kms-name }} documentation](../../../kms/).