# Installing Kyverno & Kyverno Policies

[Kyverno](https://kyverno.io) is an application to manage {{ k8s }} security policies. Security policies appear in Kyverno as {{ k8s }} resources. Kyverno supports such tools as `kubectl`, `git`, and `kustomize`. You can use the Kyverno command-line interface to test policies and validate resources as part of the {% if lang == "ru" %}[CI/CD](/blog/posts/2022/10/ci-cd){% else %}CI/CD{% endif %} pipeline.

[Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) is a Kyverno extension. Kyverno policies includes an implementation of {{ k8s }} [Pod Security Standards (PSS)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). The original policies are stored in a separate [Kyverno-policies](https://github.com/kyverno/policies/tree/main/pod-security) repository.

You can send notifications from Kyverno to other systems using the [Policy reporter](/marketplace/products/yc/policy-reporter) extension.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Kyverno.
   * **Application name**: Enter an application name.
   * **Activating Kyverno Policies**: Select to install the Kyverno Policies extension.
   * **Pod Security Standard profile**: Select a [Pod Security Standard profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/):
     * `baseline`: Policy with minimum restrictions that prevents known privilege abuses.
     * `restricted`: Policy with severe restrictions in line with state-of-the-art pod security procedures.
     * `privileged`: Unrestricted policy granting maximum privilege.
   * **Validation failure action**: Select a response to Kyverno triggering:
     * `audit`: Notify.
     * `enforce`: Block.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Kyverno, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/marketplace/charts/kyverno \
     --version 2.3.2 \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     kyverno kyverno/kyverno
   ```

## See also {#see-also}

* [Kyverno documentation](https://kyverno.io/docs/).