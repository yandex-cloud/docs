[External Secrets Operator](https://external-secrets.io/latest/provider-yandex-lockbox/) lets you set up the synchronization of [{{ lockbox-name }}](../lockbox/) secrets with {{ managed-k8s-name }} cluster secrets.

There are [multiple integration schemes](https://external-secrets.io/latest/guides-multi-tenancy/) for {{ lockbox-name }} and {{ managed-k8s-name }}. The example below describes [ESO as a Service](https://external-secrets.io/latest/guides-multi-tenancy/#eso-as-a-service):

{% if product == "yandex-cloud" %}

![image](../_assets/managed-kubernetes/mks-lockbox-eso.svg)

{% endif %}

To set up secret syncing:
1. [Install the External Secrets Operator](#install-eso).
1. [Configure {{ lockbox-name }}](#configure-lockbox).
1. [Configure a {{ k8s }} cluster](#configure-k8s).
1. [Create an External Secret](#create-es).

## Before you start {#before-you-begin}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. [Install the Helm]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install/){% endif %} package manager.
1. Install the `jq` utility:

   ```bash
   sudo apt update && \
   sudo apt install jq
   ```

1. [Create a service account](../iam/operations/sa/create.md) named `eso-service-account`. You'll need it to work with the External Secrets Operator.
1. Create an [authorized key](../iam/concepts/authorization/access-key.md) for the service account and save it to a file named `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name eso-service-account \
     --output authorized-key.json
   ```

1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.
1. [Install the kubectl utility]({{ k8s-docs }}/tasks/tools/install-kubectl/) and [set it up for working with the created cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-get-credetials.md).

## Install the External Secrets Operator {#install-eso}

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

   Command output:

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

## Configure {{ lockbox-name }} {#configure-lockbox}

1. Create a secret named `lockbox-secret`:

   ```bash
   yc lockbox secret create \
     --name lockbox-secret \
     --payload '[{"key": "password","textValue": "p@$$w0rd"}]'
   ```

1. Get the secret ID:

   ```bash
   yc lockbox secret list
   ```

   Command output:

   ```text
   +---------------------+----------------+------------+---------------------+----------------------+--------+
   |          ID         |      NAME      | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
   +---------------------+----------------+------------+---------------------+----------------------+--------+
   | <Lockbox secret ID> | lockbox-secret |            | 2021-09-19 04:33:44 | e6qlkguf0hs4q3i6jpen | ACTIVE |
   +---------------------+----------------+------------+---------------------+----------------------+--------+
   ```

1. To make sure that `eso-service-account` has access to the secret, assign it the `lockbox.payloadViewer` role:

   ```bash
   yc lockbox secret add-access-binding \
     --name lockbox-secret \
     --service-account-name eso-service-account \
     --role lockbox.payloadViewer
   ```

## Configure the {{ k8s }} cluster {#configure-k8s}

1. Create a [namespace](../managed-kubernetes/concepts/index.md#namespace) called `ns` to store External Secrets Operator objects in:

   ```bash
   kubectl create namespace ns
   ```

1. Create a `yc-auth` secret with the `eso-service-account` key:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=authorized-key.json
   ```

1. Create a [SecretStore](https://external-secrets.io/latest/api-secretstore/) that contains the `yc-auth` secret:

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

1. Create an object named [ExternalSecret](https://external-secrets.io/latest/api-externalsecret/) pointing to `lockbox-secret` in `secret-store`:

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
         key: <Lockbox secret ID>
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

   The command output will contain the value of the `password` key of `lockbox-secret`:

   ```text
   p@$$w0rd
   ```