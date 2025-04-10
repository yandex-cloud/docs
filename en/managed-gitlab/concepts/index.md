# Resource relationships in {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) is an open-source web-based DevOps lifecycle tool. It is a code repository management system for [Git](https://git-scm.com/) with error tracking, [CI/CD](https://en.wikipedia.org/wiki/CI/CD) pipeline, dedicated Wiki, and other features.

{{ mgl-name }} helps configure application deployment to [{{ compute-full-name }}](../../compute/) [virtual machines](../../compute/concepts/vm.md) and supports integration with [{{ container-registry-full-name }}](../../container-registry/) and [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

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


## Use cases {#examples}

* [{#T}](../tutorials/gitlab-lockbox-integration.md)
* [{#T}](../tutorials/ci-cd-serverless.md)
* [{#T}](../tutorials/install-gitlab-runner.md)
* [{#T}](../tutorials/gitlab-containers.md)