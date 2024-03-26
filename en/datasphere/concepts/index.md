# About {{ ml-platform-name }}

{{ ml-platform-full-name }} is a full-cycle ML development environment. {{ ml-platform-full-name }} offers powerful features to easily work with {{ yandex-cloud }} services.

In {{ ml-platform-name }}, you can train models and perform computations in {{ ds-nb }}, run remote computations with the [{{ ds-jobs }}](jobs/index.md) jobs, deploy the trained models or any Docker images as a service in [{{ ds-inf }}](#deployment).

## {{ ml-platform-full-name }} advantages {#advantages}

### Ready-to-use development environment {#ready-to-use}

You do not need to spend time creating and maintaining VMs: when you create a new [project](project.md), computing resources are automatically allocated for implementing it.

The VM already has the pre-installed {{ jlab }}Lab development environment and packages for data analysis and machine learning (TensorFlow, Torch, Keras, NumPy, etc.) on it, and you can start using them immediately. You can find the full list of pre-installed packages [here](preinstalled-packages.md).

If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from a notebook or [build](../operations/user-images.md) a custom [Docker image](docker.md).

### Flexible choice of computing resources {#configurations}

{{ ml-platform-name }} offers a wide range of ready-made [computing resource configurations](configurations.md). You can select one or multiple configurations and get a managed service without the need to set up a VM. The allocated resources will be assigned to you as long as you are using it or until you intentionally release the VM. By default, an idle VM is released in three hours, but you can [set](../operations/projects/update.md) the time to reduce costs or to keep the selected configuration assigned to you.

### Organizations and resource hierarchy {#organization}

{{ ml-platform-name }} is not just a cloud: it allows all organization members to work in a shared space managed by [{{ org-full-name }}]({{ link-org-main }}). Resources you create depend on your projects but are not limited only to them. For more information about connections between {{ ml-platform-name }} resources, see [{#T}](resource-model.md).

### Teamwork and cost management {#communities}

We introduced [communities](community.md) that allow you to collaborate on projects and flexibly manage your costs in {{ ml-platform-name }}. You can link a separate [{{ yandex-cloud }} billing account](../../billing/concepts/billing-account.md) to each community to distinguish between the finances of different teams. However, communities do not isolate teams from each other; instead, they enable sharing projects and created resources.

Resource access permissions and scope are managed using roles. For more information about roles, see [{#T}](../security/index.md).

In addition, community administrators can set up functions to be available in projects and impose limits on the use of configurations to control the costs.

### Seamless use of running services {#deployment}

[{{ ds-inf }}](deploy/index.md) provides easy-to-use tools for deploying services based on both models trained in {{ ml-platform-name }} and custom Dockerimages built outside {{ ml-platform-name }}.

[Aliases](deploy/index.md#alias) allow you to balance the load across multiple running nodes and publish new versions without having to stop a running service. You can [create an alias](../operations/deploy/alias-create.md) in the {{ ml-platform-name }} interface.

On the node page in the {{ ml-platform-name }} interface, you can track the monitoring charts and logs of the deployed instances. You can also change the configuration of computing resources and send test requests to the deployed service API.

You can find the guides for working with nodes and aliases [here](../operations/index.md#deploy).