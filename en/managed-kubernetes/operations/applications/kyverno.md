# Installing Kyverno & Kyverno Policies

[Kyverno](https://kyverno.io) is an application to manage {{ k8s }} security policies. Security policies appear in Kyverno as {{ k8s }} resources. Kyverno supports such tools as `kubectl`, `git`, and `kustomize`. You can use the Kyverno command line interface to test policies and validate resources as part of the CI/CD pipeline.

[Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) is a Kyverno extension. Kyverno policies includes an implementation of {{ k8s }} [Pod Security Standards (PSS)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). The original policies are stored in a separate [Kyverno-policies](https://github.com/kyverno/policies/tree/main/pod-security) repository.

You can send notifications from Kyverno to other systems using the [Policy reporter](/marketplace/products/yc/policy-reporter) extension.

{% note tip %}

To find vulnerabilities in {{ k8s }} clusters, use [Chaos Mesh](chaos-mesh.md). Vulnerability detection will help you configure security policies.

{% endnote %}

## Getting started {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Kyverno. Make sure it contains no applications or objects; otherwise, Kyverno will not run properly.
   * **Application name**: Specify the app name.
   * **Activating Kyverno Policies**: Select to install the Kyverno Policies extension.
   * **Pod Security Standard profile**: Select a [Pod Security Standard profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/):
      * `baseline`: Policy with minimum restrictions that prevents known privilege abuses.
      * `restricted`: Policy with severe restrictions in line with state-of-the-art pod security procedures.
      * `privileged`: Unrestricted policy granting maximum privilege.
   * **Validation failure action**: Select a response to Kyverno triggering:
      * `audit`: Notify.
      * `enforce`: Block.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Kyverno, run the following command:


   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_kyverno.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_kyverno.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     multi-kyverno ./multi-kyverno/
   ```


   Select a namespace that does not contain any applications or objects, or else Kyverno will not run properly.

## Application versions {#versions}

For each Kubernetes version, a certain Kyverno version is supported. The required Kyverno version is installed by default depending on your Kubernetes version.

|  Kubernetes version | Kyverno version |       Documentation      |
| ------------------- | --------------- | ------------------------ |
|     1.21 or older   |        1.6      | [Kyverno 1.6 documentation](https://release-1-6-0.kyverno.io/docs/) |
|         1.22        |        1.7      | [Kyverno 1.7 documentation](https://release-1-7-0.kyverno.io/docs/) |
|         1.23        |        1.8      | [Kyverno 1.8 documentation](https://release-1-8-0.kyverno.io/docs/) |
|    1.24 and higher  |        1.9      | [Kyverno 1.9 documentation](https://release-1-9-0.kyverno.io/docs/) |

## Deleting the application {#uninstall}

If you no longer need the Kyverno application, delete it:

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, in the [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) line, click {{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }} ![image](../../../_assets/marketplace/three_dots.png =22x13) and then click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.
   1. [Connect to the cluster](../connect/index.md#kubectl-connect) using kubectl.
   1. [Clear the application's webhook configurations](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), or else the cluster will not run properly.

- Helm {#helm}

   1. [Connect to the cluster](../connect/index.md#kubectl-connect) using kubectl.
   1. Delete the application:

      ```bash
      helm uninstall --namespace <namespace> multi-kyverno ./multi-kyverno/
      ```

   1. [Clear the application's webhook configurations](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), or else the cluster will not run properly.

{% endlist %}

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/kyverno.md)

## See also {#see-also}

* [Kyverno documentation](https://kyverno.io/docs/).
