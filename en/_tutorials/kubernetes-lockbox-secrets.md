[External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/) enables you to configure the synchronization of [{{ lockbox-name }}](../lockbox/)secrets with those of {{ managed-k8s-name }} clusters.

There are [several schemas for integrating](https://external-secrets.io/latest/guides/multi-tenancy/) {{ lockbox-name }} with {{ managed-k8s-name }}. The example below describes [ESO as a Service](https://external-secrets.io/latest/guides/multi-tenancy/#eso-as-a-service):

![image](../_assets/managed-kubernetes/mks-lockbox-eso.svg)

To set up secret syncing:
1. [Install the External Secrets Operator](#install-eso).
1. [Configure {{ lockbox-name }}](#configure-lockbox).
1. [Configure the {{ k8s }} cluster](#configure-k8s).
1. [Create an External Secret](#create-es).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

### Create an infrastructure {#create-infrastructure}

{% list tabs %}

- Manually

   1. [Create a cloud network](../vpc/operations/network-create.md) and [subnet](../vpc/operations/subnet-create.md).
   1. [Create a service account](../iam/operations/sa/create.md) named `eso-service-account`. You'll need it to work with the External Secrets Operator.
   1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the cluster configuration file [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) to the same working directory. The file describes:
      * [Network](../vpc/concepts/network.md#network).
      * [Network](../vpc/concepts/network.md#network).
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
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.
   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Prepare the environment {#prepare-env}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).
1. Install the `jq` utility:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Create a service account](../iam/operations/sa/create.md) named `eso-service-account`. You'll need it to work with the External Secrets Operator.
1. Create an [authorized key](../iam/concepts/authorization/access-key.md) for the service account and save it to the file `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name eso-service-account \
     --output authorized-key.json
   ```

1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the External Secrets Operator {#install-eso}

{% list tabs %}


- Using {{ marketplace-full-name }}

   To install [External Secrets Operator](/marketplace/products/yc/external-secrets) using {{ marketplace-name }}, [follow the instructions](../managed-kubernetes/operations/applications/external-secrets-operator.md#install-eso-marketplace).


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

      Command result:

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

1. [Create a secret](../lockbox/operations/secret-create.md):
   * **Name**: `lockbox-secret`.
   * **Key/Value**:
      * **Key**: `password`.
      * **Value** → **Text**: `p@$$w0rd`.
1. Get the secret ID:

   ```bash
   yc lockbox secret list
   ```

   Command result:

   ```text
   +--------------------------------------------+----------------+------------+---------------------+----------------------+--------+
   |                     ID                     |      NAME      | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
   +--------------------------------------------+----------------+------------+---------------------+----------------------+--------+
   | <{{ lockbox-name }} secret ID>             | lockbox-secret |            | 2021-09-19 04:33:44 | e6qlkguf0hs4q3i6jpen | ACTIVE |
   +--------------------------------------------+----------------+------------+---------------------+----------------------+--------+
   ```

1. To make sure that `eso-service-account` has access to the secret, assign it the `lockbox.payloadViewer` role:

   ```bash
   yc lockbox secret add-access-binding \
     --name lockbox-secret \
     --service-account-name eso-service-account \
     --role lockbox.payloadViewer
   ```

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
         key: <{{ lockbox-name }} secret ID>
         property: password'
   ```

   The `spec.target.name` parameter specifies the name of a new key: `k8s-secret`. The External Secrets Operator creates this key and inserts the parameters of `lockbox-secret`.

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

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

{% list tabs %}

- Manually

   1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a public static IP address for the cluster, [delete it](../vpc/operations/address-delete.md).
   1. [Delete](../lockbox/operations/secret-delete.md) `lockbox-secret`.

- Using {{ TF }}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.
   1. Confirm the update of resources.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

{% endlist %}