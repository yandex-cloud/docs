# Relationships between resources in {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) is an open-source {% if lang == "ru" %}[DevOps](/blog/posts/2022/03/what-is-devops){% else %}DevOps{% endif %} lifecycle tool. It is a system for managing code repositories for [Git](https://git-scm.com/) with error tracking, a [CI/CD]{% if lang == "ru" %}(/blog/posts/2022/10/ci-cd){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/CI/CD){% endif %} pipeline, a dedicated Wiki, and other functionality.

{{ mgl-name }} helps configure application deployment to [{{ compute-full-name }}](../../compute/) [virtual machines](../../compute/concepts/vm.md) and supports integration with [{{ container-registry-full-name }}](../../container-registry/) and [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

{{ mgl-name }} workflow:

![image]{% if lang == "ru" %}(../../_assets/managed-gitlab/gitlab_schema_ru.svg){% endif %}{% if lang == "en" %}(../../_assets/managed-gitlab/gitlab_schema_en.svg){% endif %}

## {{ GL }} instance {#instance}

A {{ GL }} _instance_ is the service's primary entity. It is a VM deployed in {{ yandex-cloud }}. {{ mgl-name }} takes care of this VM's routine maintenance, such as storage fault tolerance, security updates, automated {{ GL }} version upgrades, and so on.

## Instance configuration {#config}

When creating an instance, you specify:
* Instance type: [The number of vCPUs and the amount of RAM](../../compute/concepts/vm-platforms.md).
* [Subnet](../../vpc/concepts/network.md#subnet).
* Storage size.
* Name in the `.gitlab.yandexcloud.net` domain: Your {{ GL }} instance's internet address.
* Administrator information:
  * Email.
  * Login.