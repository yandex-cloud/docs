# Relationships between resources in {{ ml-platform-name }}

{{ ml-platform-name }} runs within [{{ yandex-cloud }} organizations](../../organization/). Any created {{ ml-platform-name }} entities are organization resources. You can't exchange resources between organizations.

_[Communities](community.md)_ is a way to organize team work. Communities determine the scope of projects and resources in {{ ml-platform-name }}.

_[Projects](project.md)_ represent a user's main work space in {{ ml-platform-name }}. Projects store the [interpreter state](save-state.md), variables, the software installed, and other information.

_{{ ml-platform-name }} resources_ are objects that are created or used in projects: datasets, Docker images, nodes, and more.

## {{ ml-platform-name }} resources {#resources}

You can use the following types of resources in {{ ml-platform-name }} projects:

* A [dataset](dataset.md) is an information storage mechanism providing quick access to large amounts of data within a project.
* [Secrets](secrets.md) are key-value pairs that store private data (tokens, keys, and so on) in encrypted form. Secrets are created in a project and associated with it. You can use secrets as environment variables in a cell.
* A [Docker image](docker.md) is an OS environment with an arbitrary set of software, libraries, environment variables, and configuration files.
* Connectors to S3 storage are saved configurations used to connect [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md). You can mount buckets into a project's file system to make it easier to access code data. To learn how to create an S3 connector, see [{#T}](../operations/data/connect-to-s3.md).
* A checkpoint is a notebook's [saved state](save-state.md), including cell code, output, and variable values, as well as project storage data. Checkpoint versioning is maintained.
* [Nodes](deploy/index.md#node) are services deployed for [running trained models](deploy/). Third-party services can access nodes using the {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}.
* An [alias](deploy/index.md#alias) is an <q>add-on</q> used to publish services. Aliases let you distribute the load across nodes and update the deployed services on the fly.
* [{{ dataproc-name }} templates](data-proc-template.md) are ready-to-use {{ dataproc-name }} cluster configurations for automatic cluster deployment from a {{ ml-platform-name }} project.

## Shared use of projects and resources {#sharing}

For shared use of projects and resources, {{ ml-platform-name }} lets you publish resources in communities.

By publishing a resource, you grant resource access to all users in a community. This lets them use the resource in their projects within the community. You can publish resources in a project's community and other communities within the organization.

Exchanging resources between communities lets different teams of the same organization share Docker images, datasets, checkpoints, and other objects.

{{ ml-platform-name }} communities, projects, and resources are only visible inside an [organization](../../organization/). You can't exchange resources between organizations.

You can share resources of a {{ ml-platform-name }} project where you have the `Admin` role. Resources can be shared with any community that you are a member of with the `Admin` role. For details, see [{#T}](../security/index.md).

## Relationships between {{ ml-platform-name }} resources and {{ yandex-cloud }} services {#ml-cloud-connection}

{{ ml-platform-name }} communities are organization resources. One organization may have multiple communities.

To pay for {{ ml-platform-name }}, use a {{ yandex-cloud }} [billing account](../../billing/concepts/billing-account.md).

Other {{ yandex-cloud }} services are accessed using [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). They store the resources of a specific {{ yandex-cloud }} service. To work with {{ yandex-cloud }} services, use [service accounts](../../iam/concepts/users/service-accounts.md).
