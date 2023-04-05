# Installing Falco

[The Falco Project](https://falco.org/) is intended to secure the operation of Linux-based operating systems.

The Falco application:
* Parses Linux kernel system calls at runtime.
* Analyzes signals using a configurable set of rules.
* Sends an alert if the rules are violated.

{% note warning %}

To use Falco, install [Kyverno](/marketplace/products/yc/kyverno) or another product that supports writing results to [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Falco](/marketplace/products/yc/falco) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Falco.
   * **Application name**: Enter an application name.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Falco, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/falco \
     --version <Helm chart version> \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     falco ./falco
   ```

   You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/falco).

## See also {#see-also}

* [Falco documentation](https://falco.org/docs/).