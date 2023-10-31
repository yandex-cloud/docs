[External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/) enables you to set up syncing of [{{ lockbox-name }}](../lockbox/) [secrets](../lockbox/concepts/secret.md) with [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) [secrets](../managed-kubernetes/concepts/encryption.md).

There are [several schemas for integrating](https://external-secrets.io/latest/guides/multi-tenancy/) {{ lockbox-name }} with {{ managed-k8s-name }}. The example below describes [ESO as a Service](https://external-secrets.io/latest/guides/multi-tenancy/#eso-as-a-service):

![image](../_assets/managed-kubernetes/mks-lockbox-eso.svg)

To set up secret syncing:
1. [Install the External Secrets Operator and set up {{ lockbox-name }}](#install-eso-lockbox).
1. [Configure the {{ managed-k8s-name }} cluster](#configure-k8s).
1. [Create an External Secret](#create-es).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy an infrastructure for syncing {{ lockbox-name }} secrets with {{ managed-k8s-name }} cluster secrets via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-you-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources for syncing secrets includes:
* Fee for using the [{{ managed-k8s-name }} master](../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../managed-kubernetes/pricing.md)).
* Fee for a [{{ managed-k8s-name }} node group's](../managed-kubernetes/concepts/index.md#node-group) [computing resources](../compute/concepts/vm-platforms.md) and [disks](../compute/concepts/disk.md) (see [{{ compute-full-name }} pricing](../compute/pricing.md)).

### Create an infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. If you do not have a [network](../vpc/concepts/network.md#network) yet, [create one](../vpc/operations/network-create.md).
   1. If you do not have any [subnets](../vpc/concepts/network.md#subnet), [create them](../vpc/operations/subnet-create.md) in the [availability zones](../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and node group will be created.
   1. [Create service accounts](../iam/operations/sa/create.md):
      * [Service account](../iam/concepts/users/service-accounts.md) for {{ k8s }} resources with the [{{ roles-editor }}](../iam/concepts/access-control/roles.md#editor) [role](../iam/concepts/access-control/roles.md) for the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster is created.
      * Service account for {{ managed-k8s-name }} nodes with the [{{ roles-cr-puller }}](../iam/concepts/access-control/roles.md#cr-images-puller) role for the folder with the [Docker image](../container-registry/concepts/docker-image.md) [registry](../container-registry/concepts/registry.md). {{ managed-k8s-name }} nodes will pull the required Docker images from the registry on behalf of this account.

      {% note tip %}

      You can use the same service account for all operations.

      {% endnote %}

   1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md#node-group-create). When creating a {{ managed-k8s-name }} cluster, specify the previously created service accounts for the resources and nodes.
   1. [Configure security groups](../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster to run.
   1. [Create a {{ lockbox-name }} secret](../lockbox/operations/secret-create.md) with the following properties:
      * **{{ ui-key.yacloud.common.name }}**: `lockbox-secret`.
      * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: Enter the `password` non-secret ID.
      * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Enter the confidential data for storing `p@$$w0rd`.

      Save the ID of the secret. You will need it later.

- Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-cluster-and-lockbox.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster-and-lockbox.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory.

      This file describes:
      * [Network](../vpc/concepts/network.md#network)
      * [Subnet](../vpc/concepts/network.md#subnet)
      * [Security group](../managed-kubernetes/operations/connect/security-groups.md) and rules required for the operation of the {{ managed-k8s-name }} cluster and node group:
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing the {{ managed-k8s-name }} cluster with `kubectl` through ports 443 and 6443.
         * Rules for connecting to services from the internet.
      * {{ managed-k8s-name }} cluster.
      * [Service account](../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
      * {{ lockbox-name }} secret.
   1. Specify the following in the configuration file:
      * [Folder ID](../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * Name of the service account for {{ managed-k8s-name }} resources and nodes.
   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

   1. Save the created secret's ID that you entered in the terminal. You will need it later.

{% endlist %}

### Configure the environment {#environment-set-up}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. Install the `jq` utility:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Install the External Secrets Operator and set up {{ lockbox-name }} {#install-eso-lockbox}

1. Follow this [guide](../managed-kubernetes/operations/applications/external-secrets-operator.md) to install the [External Secrets Operator](/marketplace/products/yc/external-secrets).
1. [Assign to the service account](../lockbox/operations/secret-access.md) you created when [installing](#install-eso) the External Secrets Operator the `lockbox.payloadViewer` role for the [previously created](#deploy-infrastructure) `lockbox-secret`.

## Configure a {{ managed-k8s-name }} {#configure-k8s}

1. Create a `ns` [namespace](../managed-kubernetes/concepts/index.md#namespace) to store External Secrets Operator objects in:

   ```bash
   kubectl create namespace ns
   ```

1. Create a `yc-auth` secret with the `sa-key.json` key that you created when [installing](#install-eso) the External Secrets Operator:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=sa-key.json
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
         key: <secret_id>
         property: password'
   ```

   Where:
   * `key`: ID of the [previously created](#deploy-infrastructure) {{ lockbox-name }} secret named `lockbox-secret`.
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

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs %}

- Manually

   1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a [public static IP address](../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster, [delete it](../vpc/operations/address-delete.md).
   1. [Delete](../lockbox/operations/secret-delete.md) `lockbox-secret`.

- Using {{ TF }}

   1. In the terminal, go to the directory that contains the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-cluster-and-lockbox.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-cluster-and-lockbox.tf` configuration file will be deleted.

{% endlist %}