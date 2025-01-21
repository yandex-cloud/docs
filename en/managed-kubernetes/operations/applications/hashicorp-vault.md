---
title: Installing HashiCorp Vault with {{ kms-full-name }} support
description: Follow this guide to install HashiCorp Vault with {{ kms-full-name }} support.
---

# Installing HashiCorp Vault with {{ kms-name }} support


[HashiCorp Vault](https://www.vaultproject.io/) is an open-source tool for securely storing and accessing secrets (e.g., passwords, certificates, and tokens).

The application image contains a pre-installed build of HashiCorp Vault with added support for [Auto Unseal](https://developer.hashicorp.com/vault/docs/concepts/seal#auto-unseal) via [{{ kms-full-name }}](../../../kms/). The build is based on [HashiCorp Vault](https://github.com/hashicorp/vault/tags) of the appropriate version.

To install HashiCorp Vault:
1. [Prepare everything you need to get started](#before-you-begin).
1. Install HashiCorp Vault using [{{ marketplace-full-name }}](#marketplace-install) or [Helm](#helm-install).
1. [Initialize the vault](#vault-init).

## Getting started {#before-you-begin}

To use HashiCorp Vault, you need:
* [Service account](../../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../../iam/concepts/access-control/roles.md).
* [Authorized key](../../../iam/concepts/authorization/key.md).
* [Symmetric encryption key](../../../kms/concepts/key.md).

1. [Create a service account](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name vault-kms
   ```

1. [Create an authorized key](../../../iam/operations/authorized-key/create.md) for the service account and save it to the `authorized-key.json` file:

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

   Save the key `id`. You will need it when installing the application.
1. [Assign](../../../iam/operations/roles/grant.md) the `kms.keys.encrypterDecrypter` role to the service account you created previously:

   ```bash
   yc resource-manager folder add-access-binding \
     --id <folder_ID> \
     --service-account-name vault-kms \
     --role kms.keys.encrypterDecrypter
   ```

   You can fetch the folder ID with a [list of folders](../../../resource-manager/operations/folder/get-id.md).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

{% note warning %}

When using {{ marketplace-name }} to install HashiCorp Vault that supports {{ kms-name }}, the [Agent injector](https://developer.hashicorp.com/vault/docs/platform/k8s/injector) tool will be used to deliver secrets. To use the alternative [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi) tool, install the product using a [Helm chart](#helm-install). For more information about the differences between these mechanisms, see the [Hashicorp documentation](https://developer.hashicorp.com/vault/docs/platform/k8s/injector-csi).

{% endnote %}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [HashiCorp Vault with {{ kms-name }} support](/marketplace/products/yc/vault-yckms-k8s) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Specify the app name.
   * **Service account key for Vault**: Copy the contents of the `authorized-key.json` file to this field.
   * **{{ kms-short-name }} key ID for Vault**: Specify the [previously obtained](#before-you-begin) {{ kms-name }} key ID.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with HashiCorp Vault, run the following command, specifying the parameters of the resources you created [earlier](#before-you-begin):

   ```bash
   cat <path_to_file_with_authorized_key> | helm registry login cr.yandex \
     --username 'json_key' \
     --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/vault/chart/vault \
     --version 0.28.1+yckms \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file yandexKmsAuthJson=<path_to_file_with_authorized_key> \
     --set yandexKmsKeyId=<KMS_key_ID> \
     hashicorp ./vault/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   Command parameters:
   * `<path_to_file_with_authorized_key>`: Path to the `authorized-key.json` file you [saved earlier](#before-you-begin).
   * `<namespace>`: New namespace that will be created for HashiCorp Vault.
   * `<KMS_key_ID>`: [Previously obtained](#before-you-begin) {{ kms-name }} key ID.

   This command will install HashiCorp Vault with KMS support and the [Agent injector](https://developer.hashicorp.com/vault/docs/platform/k8s/injector) secret delivery tool to the cluster. To use the alternative [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi) mechanism, add the following parameters to the command:

   ```bash
   --set "injector.enabled=false" \
   --set "csi.enabled=true"
   ```

   For more information about the differences between these mechanisms, see the [Hashicorp documentation](https://developer.hashicorp.com/vault/docs/platform/k8s/injector-csi).

## Initializing the vault {#vault-init}

Once HashiCorp Vault is installed, you need to initialize one of its servers. The initialization process generates credentials required to [unseal](https://www.vaultproject.io/docs/concepts/seal#why) all the vault servers.

{% note info %}

While initializing the vault, there is no need to perform the `unseal` operation, because the application image is integrated with {{ kms-name }}.

For more information, see [Auto Unseal](../../../kms/tutorials/vault-secret.md) and the [HashiCorp Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#initialize-and-unseal-vault) documentation.

{% endnote %}

To initialize the vault:
1. Make sure that the application switched to `Running` and has `0/1` ready [pods](../../concepts/index.md#pod):

   ```bash
   kubectl get pods \
     --namespace=<namespace> \
     --selector='app.kubernetes.io/name=vault'
   ```

   Result:

   ```text
   NAME              READY  STATUS   RESTARTS  AGE
   <vault_pod_name>  0/1    Running  0         58s
   ```

1. Initialize the vault:

   ```bash
   kubectl exec \
     --namespace=<namespace> \
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

   Save the resulting data in a secure location.

1. Query the list of application pods again and make sure that one pod is ready:

   ```bash
   kubectl get pods \
     --namespace=<namespace> \
     --selector='app.kubernetes.io/name=vault'
   ```

   Result:

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   vault-yckms-k8s-0  1/1    Running  0         5m
   ```

## See also {#see-also}

* [HashiCorp Vault documentation](https://developer.hashicorp.com/vault/docs?product_intent=vault)
* [{{ kms-name }} documentation](../../../kms/)
* [{#T}](../../tutorials/marketplace/hashicorp-vault.md)
* [{#T}](./external-secrets-operator.md)
* [{#T}](../../tutorials/kubernetes-lockbox-secrets.md)
