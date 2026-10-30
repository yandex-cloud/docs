# Verifying signatures for custom images

You can sign your apps' images and restrict the cluster from running images without a valid signature. When creating a pod, the [Policy Manager](../concepts/components/policy-manager.md) component based on [Kyverno](https://kyverno.io/) verifies the signature. The [Cosign](https://docs.sigstore.dev/) utility creates signatures.

In this guide, you will create a pair of keys, sign you image, apply a policy, and ensure the inability to run an unsigned image.

{% note warning %}

This guide applies **only to your custom images**. {{ stackland-name }} images use another mechanism: a cluster node checks their integrity when the image is loaded using a dedicated platform key. Your key, policy, and secret for registry access do not affect the platform check of images, and the platform key is never applied to your images.

Do not add {{ stackland-name }} images to your policy: platform namespaces are excluded from the check, so such a rule will not work.

{% endnote %}

## Getting started {#before-begin}

1. Install [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) version 3 or newer and [crane](https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md).

    Commands in this guide were tested with Cosign v3.1.3.

1. Make sure you have write permissions for the registry with your images: the signature is saved to the same repository as the image.

1. Make sure the registry is accessible from the cluster. Kyverno inside the cluster verifies the signature, so it accesses the registry on its own, regardless of how the node loads the image.

1. Make sure that Policy Manager is enabled:

    ```bash
    kubectl get policymanagerconfig main -o jsonpath='{.spec.enabled}'
    ```

    If the command returns `false`, enable the component (see [Activating a policy preset](../operations/policy-manager/apply-preset.md)).

## How it works {#how-it-works}

Cosign saves the signature next to the image: as a separate tag in `sha256-<digest>.sig` format in the same repository. When a pod is created in the cluster, Kyverno intercepts the request, downloads the signature from the registry, and verifies it using your public key. If the signature is missing or mismatches the key, the pod is not created.

The verification uses the image digest, not the tag. Therefore, you need to sign the image using the digest as well: it is possible to overwrite a tag, but not a digest.

## Step 1: Generate a key pair {#create-keys}

1. Set a password for the private key and create a pair:

    ```bash
    export COSIGN_PASSWORD='<private key password>'
    cosign generate-key-pair
    ```

    As a result, you will have two files:

    * `cosign.key`: Private key you sign images with.
    * `cosign.pub`: Public key Kyverno verifies signatures with.

{% note warning %}

`cosign.key` allows signing images on your behalf. Store it in the secret management system or in CI secrets. Never put it into a repository with code and do not create a `ConfigMap` out of it. Only the contents of `cosign.pub` end up in the Kyverno policy.

{% endnote %}

## Step 2: Sign the image {#sign-image}

1. Get the image digest:

    ```bash
    IMAGE_REPOSITORY='<registry address>/<image path>'
    IMAGE_TAG='<tag>'
    DIGEST=$(crane digest "${IMAGE_REPOSITORY}:${IMAGE_TAG}")
    IMAGE="${IMAGE_REPOSITORY}@${DIGEST}"
    ```

1. Sign the image:

    ```bash
    cosign sign --yes \
      --key cosign.key \
      --use-signing-config=false \
      --new-bundle-format=false \
      --tlog-upload=false \
      "$IMAGE"
    ```

    The flags serve the following purposes:

    * `--tlog-upload=false`: Not to send a record to an external Rekor log.
    * `--use-signing-config=false`: Not to use a configuration of Sigstore services. Without this flag, Cosign version 3 forbids `--tlog-upload=false`.
    * `--new-bundle-format=false`: To store the signature as a separate tag in `sha256-<digest>.sig` format. By default, Cosign version 3 publishes the signature as an OCI 1.1 artifact, which Kyverno of this version cannot read, and rejects some registries.

    Cosign will show warnings that `--new-bundle-format` and `--tlog-upload` are declared obsolete. This is expectable: both flags are required as long as Kyverno keeps working with the previous signature format.

1. Make sure the signature appears in the registry:

    ```bash
    crane ls "$IMAGE_REPOSITORY" | grep '^sha256-'
    ```

    The output should contain the `sha256-<digest>.sig` tag, with `<digest>` matching the signed image's digest.

## Step 3: Verify the signature locally {#verify-local}

Verify the signature before configuring the policy: this way, you can separate the signature error from the policy error:

```bash
cosign verify --key cosign.pub --insecure-ignore-tlog "$IMAGE"
```

For a signed image, the command will show the verification result, while for an unsigned one, the `no signatures found` error.

## Step 4: Grant Kyverno access to the registry {#registry-credentials}

If your registry requires authentication, create a secret with credentials:

{% include notitle [comand](../_includes/yamls/tutorials/verify-own-image-signatures/registry-secret.md) %}

{% note info %}

The secret must remain exactly in the `stackland-policy-manager` namespace, as Kyverno reads credentials from this exact location. This is not the same as `imagePullSecrets` of your pod: the node and Kyverno access the registry independently and use different credentials.

If you use short-lived tokens, update the secret before they expire: Kyverno will not be able to get a signature with an expired token.

{% endnote %}

## Step 5: Apply the policy {#apply-policy}

The manifest below uses report safe mode: `failureAction: Audit`, `mutateDigest: false`, and `webhookConfiguration.failurePolicy: Ignore`. Once applied, the policy registers violations, but does not block pod creation. You will enable the blocking gradually after verifying the policy and registry access.

1. Create the `ClusterPolicy` resource file, e.g., using the `touch clusterpolicy.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../_includes/yamls/tutorials/verify-own-image-signatures/clusterpolicy.md) %}

1. Provide the following in the parameter:

    * `spec.rules[0].verifyImages[0].imageReferences`: Paths to your images.
    * `spec.rules[0].verifyImages[0].imageRegistryCredentials.secrets`: Secret name from Step 4. If the registry does not require authentication, delete the `imageRegistryCredentials` section.
    * `spec.rules[0].verifyImages[0].attestors[0].entries[0].keys.publicKeys`: Contents of the `cosign.pub` file.

    By default, the policy verifies images in all namespaces of all projects, except for the platform namespaces. The `exclude` section with the `stackland.yandex.cloud/project-name: stackland` label excludes the platform namespaces regardless of their names.

    To check images only in namespaces within the same projects, uncomment the `namespaceSelector` section under `match` and specify the project name:

    ```yaml
    match:
      any:
      - resources:
          kinds:
          - Pod
          namespaceSelector:
            matchLabels:
              stackland.yandex.cloud/project-name: <project name>
    ```

1. Apply the policy in report mode:

    ```bash
    kubectl apply -f clusterpolicy.yaml
    ```

1. Make sure the policy is ready:

    ```bash
    kubectl get clusterpolicy verify-my-images -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}'
    ```

    Expected result: `True`.

{% note alert %}

Do not specify `*` in `imageReferences`. With the `required: true` setting, the policy will require all images to have a signature, including service and external ones, and creation of pods will stop. List only the paths images at which you sign yourself.

{% endnote %}

## Enabling blocking gradually {#staged-rollout}

The policy is already active in report safe mode. Before enabling blocking, make sure it covers only the relevant images and successfully accesses the registry.

1. Make sure there are no unexpected violations under **System > Events** in the management console. At the same time, enable blocking of unsigned images and replacement of tags with a digest. Registry access errors will remain unblocking for now:

    ```bash
    kubectl patch clusterpolicy verify-my-images --type=json --patch='[
      {
        "op": "replace",
        "path": "/spec/rules/0/verifyImages/0/failureAction",
        "value": "Enforce"
      },
      {
        "op": "replace",
        "path": "/spec/rules/0/verifyImages/0/mutateDigest",
        "value": true
      }
    ]'
    ```

1. Make sure that attempts to access the registry are stable and enable blocking in case of verification errors:

    ```bash
    kubectl patch clusterpolicy verify-my-images --type=json --patch='[
      {
        "op": "replace",
        "path": "/spec/webhookConfiguration/failurePolicy",
        "value": "Fail"
      }
    ]'
    ```

    The policy will switch to the final mode, `Enforce`, and then to `Fail`.

## Step 6: Test the policy {#check-policy}

In the commands below, `<namespace name>` is the name of a specific namespace from the policy scope, e.g., `team-alpha-backend`.

1. Run a pod with a signed image:

    ```bash
    kubectl run test-signed -n <namespace name> --restart=Never \
      --image=<registry address>/<image path>:<tag>
    ```

    This will create a pod. Make sure that Kyverno has replaced the tag with the digest and marked the verification with an annotation:

    ```bash
    kubectl get pod test-signed -n <namespace name> \
      -o jsonpath='{.spec.containers[0].image}{"\n"}{.metadata.annotations.kyverno\.io/verify-images}{"\n"}'
    ```

    Here is an example of the command output:

    ```text
    registry.example.com/myteam/app:1.0.0@sha256:7c38f24774e3cbd906d2d33c38354ccf787635581c122965132c9bd309754d4a
    {"registry.example.com/myteam/app@sha256:7c38f24774e3cbd906d2d33c38354ccf787635581c122965132c9bd309754d4a":"pass"}
    ```

1. Run a pod with an unsinged image:

    ```bash
    kubectl run test-unsigned -n <namespace name> --restart=Never \
      --image=<registry address>/<image path>:<unsigned image tag>
    ```

    This will not create a pod.

    ```text
    Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

    resource Pod/<namespace name>/test-unsigned was blocked due to the following policies

    verify-my-images:
      verify-signature: 'failed to verify image registry.example.com/myteam/app:unsigned:
        .attestors[0].entries[0].keys: no signatures found'
    ```

1. Delete the test pod.

    ```bash
    kubectl delete pod test-signed -n <namespace name>
    ```

## Limitations {#limitations}

* **Registry becomes a dependency when creating pods**. In `failurePolicy: Fail` mode, registry unavailability and expired credentials stop the creation of pods with images covered by the policy. The verification cache and narrow list of `imageReferences` limit the effects, but do not eliminate them.
* **The policy is deleted together with the component**. If you disable Policy Manager (`PolicyManagerConfig.spec.enabled: false`), the policy and the secret with registry credentials will be deleted. To re-enable it, recreate them.
