# Setting up a project to work with a cloud {{ yandex-cloud }}

{{ ml-platform-full-name }} provides everything you need for data analysis and ML model training. However, if you want to use all {{ yandex-cloud }} features, you will need to set up a {{ ml-platform-name }} project to work with the cloud in {{ yandex-cloud }} and enable integration with other platform services.

This guide describes how to arrange a workspace in {{ ml-platform-name }} to effectively use {{ yandex-cloud }} services.

1. [{#T}](#create-project)
1. [{#T}](#create-cloud)
1. [{#T}](#set-network)
1. [{#T}](#create-sa)
1. [{#T}](#examples)

For detailed information on how to create and set up resources, see the _Step-by-step guides_ section in the documentation for respective services.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Create a project {#create-project}

{{ ml-platform-name }} communities group users into a team and allow them to share resources and [manage budgets](../operations/community/billing-details.md). A [project](../concepts/project.md) within a community is a user's individual workspace run on {{ yandex-cloud }} VMs. Depending on the [operation mode](../concepts/project.md#mode), a project may include one or more VMs with each VM assigned to a separate notebook within the project.

{% note info %}

{{ ml-platform-name }} is not designed for pair programming. In [{{ dd }} mode](../concepts/project.md#dd), multiple users can collaborate within a single project if each user is working in a separate notebook.

{% endnote %}

Create a {{ ml-platform-name }} project as described in [this guide](../operations/projects/create.md).

Next, you can specify parameters for integration with other {{ yandex-cloud }} services on the [project editing page](../operations/projects/update.md).

## Create a cloud and folder {#create-cloud}

Most {{ yandex-cloud }} services run inside [cloud folders](../../resource-manager/concepts/resources-hierarchy.md#rm-resources). To access cloud resources, use [{{ console-full-name }}]({{ link-console-cloud }}), a {{ yandex-cloud }} management console.

Log in to the management console and [create your first cloud](../../resource-manager/operations/cloud/create.md) and [folder](../../resource-manager/operations/folder/create.md) to host services you want to use from {{ ml-platform-name }}.

You can learn more on how users work with resources in {{ yandex-cloud }} [here](../../overview/roles-and-resources.md).

{% note tip %}

You can use multiple folders to flexibly set up access rights and distinguish between runtime environments and tasks.

{% endnote %}

## Configure a network {#set-network}

To enable {{ yandex-cloud }} service resources to exchange information, [create a cloud network and subnet](../../vpc/operations/network-create.md). By default, a network is isolated within {{ yandex-cloud }} and has no access to the internet. To make sure the cloud resources have access to the internet without using [public IP addresses](../../vpc/concepts/address.md#public-addresses), [create and set up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{% note info %}

By default, {{ ml-platform-name }} projects use a service subnet with access to the internet. If you specify your own subnet with no NAT gateway configured in the project settings, you will not be able to update installed packages and perform other network operations.

{% endnote %}

## Create a service account {#create-sa}

{{ yandex-cloud }} has a special type of account to automate operations: a [service account](../../iam/concepts/users/service-accounts.md). Using a service account, software can manage service resources. To enable a service account to perform operations on resources, it must be assigned the appropriate [roles](../../iam/concepts/access-control/roles). To learn more about the current service roles, see the _Access management_ section of the service documentation.

{{ ml-platform-name }} supports two ways to enable a service account to perform operations:
1. If a service account needs to perform operations on _resources of other services_ on behalf of {{ ml-platform-name }}, add it to project settings.
1. If a service account needs to perform operations on a _project or community in {{ ml-platform-name }}_ (run cells, create resources, etc.), add it to the list of [project members](../operations/projects/add-user.md) or [community members](../operations/community/add-user.md) with the respective role.

## Service integration examples {#examples}

In this section, you will find examples of how to set up a project to perform a variety of tasks in {{ ml-platform-name }} and how to set up integration with {{ yandex-cloud }} services.

### Computing on Apache Spark™ clusters {#data-proc}

{{ ml-platform-name }} allows you to run computing on Apache Spark™ clusters created in {{ dataproc-name }}.

{% include [preferences](../../_includes/datasphere/settings-for-dataproc.md) %}

Learn more about working with {{ dataproc-name }} clusters in {{ ml-platform-name }}:
* [{#T}](../concepts/data-proc.md)
* [{#T}](data-proc-integration.md)

### Deploying a pretrained model as a service {#docker-node}

If you want to deploy a model as a separate service in {{ ml-platform-name }}, use [nodes based on a Docker image](../concepts/deploy/index.md#docker-node). In the project settings, [specify](../../datasphere/operations/projects/update.md) the following parameters:

* Default folder to store node logs.
* Service account with the following rights:
   * `container-registry.images.puller` to allow {{ ml-platform-name }} to pull your Docker image for creating a node.
   * `vpc.user` to use the {{ ml-platform-name }} cluster network.
   * (Optional) `datasphere.user` to send requests to the node.

Learn more about deploying services in {{ ml-platform-name }}:
* [{#T}](../concepts/deploy/index.md)
* [{#T}](node-from-docker.md)