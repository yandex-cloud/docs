# Installing {{ GLR }}

[{{ GLR }}](https://docs.gitlab.com/runner/) is an open-source application that runs {{ GL }} CI/CD jobs in a pipeline using instructions from a special file named `.gitlab-ci.yml`. It helps run automated builds in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

## Getting started {#before-you-begin}

1. Open the {{ GL }} administration panel in the browser:
   * If {{ GL }} is deployed on a [{{ compute-full-name }}](../../../compute/) [instance](../../../compute/concepts/vm.md), use its [public IP](../../../compute/concepts/network.md#public-ip).
   * If {{ GL }} is deployed in [{{ mgl-full-name }}](../../../managed-gitlab/), use the [instance FQDN](../../../compute/concepts/network.md##hostname).
1. Obtain a registration token:
   * To configure {{ GLR }} throughout the [{{ GL }} instance](../../../managed-gitlab/concepts/index.md) ({{ GL }} administrator access required):
     1. Click **Menu** and select the **Admin** option.
     1. Choose **CI/CD** → **Runners**.
     1. Click **Register an instance runner** and save the value of the `Registration token` parameter.
   * To configure {{ GLR }} for a group or a project:
     1. Select the group or project you need.
     1. On the left-hand side of the window that opens, click **Settings** and select the **CI/CD** option.
     1. Under **Runners**, click **Expand**.
     1. Save the value of the `Registration token` parameter.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the {{ managed-k8s-name }} cluster name and select the ![image](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [{{ GLR }}](/marketplace/products/yc/gitlab-runner) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for {{ GLR }}.
   * **Application name**: Enter a name for the application.
   * **{{ GL }} domain name**: Enter a domain for your {{ GL }} instance.
   * **Registration token**: Specify the [previously retrieved](#before-you-begin) registration token.
   * (Optional) **Privileged mode for running docker:dind**: Enable this option if you want to use docker:dind images.

      {% note warning %}

      The privileged mode increases the risk of information security incidents. Please read the [documentation](https://docs.gitlab.com/runner/executors/kubernetes.html#using-dockerdind) before using it.

      {% endnote %}

   * (Optional) **List of tags**: Provide a list of tags for task distribution across multiple GitLab Runners.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.
1. Go back to the Runners page of your {{ GL }} instance, reload the page, and make sure you see a new {{ GLR }}.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubect installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with {{ GLR }}, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-runner.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gitlab-runner.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set gitlabDomain=<VM_public_IP_or_Yandex_Managed_Service_for_GitLab_instance_FQDN> \
     --set runnerToken=<previously_retrieved_registration_token> \
     gitlab-runner ./gitlab-runner/
   ```

## Use cases {#examples}

* [{#T}](../../tutorials/gitlab-containers.md)
* [{#T}](../../tutorials/cr-scanner-with-k8s-and-gitlab.md)
* [{#T}](../../../managed-gitlab/tutorials/image-storage.md)

## See also {#see-also}

* [{{ mgl-name }} documentation](../../../managed-gitlab/).
* [{{ GL }} documentation](https://docs.gitlab.com/).
* [Documentation for {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
* [Reference guide on .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).
