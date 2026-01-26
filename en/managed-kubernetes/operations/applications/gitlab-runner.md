---
title: Installing {{ GLR }}
description: Follow this guide to install {{ GLR }}.
---

# Installing {{ GLR }}


[{{ GLR }}](https://docs.gitlab.com/runner/) is an open-source application that runs {{ GL }} CI/CD jobs using instructions in a special file named `.gitlab-ci.yml`. It helps run automated builds in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

## Getting started {#before-you-begin}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Open the {{ GL }} administration panel in your browser:
   * If {{ GL }} is deployed on a [{{ compute-full-name }}](../../../compute/) [VM instance](../../../compute/concepts/vm.md), use its [public IP address](../../../compute/concepts/network.md#public-ip).
   * If {{ GL }} is deployed in [{{ mgl-full-name }}](../../../managed-gitlab/), use the [instance FQDN](../../../compute/concepts/network.md##hostname).
1. Get the {{ GLR }} authentication token:
   * To configure {{ GLR }} for the entire [{{ GL }} instance](../../../managed-gitlab/concepts/index.md#instance) ({{ GL }} admin permissions required):
     1. Click **Admin area** and select **CI/CD** → **Runners**.
     1. Click **New instance runner** and create a new {{ GLR }}.
     1. Save the value of the `Runner authentication token` parameter.
   * To configure {{ GLR }} for a group or project:
     1. Select a group or project you want to configure.
     1. On the left-hand side of the window that opens, click **Settings** and select **CI/CD**.
     1. Under **Runners**, click **Expand**.
     1. Click **New project runner** and create a new {{ GLR }}.
     1. Save the value of the `Runner authentication token` parameter.

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [{{ GLR }}](/marketplace/products/yc/gitlab-runner) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `gitlab-runner-space`. If you leave the default namespace, {{ GLR }} may work incorrectly.
   * **Application name**: Specify the application name.
   * **{{ GL }}** domain name: Enter a domain for your {{ GL }} instance.
   * **Registration token**: Specify the token you [obtained previously](#before-you-begin).
   * **Privileged mode for running docker:dind**: This is an optional setting. Enable it if you want to use `docker:dind` images.

        {% note warning %}

        The privileged mode increases the risk of information security incidents. Check out [this article](https://docs.gitlab.com/runner/executors/kubernetes.html#using-dockerdind) before using it.

        {% endnote %}

    * **List of comma-separated tags**: This is an optional setting. Provide a list of tags to distribute jobs between multiple {{ GLR }}s.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.
1. Go back to the **Runners** page of your {{ GL }} instance, refresh the page, and make sure you see a new {{ GLR }}.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubect installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with {{ GLR }}, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-runner.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gitlab-runner.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set gitlabDomain=<VM_public_IP_address_or_{{ GL }}_instance_FQDN> \
     --set runnerRegistrationToken=<previously_obtained_token> \
     gitlab-runner ./gitlab-runner/
   ```

   If you set `namespace` to the default namespace, {{ GLR }} may work incorrectly. We recommend specifying a value different from all the existing namespaces, e.g., `gitlab-runner-space`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).
* [{#T}](../../tutorials/cr-scanner-with-k8s-and-gitlab.md).
* [{#T}](../../../managed-gitlab/tutorials/image-storage.md).

## See also {#see-also}

* [{{ mgl-name }} documentation](../../../managed-gitlab/)
* [{{ GL }} documentation](https://docs.gitlab.com/)
* [Documentation for {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/)
* [Reference guide on .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html)
