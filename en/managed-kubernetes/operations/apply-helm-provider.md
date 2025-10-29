---
title: Installing applications from {{ marketplace-full-name }} using {{ TF }}
description: Follow this guide to enable the Helm {{ TF }} provider and install applications from {{ marketplace-name }} using {{ TF }} manifests.
---

# Installing applications from {{ marketplace-full-name }} using {{ TF }}

With the [Helm {{ TF }} provider](https://github.com/hashicorp/terraform-provider-helm), you can install apps from [{{ marketplace-name }}](/marketplace), as well as any other Helm charts, in your {{ managed-k8s-full-name }} cluster using {{ TF }} manifests.

For more information about the provider resources, see the relevant provider reference on the [{{ TF }} website](https://registry.terraform.io/providers/hashicorp/helm/latest/docs).

## Getting started {#before-you-begin}

1. [Create](kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster using any method of your choice.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Activating the provider {#configure-provider}

1. In a separate directory, create a file named `provider.tf` with the Helm provider settings:

    ```hcl
    terraform {
      required_providers {
        helm = {
          source  = "hashicorp/helm"
          version = "~> 2.13"
        }
      }
      required_version = ">= 1.4.0"
    }

    provider "helm" {
      kubernetes {
        config_path = "~/.kube/config"
        config_context = "<context_name>"
      }
    }
    ```

    You can get a list of all contexts by running the `kubectl config get-contexts` command; to find out the current context, run `kubectl config current-context`.

1. Initialize the Helm provider:

   ```bash
   terraform init
   ```

## Installing applications with {{ TF }} {#install-app}

To install applications, use the [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) {{ TF }} resource.

Below we give an example of installing the [{{ GLR }}](/marketplace/products/yc/gitlab-runner) application.

1. In the directory housing the `provider.tf` file, create a file named `gitlab-runner.tf`:

    ```hcl
    resource "helm_release" "gitlab_runner" {
      name             = "gitlab-runner"
      chart            = "oci://{{ registry }}/yc-marketplace/yandex-cloud/gitlab-org/gitlab-runner/chart/gitlab-runner"
      version          = "0.54.0-8"
      namespace        = "gitlab-runner"
      create_namespace = true


      values = [yamlencode({
        gitlabDomain            = "https://***.gitlab.yandexcloud.net"
        runnerRegistrationToken = "<registration_token>"

        replicas     = 2
        nodeSelector = { nodepool = "runners" }
        resources = {
          requests = { cpu = "200m", memory = "256Mi" }
          limits   = { cpu = "500m", memory = "512Mi" }
        }
      })]
    }
    ```

    Where:

    * `name`: Application name.
    * `chart`: Link to the Helm chart.
    * `version`: Application version.
    * `namespace`: New namespace to install your application in. If you specify the default namespace, {{ GLR }} may work incorrectly.
    * `values`: Parameters from the `values.yaml` Helm chart configuration file:

      * `gitlabDomain`: {{ GL }} instance domain.
      * `runnerRegistrationToken`: Registration token. [Learn more about obtaining a token](applications/gitlab-runner.md#before-you-begin).
      * `replicas`: Number of application pods.
      * `nodeSelector`: Assigning pods to nodes with the `nodepool = "runners"` label.
      * `resources`: Minimum and maximum amount of resources to allocate to the application.

    To request a list of all parameters from `values.yaml`, run this command:

    ```bash
    helm show values <Helm_chart_link> --version <application_version>
    ```

1. Install the application:

   {% include [terraform-apply-short](../../_includes/mdb/terraform/apply-short.md) %}

{% note tip %}

To install applications from {{ marketplace-name }}, you can also use the [{{ TF }} module by {{ yandex-cloud }}](https://github.com/terraform-yc-modules/terraform-yc-kubernetes-marketplace).

[Learn more about using modules](../../terraform/concepts/modules.md).

{% endnote %}



