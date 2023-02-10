# Using models

You can use {{ ml-platform-name }} to deploy trained models as microservices and grant third-party resources access to them.

Models are deployed on _instances_: virtual machines that preserve the interpreter state and the model code.

For load balancing, instances are combined into _nodes_: isolated groups of virtual machines. The API is used to access the node.

Published services are updated using _aliases_, a special type of resource that let you replace nodes without affecting the deployed service users' experience and balance the load across them.

## Nodes from cells with Python code {#python-nodes}

To create a node from a cell with Python code, [save a checkpoint](../../operations/projects/checkpoints.md#pin) with the proper interpreter state. The API will be generated automatically based on the variables you selected when creating the node.

API requests can change the state of the node's interpreter. You can't revert to the original state without recreating the node.

{% include [Node requests size](../../../_includes/datasphere/node-service-request-size.md) %}

Read more about creating a node from a Python code cell in [{#T}](../../operations/deploy/node-create.md).

By default, instances use standard system Docker images and don't copy user-installed libraries. If your microservice requires packages that are not included in the [pre-installed software](../preinstalled-packages.md), configure the Docker image for [deployment of the node environment](../../operations/deploy/node-customization.md).

## Statuses of nodes and their instances {#statuses}

Node instances can have one of the following statuses:

* `Healthy`: The instance is healthy and available for balancing.
* `Unhealthy`: There are issues with the instance, it's been excluded from balancing.
* `Created`: A VM has been created for the instance.
* `Started`: A connection has been established with the instance's VM.
* `Preparing`: The instance is being prepared for processing requests.
* `Deleting`: The instance is being deleted.
* `Undefined`: The initial state of the instance, the VM has not been created yet.

A {{ ml-platform-name }} node can have one of the following statuses:

* `Healthy`: The number of VMs with the `Healthy` status in the node is equal to the minimum number of VMs needed.
* `Unhealthy`: The number of VMs with the `Healthy` status in the node is below the allowable minimum.
* `Created`: The node has just been created.
* `Deleting`: The node is being deleted.