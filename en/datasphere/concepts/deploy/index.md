# Deploying models

{{ ml-platform-name }} provides tools for releasing services available to third-party resources. You can deploy a model trained in {{ ml-platform-name }} and use the same tools to develop a fully featured service based on a Docker image.

To publish a service, {{ ml-platform-name }} provides special resources, such as [nodes](#node) and [aliases](#statuses).

## Nodes {#node}

A _node_ is an isolated group of specially created VMs (_instances_) the computing load is distributed across. Node instances are created with a preset environment and fixed interpreter state. Depending on your needs, you can select different instance [configurations](../../concepts/configurations.md).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

You can access the nodes using the API. API requests can change the state of the node's interpreter. To return to the initial state, you will have to recreate the entire node.

{% note info %}

The maximum size of a request to and a response from the node API is 16 MB.

{% endnote %}

To create a node, specify your organization's cloud [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the node will deploy its instances and store its logs. In the folder, [set up a subnet](../../../vpc/operations/subnet-create.md) with internet access via a [NAT gateway](../../../vpc/operations/create-nat-gateway.md) and create a [service account](../../../iam/operations/sa/create.md) with the `vpc.user` [role](../../../iam/concepts/access-control/roles.md#vpc-user). Specify this service account in the [{{ ml-platform-name }} project settings](../../operations/projects/update.md).


### Node from a checkpoint {#checkpoint-node}

Nodes from a [checkpoint](../checkpoints.md) are good for testing and checking hypotheses. To [create](../../operations/deploy/node-create.md) a node, [pin](../../operations/projects/checkpoints.md) the checkpoint of the cell where the input and output parameters of your future microservice are defined. {{ ml-platform-name }} will use this information to automatically generate [gRPC and REST API](../../../datasphere/operations/deploy/node-api.md).

By default, node instances use standard system Docker images and do not copy the libraries set by the user. If your microservice requires packages that are not included in the [pre-installed software](../../../datasphere/concepts/preinstalled-packages.md), configure the Docker image for [deployment of the node environment](../../../datasphere/operations/deploy/node-customization.md).

### Node from a Docker image {#docker-node}

Nodes deployed from a Docker image hosted in a container registry will run as a fully featured service. The Docker image does not necessarily have to contain a model trained in {{ ml-platform-name }}. You can create any image and place it in any registry that you find appropriate. To learn how to push a Docker image to a {{ container-registry-full-name }} registry, see [{#T}](../../../container-registry/operations/docker-image/docker-image-push.md).

{% note info %}

To use {{ container-registry-full-name }}, the project service account needs the `container-registry.images.puller` [role](../../../iam/concepts/access-control/roles.md#cr-images-puller).

{% endnote %}

When creating a node from a Docker image, you set, on your own, the node's API, the port your service will use, the connection time, the format of metrics to collect, and other parameters. Once the node is created, {{ ml-platform-name }} will track its state, maintain the performance of instances, and, if required, scale the node within the instance range specified.

### Node statuses {#statuses}

A {{ ml-platform-name }} node can have one of the following statuses:

* `Healthy`: Number of instances with the `Healthy` status in the node is equal to the minimum number of required instances.
* `Unhealthy`: Number of instances with the `Healthy` status in the node is below the allowable minimum.
* `Created`: Node has just been created.
* `Deleting`: Node is being deleted.

### Instance statuses {#instance-statuses}

Node instances can have one of the following statuses:

* `Healthy`: Instance is healthy and available for balancing.
* `Unhealthy`: There are issues with the instance and it has been excluded from balancing.
* `Created`: VM has been created for the instance.
* `Started`: Connection has been established with the instance's VM.
* `Preparing`: Instance is being prepared for processing requests.
* `Deleting`: Instance is being deleted.
* `Undefined`: Initial state of the instance when the VM has not yet been created.


## Alias {#alias}

An _alias_ is a special resource used for publishing and updating a service. It allows you to replace nodes and update the running service without affecting the user experience.

[Create an alias](../../../datasphere/operations/deploy/alias-create.md) and use it as your service endpoint. You can update related nodes, balance the load across them, and remove deprecated Docker image versions without affecting the user experience.


#### See also {#see-also}

* [{#T}](../../operations/deploy/node-create.md)
* [{#T}](../../operations/deploy/alias-create.md)
* [{#T}](../../tutorials/node-from-cell.md)
* [{#T}](../../tutorials/node-from-docker.md)