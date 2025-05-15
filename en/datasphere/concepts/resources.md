# {{ ml-platform-name }} project resources

In {{ ml-platform-name }} projects, you can create resources, which are auxiliary objects that help speed up data operations, automate routine actions, and perform special operations.

You can view resources that are created or available in a project on the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**.

You can use resources in multiple projects without recreating them. To make a resource available for all [community](community.md) projects, share it in the **{{ ui-key.yc-ui-datasphere.common.access }}** tab. To do this, you need at least the `Editor` role in the project and the `Developer` role in the community you want to publish your resource in. Community resources are available on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

{{ ml-platform-name }} project resources:

* [Secrets](secrets.md)
* [Docker images](docker.md)
* [Datasets](dataset.md)
* [S3 connectors](s3-connector.md)
* [Nodes and aliases](deploy/index.md#python-nodes)
* [{{ dataproc-name }} templates](data-processing-template.md)
* [Spark connectors](spark-connector.md)
* [Models](models/index.md)
* [File storages](filestores.md)

For more information about the {{ ml-platform-name }} resource model, see [{#T}](resource-model.md).
