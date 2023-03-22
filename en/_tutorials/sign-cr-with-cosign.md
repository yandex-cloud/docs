This tutorial describes how to sign [Docker images](../container-registry/concepts/docker-image.md) using [Cosign](https://docs.sigstore.dev/cosign/overview/) in {{ container-registry-full-name }} and then set up signature verification in {{ managed-k8s-full-name }}.

To sign Docker images and set up their verification:
1. [Sign a Docker image using Cosign](#cosign).
1. [Create a policy for signature verification](#kyverno).
1. [Check the results](#check-result).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. [Create service accounts](../iam/operations/sa/create.md):
      * A [service account](../iam/concepts/users/service-accounts.md) for the resources with the [[{{ roles-editor }}](../resource-manager/security/index.md#roles-list) role](../iam/concepts/access-control/roles.md) to the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ managed-k8s-name }} cluster](../managed-kubernetes/concepts/index.md#kubernetes-cluster) is being created. The resources that the {{ managed-k8s-name }} cluster needs will be created on behalf of this account.
      * A service account for nodes with the [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) role to the folder with the Docker image [registry](../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

      You can use the same service account for both operations.
   1. [Create a {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../managed-kubernetes/operations/node-group/node-group-create.md). When creating the cluster, specify the previously created service accounts for the resources and nodes.
   1. [Create a registry in {{ container-registry-name }}](../container-registry/operations/registry/registry-create.md).

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [k8s-validate-cr-image.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/k8s-validate-cr-image.tf) configuration file to the same working directory.

      This file describes:
      * [Network](../vpc/concepts/network.md#network).
      * [Subnet](../vpc/concepts/network.md#subnet).
      * [Security group and rules](../managed-kubernetes/operations/connect/security-groups.md) needed to run the {{ managed-k8s-name }} cluster:
         * Rules for service traffic.
         * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
      * {{ managed-k8s-name }} cluster.
      * Service account required to use the {{ managed-k8s-name }} cluster and node group.
      * {{ container-registry-name }} registry.
   1. In the `k8s-validate-cr-image.tf` file, specify:
      * [Folder ID](../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * {{ managed-k8s-name }} cluster CIDR.
      * Name of the cluster service account.
      * Name of the {{ container-registry-name }} registry.
   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.
   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Before you start working with the {{ managed-k8s-name }} cluster

1. {% include [install-kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).

### Add multiple Docker images to the {{ container-registry-name }} registry {#add-docker-images}

1. [Authenticate in {{ container-registry-name }}](../container-registry/operations/authentication.md).
1. [Create multiple Docker images](../container-registry/operations/docker-image/docker-image-create.md). One image will be signed using Cosign, while others will remain unsigned.
1. [Push Docker images](../container-registry/operations/docker-image/docker-image-push.md) to the {{ container-registry-name }} registry.

## Sign a Docker image using Cosign {#cosign}

1. [Install Cosign](https://docs.sigstore.dev/cosign/installation).
1. Generate a key pair using Cosign:

   ```bash
   cosign generate-key-pair
   ```

   Set a private key's password and enter it twice.

   Result:

   ```text
   Enter password for private key:
   Enter password for private key again:
   Private key written to cosign.key
   Public key written to cosign.pub
   ```

1. Sign the Docker image in the {{ container-registry-name }} registry:

   ```bash
   cosign sign --key cosign.key {{ registry }}/<registry ID>/<Docker image name>:<tag>
   ```

   The signed image will be used when [checking results](#check-result).

   Enter the password for the private key. Result:

   ```text
   Enter password for private key:
   Pushing signature to: {{ registry }}/<registry ID>/<Docker image name>
   ```

   A second object with the `sha256-....sig` tag and the `{{ registry }}/<registry ID>/<Docker image name>@sha256:...` hash should appear in the {{ container-registry-name }} registry.
1. Check that the signature is valid manually:

   ```bash
   cosign verify --key cosign.pub {{ registry }}/<registry ID>/<Docker image name>:<tag>
   ```

   Result:

   ```text
   Verification for {{ registry }}/<registry ID>/<Docker image name>:<tag> --
   The following checks were performed on each of these signatures:
   - The cosign claims were validated
   - The signatures were verified against the specified public key

   [{"critical":{"identity":{"docker-reference":"{{ registry }}/<registry ID>/<Docker image name>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
   ```

## Create a policy for signature verification {#kyverno}

1. Create an [authorized key](../iam/concepts/authorization/key.md) for the service account with the [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) role and save it to the file:

   ```bash
   yc iam key create \
     --service-account-name=<name of the service account with the {{ roles-cr-puller }} role> \
     --output=authorized-key.json
   ```

1. Install the [Kyverno](https://kyverno.io/docs/) app to the {{ managed-k8s-name }} cluster. You need it to create a policy for verifying Docker image signatures.
   1. Add the `kyverno` repository:

      ```bash
      helm repo add kyverno https://kyverno.github.io/kyverno/
      ```

      Result:

      ```text
      "kyverno" has been added to your repositories
      ```

   1. Install the Kyverno app to the `kyverno` namespace:

      ```bash
      helm install kyverno kyverno/kyverno \
        --namespace kyverno \
        --create-namespace \
        --set replicaCount=1 \
        --set imagePullSecrets.regcred.registry={{ registry }} \
        --set imagePullSecrets.regcred.username=json_key \
        --set-file imagePullSecrets.regcred.password=./authorized-key.json
      ```

      Result:

      ```text
      NAME: kyverno
      LAST DEPLOYED: Thu Sep 8 10:43:00 2022
      NAMESPACE: kyverno
      STATUS: deployed
      ...
      ```

1. Create a policy:
   1. Save the specification for `ClusterPolicy` creation in a YAML file named `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: check-image
      spec:
        validationFailureAction: enforce
        background: false
        webhookTimeoutSeconds: 30
        failurePolicy: Fail
        rules:
          - name: check-image
            match:
              any:
              - resources:
                  kinds:
                    - Pod
            verifyImages:
            - imageReferences:
              - "{{ registry }}/<registry ID>/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      <cosign.pub contents>
      ```

      {% cut "Sample filled out policy.yaml file" %}

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: check-image
      spec:
        validationFailureAction: enforce
        background: false
        webhookTimeoutSeconds: 30
        failurePolicy: Fail
        rules:
          - name: check-image
            match:
              any:
              - resources:
                  kinds:
                    - Pod
            verifyImages:
            - imageReferences:
              - "{{ registry }}/crpd2f2bnrlb2i7ltssl/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      -----BEGIN PUBLIC KEY-----
                      MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE1jTu/9rJZZvUFi4bGhlvgMQdIY97
                      7NuGl2zzpV7olAyIu/WiywxI7Fny5tk6JmNPIFvSAtys3c08gfEcVV3D1Q==
                      -----END PUBLIC KEY-----
      ```

      {% endcut %}

   1. Run the command:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Result:

      ```text
      clusterpolicy.kyverno.io/check-image configured
      ```

## Check the results {#check-result}

* Create a [pod](../managed-kubernetes/concepts/index.md#pod) from the signed Docker image:

   ```bash
   kubectl run pod --image={{ registry }}/<registry ID>/<Docker image name>:<tag>
   ```

   Result:

   ```text
   pod/pod created
   ```

* Create a pod from an unsigned Docker image:

   ```bash
   kubectl run pod2 --image={{ registry }}/<registry ID>/<name of the unsigned Docker image>:<tag>
   ```

   Result:

   ```text
   Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

   resource Pod/default/pod2 was blocked due to the following policies

   check-image:
     check-image:
       failed to verify signature for {{ registry }}/crpsere9njsadcq6fgm2/alpine:2.0: .attestors[0].entries[0].keys: no matching signatures:
   ```

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete them:
   1. [Delete the {{ managed-k8s-name }} cluster](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a public static IP address for the cluster, [delete it](../vpc/operations/address-delete.md).
   1. [Delete the service accounts](../iam/operations/sa/delete.md).
   1. [Delete all the Docker images](../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.
   1. [Delete the {{ container-registry-name }} registry](../container-registry/operations/registry/registry-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):
   1. [Delete all the Docker images](../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.
   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `k8s-validate-cr-image.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.
   1. Confirm the update of resources.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-validate-cr-image.tf` configuration file will be deleted.

{% endlist %}
