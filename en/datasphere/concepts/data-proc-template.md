# {{ dataproc-name }} templates

A {{ dataproc-name }} template is a special resource for rapid deployment of {{ dataproc-name }} clusters in {{ ml-platform-name }} projects. Templates define a cluster's configuration and can be used by {{ ml-platform-name }} to deploy the cluster several times.

{% include [data-proc-template-presetting](../../_includes/datasphere/settings-for-dataproc.md) %}

## Information about {{ dataproc-name }} templates as a resource {#info}

The following information is stored about each template:

* Resource name.
* Resource creator.
* Cluster configuration.
* Template creation date in [UTC]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Всемирное_координированное_время){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Coordinated_Universal_Time){% endif %} format, such as `July 18, 2022, 14:23`.

You can view all {{ dataproc-name }} templates created in your project on the {{ dataproc-name }} resource page. It also provides a list of all {{ dataproc-name }} clusters available in the project. It contains both temporary clusters based on {{ dataproc-name }} templates and connected clusters deployed in [{{ dataproc-full-name }}](../../data-proc/). To view detailed information about a template or cluster, click it.

## Specifics of a temporary cluster based on a {{ dataproc-name }} template {#special}

To create a cluster from a {{ dataproc-name }} template, [activate](../operations/data-proc-template.md#activate) the template in your project. When running a project in the IDE, {{ ml-platform-name }} creates a temporary cluster in the {{ yandex-cloud }} folder and subnet specified in the project settings.

{{ ml-platform-name }} tracks the cluster's lifetime and automatically deletes it if no computations have been performed on it within two hours. The cluster is also deleted if you force stop the computations running in the project.

### Configurations of temporary clusters {#configurations}

{{ dataproc-name }} clusters are automatically deployed on [{{ compute-full-name }} VMs](../../compute/concepts/vm.md) with 4 vCPUs and 16 GB of RAM.

You can calculate the total disk storage capacity required for different cluster configurations using the formula:

```
<number of {{ dataproc-name }} hosts> × 256 + 128
```

| Cluster type | Number of hosts | Disk size |
|:------------:|:-----------------:|--------------|
| **XS** | 1 | 384 GB HDD |
| **S** | 4 | 1152 GB SSD |
| **M** | 8 | 2176 GB SSD |
| **L** | 16 | 4224 GB SSD |
| **XL** | 32 | 8320 GB SSD |

{% note tip %}

Before running a project with an activated {{ dataproc-name }} template, check that the [quotas]({{ link-console-quotas }}) for creating HDDs or SSDs allow you to create a disk of a sufficient size.

{% endnote %}

You'll be charged additionally for running temporary clusters created based on {{ dataproc-name }} templates according to the [{{ dataproc-full-name }} pricing policy](../../data-proc/pricing.md).

### Statuses of temporary {{ dataproc-name }} clusters {#status}

{{ ml-platform-name }} creates a temporary {{ dataproc-name }} cluster once you open your project in the IDE.

The created cluster appears in the list of available clusters on the {{dataproc-name }} resource page. A temporary cluster can have one of the following statuses:
* `STARTING`: The cluster is being created.
* `UP`: The cluster is created and ready to run calculations.
* `DOWN`: Problems creating the cluster.

#### See also {#see-also}

* [How to create, activate, copy, and delete templates](../operations/data-proc-template.md).
