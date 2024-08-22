

This scenario describes how to sign [Docker images](../../container-registry/concepts/docker-image.md) using [Cosign](https://docs.sigstore.dev/cosign/overview/) in [{{ container-registry-full-name }}](../../container-registry/) and then set up signature verification in [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

To sign Docker images and set up their verification:
1. [Sign a Docker image using Cosign](#cosign).
1. [Create a policy for signature verification](#kyverno).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create service accounts](../../iam/operations/sa/create.md):
      * [Service account](../../iam/concepts/users/service-accounts.md) for the resources with the [{{ roles-editor }}](../../iam/roles-reference.md#editor) [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) is being created. This service account will be used to create the resources required for the {{ managed-k8s-name }} cluster.
      * Service account for nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder with the Docker image [registry](../../container-registry/concepts/registry.md). Nodes will pull the required Docker images from the registry on behalf of this account.

      You can use the same service account for both operations.

   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When creating a cluster, specify the previously created service accounts for the resources and nodes as well as security groups.
   1. [Create a registry in {{ container-registry-name }}](../../container-registry/operations/registry/registry-create.md).

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [k8s-validate-cr-image.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cr-images-verification/blob/main/k8s-validate-cr-image.tf) configuration file to the same working directory.

      This file describes:
      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * {{ container-registry-name }} registry.
      * {{ managed-k8s-name }} cluster.
      * Service account required for the {{ managed-k8s-name }} cluster and node group to operate.
      * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

         {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. In the `k8s-validate-cr-image.tf` file, specify:
      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * {{ managed-k8s-name }} cluster CIDR.
      * Name of the cluster service account.
      * Name of the {{ container-registry-name }} registry.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Before you start working with the {{ managed-k8s-name }} cluster

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).

### Add multiple Docker images to the {{ container-registry-name }} registry {#add-docker-images}

1. [Configure](../../container-registry/operations/configure-docker.md) Docker and [get authenticated in {{ container-registry-name }}](../../container-registry/operations/authentication.md).
1. [Create multiple Docker images](../../container-registry/operations/docker-image/docker-image-create.md). One image will be signed using Cosign, while others will remain unsigned.
1. [Push Docker images](../../container-registry/operations/docker-image/docker-image-push.md) to the {{ container-registry-name }} registry.

## Sign a Docker image using Cosign {#cosign}

{% list tabs %}

- Image signature based on asymmetric keys {{ kms-full-name }}

   1. Install a special Cosign build for your OS:

      {% include [install-cosign](../../_includes/kms/install-cosign.md) %}

   1. Get an [{{ iam-full-name }} token](../../iam/concepts/authorization/iam-token.md) and save it to the `$YC_IAM_TOKEN` environment variable:
      * **Bash:**

         ```bash
         export YC_IAM_TOKEN=$(yc iam create-token)
         ```

      * **PowerShell:**

         ```powershell
         $env:YC_IAM_TOKEN = $(yc iam create-token)
         ```

   1. Log in to {{ container-registry-name }}:
      * **Bash:**

         ```bash
         docker login \
           --username iam \
           --password $YC_IAM_TOKEN \
           {{ registry }}
         ```

      * **PowerShell:**

         ```powershell
         docker login `
           --username iam `
           --password $Env:YC_IAM_TOKEN `
           {{ registry }}
         ```

      Result:

      ```text
      WARNING! Using --password via the CLI is insecure. Use --password-stdin.
      Login succeeded
      ```

      {% note info %}

      To avoid using a credential helper for authentication, edit the `${HOME}/.docker/config.json` configuration file to remove the `{{ registry }}` domain line under `credHelpers`.

      {% endnote %}

   1. Create a digital signature key pair and save it to {{ kms-name }}:

      ```bash
      cosign generate-key-pair \
        --kms yckms:///folder/<folder_ID>/keyname/<key_pair_name>
      ```

      Where:
      * `<folder_ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where the new key pair will be saved.
      * `<key_pair_name>`: Name of the signature key pair you create.

      Result:

      ```bash
      client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
      client.go:310: generated yckms KEY_ID: '<key_pair_ID>'
      Public key written to cosign.pub
      ```

      The utility will return the ID of the created signature key pair and save a public signature key to a local file. Save the key pair ID, you will need it in the next steps.

      You can always get the ID of your signature key pair in the [management console]({{ link-console-main }}) or using the appropriate [CLI](../../cli/cli-ref/managed-services/kms/asymmetric-signature-key/list.md) command.
   1. Sign the image in {{ container-registry-name }}:

      ```bash
      cosign sign \
        --key yckms:///<key_pair_ID> \
        {{ registry }}/<registry_ID>/<Docker_image_name>:<tag> \
        --tlog-upload=false
      ```

      Where:
      * `<key_pair_ID>`: ID of the signature key pair obtained in the previous step.
      * `<registry_id>`: [ID of the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-list.md#registry-list) in which the image you are signing is located.
      * `<Docker_image_name>`: Name of the [Docker image](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) you are signing in the {{ container-registry-name }} registry.
      * `<tag>`: Tag of the image version to be signed.

      Result:

      ```bash
      Pushing signature to: {{ registry }}/<registry_ID>/<Docker_image_name>
      ```

      A second object with the `sha256-....sig` tag and `{{ registry }}/<registry_ID>/<Docker_image_name>@sha256:...` hash should appear in the {{ container-registry-name }} registry.
   1. Check manually that the Docker image signature is correct:

      ```bash
      cosign verify \
        --key yckms:///<key_pair_ID> \
        {{ registry }}/<registry_ID>/<Docker_image_name>:<tag> \
        --insecure-ignore-tlog
      ```

      Where:
      * `<key_pair_ID>`: Previously obtained ID of the signature key pair.
      * `<registry_id>`: [ID of the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-list.md#registry-list) in which the image is located.
      * `<Docker_image_name>`: Name of the [Docker image](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) in the {{ container-registry-name }} registry.
      * `<tag>`: Tag of the image version to verify the signature for.

      Result:

      ```bash
      Verification for {{ registry }}/<registry_ID>/<Docker_image_name>:<tag> --
      The following checks were performed on each of these signatures:
      - The cosign claims were validated
      - The signatures were verified against the specified public key

      [{"critical":{"identity":{"docker-reference":"{{ registry }}/<registry_ID>/<Docker_image_name>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
      ```

- Image signature based on local keys

   1. [Install Cosign](https://docs.sigstore.dev/cosign/installation).
   1. Generate a key pair using Cosign:

      ```bash
      cosign generate-key-pair
      ```

      Set a private key's password and enter it twice.

      Result:

      ```bash
      Enter password for private key:
      Enter password for private key again:
      Private key written to cosign.key
      Public key written to cosign.pub
      ```

   1. Sign the Docker image in the {{ container-registry-name }} registry:

      ```bash
      cosign sign \
          --key cosign.key \
          {{ registry }}/<registry_ID>/<Docker_image_name>:<tag>
      ```

      The signed image will be used when [checking results](#check-result).

      Enter the password for the private key. Result:

      ```text
      Enter password for private key:
      Pushing signature to: {{ registry }}/<registry_ID>/<Docker_image_name>
      ```

      A second object with the `sha256-....sig` tag and `{{ registry }}/<registry_ID>/<Docker_image_name>@sha256:...` hash should appear in the {{ container-registry-name }} registry.
   1. Check manually that the Docker image signature is correct:

      ```bash
      cosign verify \
        --key cosign.pub \
        {{ registry }}/<registry_ID>/<Docker_image_name>:<tag>
      ```

      Result:

      ```text
      Verification for {{ registry }}/<registry_ID>/<Docker_image_name>:<tag> --
      The following checks were performed on each of these signatures:
      - The cosign claims were validated
      - The signatures were verified against the specified public key

      [{"critical":{"identity":{"docker-reference":"{{ registry }}/<registry_ID>/<Docker_image_name>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
      ```

{% endlist %}

## Create a policy for signature verification {#kyverno}

1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role and save it to the file:

   ```bash
   yc iam key create \
     --service-account-name=<service_account_name> \
     --output authorized-key.json
   ```

   Where `--service-account-name` is the name of the service account with the {{ roles-cr-puller }} role.
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
              - "{{ registry }}/<registry_ID>/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      <cosign.pub_contents>
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
              - "{{ registry }}/crpd2f2bnrlb********/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      -----BEGIN PUBLIC KEY-----
                      MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE1jTu/9rJZZvUFi4bGhlvgMQdIY97
                      7NuGl2zzpV7olAyIu/WiywxI7Fny5tk6JmNPIFvSAtys3c08gfEc********
                      -----END PUBLIC KEY-----
      ```

      {% endcut %}

      {% note info %}

      By default, when you create a policy, a signature verification request is made to the Transparency Log immutable record storage. You can disable it by adding the `rekor: ignoreTlog: true` parameter to the `keys` element of the policy specification. For more information, see the [Kyverno documentation](https://kyverno.io/docs/writing-policies/verify-images/sigstore/#ignoring-tlogs-and-sct-verification).

      {% endnote %}

   1. Run this command:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Result:

      ```text
      clusterpolicy.kyverno.io/check-image configured
      ```

1. {% include [install policy reporter](../../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Check the result {#check-result}

* Create a [pod](../../managed-kubernetes/concepts/index.md#pod) from the signed Docker image:

   ```bash
   kubectl run pod --image={{ registry }}/<registry_ID>/<Docker_image_name>:<tag>
   ```

   Result:

   ```text
   pod/pod created
   ```

* Create a pod from an unsigned Docker image:

   ```bash
   kubectl run pod2 --image={{ registry }}/<registry_ID>/<name_of_the_unsigned_Docker_image>:<tag>
   ```

   Result:

   ```text
   Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

   resource Pod/default/pod2 was blocked due to the following policies

   check-image:
     check-image:
       failed to verify signature for {{ registry }}/crpsere9njsa********/alpine:2.0: .attestors[0].entries[0].keys: no matching signatures:
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a public static IP address for the cluster, [delete it](../../vpc/operations/address-delete.md).
   1. [Delete the service accounts](../../iam/operations/sa/delete.md).
   1. [Delete all Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.
   1. [Delete the {{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).

- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):
   1. [Delete all Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) from the {{ container-registry-name }} registry.
   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `k8s-validate-cr-image.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-validate-cr-image.tf` configuration file will be deleted.

{% endlist %}
