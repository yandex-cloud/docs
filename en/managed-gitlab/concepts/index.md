# Relationships between resources in {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) is a web-based open-source DevOps lifecycle tool. It's a code repository management system for [Git](https://git-scm.com/) that offers a bug tracking system, a [CI/CD]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/CI/CD){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/CI/CD){% endif %} pipeline, own Wiki, and other features.

{{ mgl-name }} enables you to set up app deployment on [{{ compute-full-name }}](../../compute/) VM instances and supports integration with [{{ container-registry-full-name }}](../../container-registry/) and [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

{{ mgl-name }} workflow:

![image]{% if lang == "ru" %}(../../_assets/managed-gitlab/gitlab_schema_ru.svg){% endif %}{% if lang == "en" %}(../../_assets/managed-gitlab/gitlab_schema_en.svg){% endif %}

## {{ GL }} instance {#instance}

_A {{ GL }} instance_ is the main entity that the service operates with. It's a VM hosted in {{ yandex-cloud }}. {{ mgl-name }} takes care of routine maintenance of this VM, for example, ensuring storage fault tolerance, installing security updates, upgrading automatically to new versions, {{ GL }} and so on.

## Configuring instances {#config}

When creating an instance, specify:
* The instance type, that is, the number of cores (vCPU) and amount of memory (RAM).
* The subnet.
* The storage size.
* The name under the `.gitlab.yandexcloud.net` domain to define the URL of your {{ GL }} instance.
* Administrator details:
  * Email.
  * Login.