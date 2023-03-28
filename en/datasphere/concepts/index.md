# About {{ ml-platform-name }}

{{ ml-platform-full-name }} is an end-to-end ML development environment where you can use familiar IDEs, serverless computing technology, and seamlessly combine a broad range of {{ yandex-cloud }} computing resource configurations. {{ ml-platform-full-name }} is part of the data platform and offers powerful features to easily interact with {{ yandex-cloud }} services.

{{ ml-platform-name }} helps significantly reduce the cost of ML as compared to computing on your own hardware or other cloud platforms thanks to automatic maintenance of computing resources.

{{ ml-platform-name }} lets you perform computing, train models, and deploy the trained models.

## Advantages of the service {#advantages}

### Ready-to-use development environment {#ready-to-use}

You do not need to spend time creating and maintaining VMs: when you create a new [project](project.md), computing resources are automatically allocated for implementing it.

The VM already has the {{ jlab }}Lab development environment and pre-installed packages for data analysis and machine learning (TensorFlow, Keras, NumPy, and others) on it, and you can start using them immediately. Full list of [pre-installed packages](preinstalled-packages.md).

If you're missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook.

### Automatic maintenance of computing resources {#auto-service}

The service automatically manages resource allocation. If you don't perform any computations, no resources are allocated.

### Saving states at shutdown {#save-state}

You don't need to keep the notebook tab open all the time: deployed computations will keep running even if you close the project and the [interpreter state](save-state.md), all variables, and the computing results will be saved. You can continue working when you reopen your project.

### Flexible choice of computing resources {#configurations}

Select the necessary computing resources for specific code snippets. When [changing the configuration](configurations.md), all the variables and the interpreter state will be transferred to a new VM.

## What's new in the new {{ ml-platform-name }} interface {#what-is-new}

### Organizations and resource hierarchy {#organization}

{{ ml-platform-name }} is no longer just a cloud - it lets all organization members work in a shared space managed by [{{ org-full-name }}]({{ link-org-main }}). Resources you create depend on your projects but are not limited only to them. For more information about connections between {{ ml-platform-name }} resources, see [{#T}](resource-model.md).

### Teamwork and cost management {#communities}

We introduced [communities](community.md) to let you collaborate on projects and flexibly manage your spending in {{ ml-platform-name }}. You can link a separate [{{ yandex-cloud }} billing account](../../billing/concepts/billing-account.md) to each community to distinguish between the finances of different teams. However, communities don't isolate teams from each other, but let them share projects and created resources.

Resource access permissions and scope are managed using new roles. For more information about roles, see [{#T}](../security/index.md).

### New types of resources {#resources}

You no longer have to re-enter data every time you need to connect to any object storage. To store all details, the **S3 connector** resource is now available. It lets you [connect and disconnect](../operations/data/connect-to-s3.md) a bucket directly in the {{ ml-platform-name }} interface.

Another new type of resource is [Checkpoints](secrets.md) that store the interpreter state and variable values. You can use them to create [nodes](deploy/index.md#node) and [share them](../operations/projects/checkpoints.md#share) in communities via a direct link.

### Seamless use of running services {#deployment}

The new resources have greatly enriched the tools for deploying and [using services](deploy/index.md).

[Aliases](deploy/index.md#alias) allow you to balance the load across multiple running nodes and publish new versions without having to stop a running service. You can [create an alias](../operations/deploy/alias-create.md) in the {{ ml-platform-name }} interface.

You can now [create](../operations/deploy/node-create.md) nodes from both Python code cells and ready-made Docker images built outside {{ ml-platform-name }}. On the node page in the {{ ml-platform-name }} interface, you can track the monitoring charts and logs of deployed instances. You can also change the configuration of computing resources and send test requests to the deployed service API.

[Instructions](../operations/index.md#deploy) for working with nodes and aliases.