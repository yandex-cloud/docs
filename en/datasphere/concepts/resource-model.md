# Resource relationships in {{ ml-platform-name }}

{{ ml-platform-name }} runs within [{{ yandex-cloud }} organizations](../../organization/). Any created {{ ml-platform-name }} entities are organization resources. You cannot exchange resources between organizations.

_[Communities](community.md)_ is a way to organize team work. Communities determine the scope of projects and resources in {{ ml-platform-name }}.

You can create a community in one of the [availability zones](../../overview/concepts/geo-scope.md). All projects and resources created in the community will also be hosted in this availability zone. Once a community is created, you cannot move it to a different zone.

_[Projects](project.md)_ are the main workspaces in {{ ml-platform-name }}. Projects store code, variables, installed software, and other information.

_{{ ml-platform-name }} resources_ are objects that are created or used in projects: datasets, Docker images, nodes, and more.

## {{ ml-platform-name }} resources {#resources}

You can use the following types of resources in {{ ml-platform-name }} projects:

* [Datasets](dataset.md): Ways of storing information that provide quick access to large amounts of data within a project.
* [Secrets](secrets.md): Key-value pairs that store private data (tokens, keys, etc.) in encrypted form. Secrets are created in a project and assigned to it. You can use secrets as environment variables in a cell.
* [Docker images](docker.md): OS environments with certain software, libraries, environment variables, and configuration files.
* [Connectors to S3 storages](s3-connector.md): Saved configurations for connecting [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md). You can mount buckets into a project's file system to make it easier to access code data. To learn how to create an S3 connector, see [{#T}](../operations/data/s3-connectors.md).
* [Nodes](deploy/index.md#node): Services deployed for [running trained models](deploy/). Third-party services can access nodes using the API.
* [Aliases](deploy/index.md#alias): Add-ons used to publish services. Aliases allow you to distribute the load across nodes and update the deployed services on the fly.
* [{{ dataproc-name }} templates](data-proc-template.md): Ready-to-use {{ dataproc-name }} cluster configurations for automatic cluster deployment from a {{ ml-platform-name }} project.
* [Models](models/index.md): Saved interpreter state and computation or training results. These are grouped into models trained within projects and fine-tuned [foundation models](models/foundation-models.md).
* [Spark connectors](spark-connector.md): Saved configurations for connecting existing {{ dataproc-name }} clusters and creating temporary clusters.

## Shared use of projects and resources {#sharing}

To share projects and resources, {{ ml-platform-name }} allows you to publish resources in communities.

By publishing a resource, you grant resource access to all users in a community. This allows them to use the resource in their projects within the community. You can publish resources in a project's community and other communities within the organization.

Exchanging resources between communities enables different teams of the same organization to share Docker images, datasets, and other objects.

{{ ml-platform-name }} communities, projects, and resources are only visible inside an [organization](../../organization/). You cannot exchange resources between organizations. You also cannot share a resource in a community that was created in a different availability zone.

You can share the resources of the {{ ml-platform-name }} project in which you have at least the `Editor` role in any community of the organization in which you have at least the `Developer` role. You can open the access on the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the resource view page. For more information, see [{#T}](../security/index.md).

## Relationships between {{ ml-platform-name }} resources and {{ yandex-cloud }} services {#ml-cloud-connection}

{{ ml-platform-name }} communities are organization resources. One organization may have multiple communities.

To pay for {{ ml-platform-name }}, use a {{ yandex-cloud }} [billing account](../../billing/concepts/billing-account.md).

Other {{ yandex-cloud }} services are accessed through [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) that store the resources of a specific {{ yandex-cloud }} service. To work with {{ yandex-cloud }} services, use [service accounts](../../iam/concepts/users/service-accounts.md).
