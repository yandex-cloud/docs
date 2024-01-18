# Deploying models

{{ ml-platform-name }} provides tools for releasing services available to third-party resources. You can deploy a model trained in {{ ml-platform-name }} and use the same tools to develop a fully featured service based on a Docker image.

To publish a service, {{ ml-platform-name }} provides special resources, such as [nodes](#node) and [aliases](#statuses).

## Nodes {#node}

A _node_ is an isolated group of specially created VMs (_instances_) the computing load is distributed across. Node instances are created with a preset environment and fixed interpreter state. Depending on your needs, you can select different instance [configurations](../../concepts/configurations.md).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

You can access the nodes via the API. API requests can change the state of the node interpreter. To return to the initial state, you will have to recreate the entire node.

{% note info %}

The maximum size of a request to and a response from the node API is 16 MB.

{% endnote %}

To create a node, specify your organization's cloud [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the node will deploy its instances and store its logs. In the folder, [set up a subnet](../../../vpc/operations/subnet-create.md) with internet access via a [NAT gateway](../../../vpc/operations/create-nat-gateway.md) and create a [service account](../../../iam/operations/sa/create.md) with the `vpc.user` [role](../../../iam/concepts/access-control/roles.md#vpc-user). Specify this service account in the [{{ ml-platform-name }} project settings](../../operations/projects/update.md).

### Node from a checkpoint {#checkpoint-node}

Nodes from a [checkpoint](../checkpoints.md) are good for testing and checking hypotheses. To [create](../../operations/deploy/node-create.md#from-cell) a node, [pin](../../operations/projects/checkpoints.md) the checkpoint of the cell where the input and output parameters of your future microservice are defined. {{ ml-platform-name }} will use this information to automatically generate [gRPC and REST API](../../../datasphere/operations/deploy/node-api.md).

By default, node instances use standard system Docker images and do not copy the libraries set by the user. If your microservice requires packages that are not included in the [pre-installed software](../../../datasphere/concepts/preinstalled-packages.md), configure the Docker image for [deployment of the node environment](../../../datasphere/operations/deploy/node-customization.md).

### Node from models {#models-node}

With nodes from [models](../models/index.md), you can [deploy](../../operations/deploy/node-create.md#from-model) your models saved in {{ ml-platform-name }} as a service and access them via the API. {{ ml-platform-name }} will all by itself deploy the [Triton Inference Server](https://developer.nvidia.com/triton-inference-server), define the model's API, and provide monitoring for the node and the Triton server.

### Node from a Docker image {#docker-node}

Nodes deployed from a Docker image hosted in a container registry will run as a fully featured service. The Docker image does not necessarily have to contain a model trained in {{ ml-platform-name }}. You can create any image and place it in any registry that you find appropriate. To learn how to push a Docker image to a {{ container-registry-full-name }} registry, see [{#T}](../../../container-registry/operations/docker-image/docker-image-push.md).

{% note info %}

To use {{ container-registry-full-name }}, the project service account needs the `container-registry.images.puller` [role](../../../iam/concepts/access-control/roles.md#cr-images-puller).

{% endnote %}

When [creating a node from a Docker image](../../operations/deploy/node-create.md#from-docker), you yourself set the node's API, port you want your service to use, connection time, collectible metrics format, and other parameters. Once the node is created, {{ ml-platform-name }} will monitor its state, maintain the operation of the instances, and scale the node within the specified instance range as needed.

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