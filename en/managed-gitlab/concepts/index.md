# Resource relationships in {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) is an open-source web-based DevOps lifecycle tool. It is a code repository management system for [Git](https://git-scm.com/) with error tracking, [CI/CD](https://en.wikipedia.org/wiki/CI/CD) pipeline, dedicated Wiki, and other features.

{{ mgl-name }} helps configure application deployment on [VMs](../../compute/concepts/vm.md) in [{{ compute-full-name }}](../../compute/) and supports integration with [{{ container-registry-full-name }}](../../container-registry/) and [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

How {{ mgl-name }} works:

![image](../../_assets/managed-gitlab/gitlab_schema_en.svg)

## {{ GL }} instance {#instance}

A {{ GL }} _instance_ is the service's primary entity. It is a VM deployed in {{ yandex-cloud }}. {{ mgl-name }} takes care of its routine maintenance, such as storage fault tolerance, security updates, automated {{ GL }} version upgrades, and so on.

## Instance configuration {#config}

When creating an instance, you specify:
* Instance type: [The number of vCPUs and the amount of RAM](../../compute/concepts/vm-platforms.md). After you create an instance, you can [change its type](../operations/instance/instance-update.md) to a higher performing one.
* [Subnet](../../vpc/concepts/network.md#subnet).

  {% include [GL CIDR Warning](../../_includes/managed-gitlab/cidr-note.md) %}

* Disk size. After you create an instance, [you can increase](../operations/instance/instance-update.md) its disk size.
* Name in the `.gitlab.yandexcloud.net` domain: Your {{ GL }} instance's internet address.
* Administrator information:
  * Email.
  * Login.

{% include [HTTPS info](../../_includes/managed-gitlab/note-https.md) %}

## {{ GLR }} {#runners}

[{{ GLR }}](https://docs.gitlab.com/runner/) is an open-source application which executes {{ GL }} [CI/CD](/blog/posts/2022/10/ci-cd) pipeline jobs based on instructions from a special file named `.gitlab-ci.yml`. It allows running automated builds inside [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and on [{{ compute-name }} VMs](../../compute/concepts/vm.md).

You can get started with {{ GLR }} in the following ways:

* [Install {{ GLR }} in a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/applications/gitlab-runner.md).
* Create a {{ compute-name }} VM and [install {{ GLR }} on it manually](../tutorials/install-gitlab-runner.md#install).
* [Use the management console to create a runner](../tutorials/install-gitlab-runner.md#create-runner) that will automatically deploy the specified number of {{ compute-name }} VMs.

    When creating a runner from the management console, you can select the following 15 to 500 GB disk types for the VM storage:

    * HDD
    * SSD

    The following computing resource configurations are available:

    * 2 vCPUs, 4 GB RAM
    * 2 vCPUs, 8 GB RAM
    * 4 vCPUs, 16 GB RAM
    * 8 vCPUs, 64 GB RAM
    * 16 vCPUs, 128 GB RAM

    {% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

## Use cases {#examples}

* [{#T}](../tutorials/gitlab-lockbox-integration.md)
* [{#T}](../tutorials/ci-cd-serverless.md)
* [{#T}](../tutorials/install-gitlab-runner.md)
* [{#T}](../tutorials/gitlab-containers.md)
