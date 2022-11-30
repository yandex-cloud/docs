# {{ ml-platform-name }} project resources

In {{ ml-platform-name }} projects, you can create resources, which are auxiliary objects that help speed up data operations, automate routine actions, and perform special operations.

You can view resources that are created or available in a project on the project page under **Resources**.

You can use resources in multiple projects without recreating them. To make a resource available for all [community](community.md) projects, share it in the **Access** tab. A community's resources are available on the community page under **Resources**.

{{ ml-platform-name }} project resources:

* [Checkpoints](checkpoints.md)
* [Secrets](secrets.md)
* [Docker images](docker.md)
* [Datasets](dataset.md)
* [S3 connectors](../operations/data/connect-to-s3.md)
* [Nodes and aliases](deploy/index.md#python-nodes)
{% if audience == "draft" %}{% if product == "yandex-cloud" %}* [Data Proc templates](data-proc-template.md){% endif %}{% endif %}

For more information about the {{ ml-platform-name }} resource model, see [{#T}](resource-model.md).
