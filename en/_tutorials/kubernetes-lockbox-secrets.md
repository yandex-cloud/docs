[External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/) enables you to set up syncing of {{ lockbox-name }} [secrets](../lockbox/concepts/secret.md) with {{ managed-k8s-name }} [cluster secrets](../managed-kubernetes/concepts/encryption.md).

There are [several schemas for integrating](https://external-secrets.io/latest/guides/multi-tenancy/) {{ lockbox-name }} with {{ managed-k8s-name }}. The example below describes [ESO as a Service](https://external-secrets.io/latest/guides/multi-tenancy/#eso-as-a-service):

![image](../_assets/managed-kubernetes/mks-lockbox-eso.svg)

To set up secret syncing:
1. [Getting started](#before-you-begin).
1. [Install the External Secrets Operator](#install-eso).
1. [Configure {{ lockbox-name }}](#configure-lockbox).
1. [Configure the {{ k8s }} cluster](#configure-k8s).
1. [Create an External Secret](#create-es).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy an infrastructure for syncing {{ lockbox-short-name }} secrets with {{ managed-k8s-name }} cluster secrets via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-you-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources for syncing secrets includes:
* Fee for using the {{ managed-k8s-name }} master (see [{{ managed-k8s-full-name }} pricing](../managed-kubernetes/pricing.md)).
* Fee for a node group's computing resources and disks (see [{{ compute-full-name }} pricing](../compute/pricing.md)).

### Create an infrastructure {#create-infrastructure}


1. [Create a cloud network](../vpc/operations/network-create.md) and [subnet](../vpc/operations/subnet-create.md).

1. Create a service account:

    {% list tabs %}

    - Management console

      1. In the [management console]({{link-console-main}}), select a folder where you want to create a service account.
      1. Go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `eso-service-account`.

         The name format requirements are as follows:

          {% include [name-format](../_includes/name-format.md) %}

      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    - CLI

      To create a service account, run the following command:

      ```bash
      yc iam service-account create --name <service_account_name>
      ```

      Where `--name` is the service account name, e.g., `eso-service-account`. The name format requirements are as follows:

      {% include [name-format](../_includes/name-format.md) %}

   {% endlist %}

1. Create an [authorized key](../iam/concepts/authorization/access-key.md) for the service account and save it to the `authorized-key.json` file:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
      1. Go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Choose a service account, such as `eso-service-account`, and click the line with its name.
      1. In the top panel, click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
      1. Select the encryption algorithm.
      1. Enter a description of the key so that you can easily find it in the management console.
      1. Save both the public and private keys. The private key is not saved in {{ yandex-cloud }}, and you will not be able to view the public key in the management console.

   - CLI

      To create an authorized key, run the following command:

      ```bash
      yc iam key create \
        --service-account-name <service_account_name> \
        --output authorized-key.json
      ```

      Where:
      * `--service-account-name`: Name of the service account, such as `eso-service-account`.
      * `--output`: Name of the file to save the authorized key contents to.

   {% endlist %}

1. [Create](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster with any suitable configuration.

   {% note info %}

   Make sure the cluster node has at least 10 pods needed for External Secrets Operator to run.

   {% endnote %}

1. [Create](../managed-kubernetes/operations/node-group/node-group-create.md) a node group.

### Configure the environment {#environment-set-up}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. Install the `jq` utility:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the External Secrets Operator {#install-eso}

{% list tabs %}

- Using {{ marketplace-full-name }}

   To install [External Secrets Operator](/marketplace/products/yc/external-secrets) using {{ marketplace-name }}, follow [this guide](../managed-kubernetes/operations/applications/external-secrets-operator.md#install-eso-marketplace).


- Using Helm

   1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).

   1. Add a Helm repository named `external-secrets`:

      ```bash
      helm repo add external-secrets https://charts.external-secrets.io
      ```

   1. Install the External Secrets Operator in the {{ k8s }} cluster:

      ```bash
      helm install external-secrets \
        external-secrets/external-secrets \
        --namespace external-secrets \
        --create-namespace
      ```

      {% note info %}

      This command creates a new `external-secrets` namespace required for using the External Secrets Operator.

      {% endnote %}

      Result:

      ```text
      NAME: external-secrets
      LAST DEPLOYED: Sun Sep 19 11:20:58 2021
      NAMESPACE: external-secrets
      STATUS: deployed
      REVISION: 1
      TEST SUITE: None
      NOTES:
      external-secrets has been deployed successfully!
      ...
      ```

{% endlist %}

## Configure {{ lockbox-name }} {#configure-lockbox}

{% list tabs %}

- Management console

   1. Create a secret:
      1. In the [management console]({{ link-console-main }}), select the folder where you will be creating your secret.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** and click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret, such as `lockbox-secret`.
      1. Under **{{ ui-key.yacloud.lockbox.forms.section_version }}**:
         * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter a non-secret ID: `password`.
         * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the confidential data you want to store: `p@$$w0rd`.
      1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Save the ID of the secret created. You will need it later.
   1. Assign the `lockbox.payloadViewer` role for the secret to the `eso-service-account`:
      1. Click the `lockbox-secret` name.
      1. On the left-hand panel, select ![image](../_assets/organization/icon-groups.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. In the window that opens, click ![image](../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
      1. Select `eso-service-account`.
      1. Click ![image](../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select `lockbox.payloadViewer`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   1. Create a secret named `lockbox-secret`:

      ```bash
      yc lockbox secret create \
        --name lockbox-secret \
        --payload '[{"key": "password","textValue": "p@$$w0rd"}]'
      ```

      Where:
      * `--name`: Name of the secret.
      * `--payload`: Content of the secret.

   1. Get the secret ID:

      ```bash
      yc lockbox secret list
      ```

      Result:

      ```text
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      |          ID          |      NAME      | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      | e6qoffd33mf0osc2lpum | lockbox-secret |            | 2021-09-19 04:33:44 | e6qlkguf0hs4q3i6jpen | ACTIVE |
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      ```

      Save the secret ID (see the `ID` column). You will need it later.

   1. Assign the `lockbox.payloadViewer` role for the secret to the `eso-service-account`:

      ```bash
      yc lockbox secret add-access-binding \
        --name lockbox-secret \
        --service-account-name eso-service-account \
        --role lockbox.payloadViewer
      ```

      Where:
      * `--name`: Name of the secret.
      * `--service-account-name`: Name of the service account.
      * `--role`: Role being assigned.

{% endlist %}

## Configure a {{ managed-k8s-name }} {#configure-k8s}

1. Create a `ns` [namespace](../managed-kubernetes/concepts/index.md#namespace) to store External Secrets Operator objects in:

   ```bash
   kubectl create namespace ns
   ```

1. Create a `yc-auth` secret with the `eso-service-account` key:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=authorized-key.json
   ```

1. Create a [SecretStore](https://external-secrets.io/latest/api/secretstore/) that contains the `yc-auth` secret:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1alpha1
   kind: SecretStore
   metadata:
     name: secret-store
   spec:
     provider:
       yandexlockbox:
         auth:
           authorizedKeySecretRef:
             name: yc-auth
             key: authorized-key'
   ```

## Create an External Secret {#create-es}

1. Create an object named [ExternalSecret](https://external-secrets.io/latest/api/externalsecret/) pointing to `lockbox-secret` in `secret-store`:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1alpha1
   kind: ExternalSecret
   metadata:
     name: external-secret
   spec:
     refreshInterval: 1h
     secretStoreRef:
       name: secret-store
       kind: SecretStore
     target:
       name: k8s-secret
     data:
     - secretKey: password
       remoteRef:
         key: e6qoffd33mf0osc2lpum
         property: password'
   ```

   Where:
   * `key`: ID of the {{ lockbox-name }} secret.
   * `spec.target.name`: Name of the new key (`k8s-secret`). The External Secrets Operator creates this key and inserts the parameters of `lockbox-secret`.

1. Make sure that the new `k8s-secret` key contains the `lockbox-secret` value:

   ```bash
   kubectl --namespace ns get secret k8s-secret \
     --output=json | \
     jq --raw-output ."data"."password" | \
     base64 --decode
   ```

   The command result will contain the value of the `password` key of `lockbox-secret`:

   ```text
   p@$$w0rd
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

{% list tabs %}

- Manually

   1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a public static IP address for the cluster, [delete it](../vpc/operations/address-delete.md).
   1. [Delete](../lockbox/operations/secret-delete.md) `lockbox-secret`.

- Using {{ TF }}

   1. In the terminal, go to the directory that contains the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.
   1. Confirm that the resources have been updated.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

{% endlist %}

## How to create an infrastructure using {{ TF }} {#terraform}

1. If you do not have {{ TF }} yet, [install it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Download the cluster configuration file [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) to the same working directory. The file describes:
   * [Network](../vpc/concepts/network.md#network).
   * [Subnet](../vpc/concepts/network.md#network).
   * [Security group](../vpc/concepts/security-groups.md) and [rules](../managed-kubernetes/operations/connect/security-groups.md) needed to run the {{ managed-k8s-name }} cluster:
      * Rules for service traffic.
      * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
   * {{ managed-k8s-name }} cluster.
   * [Service account](../iam/concepts/users/service-accounts.md) required to use the {{ managed-k8s-name }} cluster and node group.
1. Specify the following in the configuration file:
   * [Folder ID](../resource-manager/operations/folder/get-id.md).
   * {{ k8s }} versions for the cluster and {{ managed-k8s-name }} node groups.
   * {{ managed-k8s-name }} cluster CIDR.
   * Name of the cluster service account.
1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
1. Make sure the {{ TF }} configuration files are correct using this command:

   ```bash
   terraform validate
   ```

   If there are any errors in the configuration files, {{ TF }} will point them out.
1. Create the required infrastructure:

   {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}
