# Installing Gatekeeper

[Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/) is a customizable [policy](../../concepts/network-policy.md) controller and auditor for {{ k8s }}. Gatekeeper accepts incoming requests to clusters and validates them in real time to make sure they comply with predefined policies.

## Getting started {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.

1. Click the name of the cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.

1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Gatekeeper](https://yandex.cloud/ru/marketplace/products/yc/gatekeeper) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.

1. Configure the application:
    * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `gatekeeper-space`. If you leave the default namespace, Gatekeeper may work incorrectly.
    * **Application name**: Specify the application name.
    * **Audit interval**: Set the interval between audits in seconds. `0` disables audits.
    * **Constraint violations limit**: Set the maximum number of violations to be logged for each constraint.
    * **Only matching resource types**: Select this option if you need to validate only those {{ k8s }} resource types for each constraint that are explicitly specified in the constraint. If no resource types are specified or the option is disabled, all resources will be validated.
    * **Create events at audit**: Select this option to create a Kubernetes event for each constraint violation detected during the audit, with detailed information about the violation.
    * **Events in affected namespace**: Select this option if events with violation details should be created in the namespace in which a constraint violation was logged. Only applies if the **Create events at audit** option is enabled.
    
      If the **Events in affected namespace** option is disabled, events will be created in the namespace in which Gatekeeper is installed.

    * **Allow external data**: Select this option to enable experimental support of external data sources.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Gatekeeper, run the following command:
  
    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_gatekeeper.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_gatekeeper.helmChart.tag }} \
      --untar && \
    helm install \
      --namespace <namespace> \
      --create-namespace \
      gatekeeper ./gatekeeper/
    ```

  If you set `namespace` to the default namespace, Gatekeeper may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `gatekeeper-space`).

  You can redefine optional parameters in the install command using the following key: `--set <parameter_name>=<new_value>`.

  See the table below for a list of redefinable parameters and their default values:

  Parameter name | Description | Default value
  --- | --- | ---
  `auditInterval` | Interval between audits in seconds | `60`
  `constraintViolationsLimit` | Maximum number of violations to be logged for each constraint | `20`
  `auditMatchKindOnly` | Only matching resource types | `false`
  `emitAuditEvents` | Creating events during audit | `false`
  `auditEventsInvolvedNamespace` | Creating events in the affected namespace | `false`
  `enableExternalData` | Experimental support of external data sources | `true`

## See also {#see-also}

* [Gatekeeper documentation](https://open-policy-agent.github.io/gatekeeper/website/docs/)

* [Library of Gatekeeper policies](https://open-policy-agent.github.io/gatekeeper-library/website/)

