---
title: Installing the {{ GL }} Agent
description: Follow this guide to install {{ GL }}.
---

# Installing the {{ GL }} Agent


The [{{ GL }} Agent](/marketplace/products/yc/gitlab-agent) is used to connect a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) to {{ GL }}. You can deploy the application in a [{{ mgl-full-name }}](../../../managed-gitlab/) [instance](../../../managed-gitlab/concepts/index.md#instance) or in a standalone {{ GL }} instance.

The {{ GL }} Agent enables you to:
* Work with {{ managed-k8s-name }} clusters behind NAT.
* Get real-time access to the {{ managed-k8s-name }} cluster API.
* Receive information about events in a {{ managed-k8s-name }} cluster.
* Activate the cache of {{ k8s }} objects, which are updated with very low latency.

{% note info %}

The {{ GL }} Agent does not execute CI/CD pipelines. To do this, install [{{ GL }} Runner](/marketplace/products/yc/gitlab-runner).

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Prepare for {{ GL }} Agent installation:

    1. [Create a {{ mgl-name }} instance](../../../managed-gitlab/operations/instance/instance-create.md) or a standalone instance.
    1. Create an agent configuration file in the repository:
       1. Open your [{{ GL }} instance](../../../managed-gitlab/concepts/index.md#instance) and go to your project.
       1. In the `main` branch, create a new folder named `.gitlab/agents/<{{ GL }}_agent_name>`.
       1. In the `<{{ GL }}_agent_name>` folder, create an empty file named `config.yaml`.
    1. Register the agent in {{ GL }} and get an access token:
       1. Open your {{ GL }} instance and go to your project.
       1. Select **Operate** on the left-hand panel, and then select **{{ k8s }} clusters** from the drop-down menu.
       1. Click **Connect a cluster** and select the agent name: `<{{ GL }}_agent_name>`.
       1. Click **Register**.
       1. {{ GL }} will create a token required to install the application. Store the token in a secure place.

    {% note info %}

    For more information about setting up and registering an agent, see the [{{ GL }} documentation](https://docs.gitlab.com/ee/user/clusters/agent/install/).

    {% endnote %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ GL }} Agent](/marketplace/products/yc/gitlab-agent) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `gitlab-agent-space`. If you leave the default namespace, {{ GL }} Agent may work incorrectly.
   * **Application name**: Specify the app name, e.g., `gitlab-agent`.
   * **{{ GL }} domain name**: Enter the name of your {{ GL }} domain, e.g., `gitlab-test.gitlab.yandexcloud.net`.
   * **Agent access token**: Paste the {{ GL }} access token you [received earlier](#before-you-begin) into this field.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application status to change to `Deployed`.
1. Open your {{ GL }} instance and go to **Infrastucture → {{ k8s }} clusters**. Make sure the agent status changed to `Connected`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the {{ GL }} Agent, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-agent.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gitlab-agent.helmChart.tag }} \
     --untar && \
   helm upgrade --install \
     --namespace <namespace> \
     --create-namespace \
     --set config.kasAddress='wss://<your_{{ GL }}_domain_name>/-/kubernetes-agent/' \
     --set config.token='<{{ GL }}_access_token>' \
     gitlab-agent ./gitlab-agent/
   ```

   This command also creates a new namespace required for the application.

   If you set `namespace` to the default namespace, {{ GL }} Agent may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `gitlab-agent-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Make sure the {{ GL }} Agent pod status changed to `Running`:

   ```bash
   kubectl get pods --namespace gitlab-agent
   ```

1. Open your {{ GL }} instance and go to **Infrastucture → {{ k8s }} clusters**. Make sure the agent status changed to `Connected`.

## Use cases {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).

## See also {#see-also}

* [{{ GL }} Agent documentation](https://docs.gitlab.com/ee/user/clusters/agent/).
* [{{ mgl-name }} documentation](../../../managed-gitlab/).
