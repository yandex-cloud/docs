# Installing {{ GLR }}

[{{ GLR }}](https://docs.gitlab.com/runner/) is an open-source application that runs {{ GL }} CI/CD jobs in a pipeline using instructions from a special file named `.gitlab-ci.yml`. It helps run automated builds in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

## Before you begin {#before-you-begin}

Obtain a registration token:
* To configure {{ GLR }} for the entire [{{ GL }} instance](../../../managed-gitlab/concepts/index.md) ({{ GL }} administrator access required):
  1. In your browser, open the {{ GL }} administrator panel using the instance [FQDN](../../../compute/concepts/network.md#hostname).
  1. Click **Menu** and select the **Admin** option.
  1. Select the **Runners** section.
  1. Click **Register an instance runner** and save the value of the `registration token` parameter.
* To configure {{ GLR }} for a group or a project:
  1. In your browser, open the {{ GL }} administrator panel using the instance FQDN.
  1. Select the desired group or project.
  1. On the left-hand side of the resulting window, click **Settings** and select the **CI/CD** option.
  1. Under **Runners**, click **Expand**.
  1. Save the value of the `registration token` parameter.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired {{ k8s }} cluster and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [{{ GLR }}](/marketplace/products/yc/gitlab-runner) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for {{ GLR }}.
   * **Application name**: Enter an application name.
   * **{{ GL }} domain name**: Enter a domain for your {{ GL }} instance.
   * **Registration token**: Specify the [previously retrieved](#before-you-begin) registration token.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm installation](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. {% include [kubect installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with {{ GLR }}, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gitlab-org/gitlab-runner/chart/gitlab-runner \
     --version 0.43.1-34 \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set gitlabUrl=<VM public IP or Managed Service for GitLab instance FQDN> \
     --set runnerRegistrationToken=<previously retrieved registration token> \
     gitlab-runner ./gitlab-runner
   ```

## See also {#see-also}

[{{ mgl-full-name }} documentation](../../../managed-gitlab/).
[{{ GL }} documentation](https://docs.gitlab.com/).
[Documentation for {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
[Reference guide on .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).