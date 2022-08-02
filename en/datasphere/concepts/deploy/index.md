# Deploying models

You can use {{ ml-platform-name }} to deploy trained models as microservices and grant third-party resources access to them.

Models are deployed on _instances_: virtual machines that preserve the interpreter state and the model code.

For load balancing, instances are combined into _nodes_: isolated groups of virtual machines. The API is used to access the node.

## Nodes from cells with Python code {#python-nodes}

To create a node from a cell with Python code, [save a checkpoint](../../operations/projects/checkpoints.md#pin) with the proper interpreter state. The API will be generated automatically based on the variables you selected when creating the node.

API requests can change the state of the node's interpreter. You can't revert to the original state without recreating the node.

{% include [Node requests size](../../../_includes/datasphere/node-service-request-size.md) %}

Read more about creating a node from a Python code cell in [{#T}](../../operations/node-cell.md).

By default, instances use standard system Docker images and don't copy user-installed libraries. If your microservice requires packages that are not included in the [pre-installed software](../preinstalled-packages.md), configure the Docker image for [deployment of the node environment](../../operations/node-customization.md).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

For more information about the cost of using {{ ml-platform-name }}, see [{#T}](../../pricing.md).

{% endnote %}

## Statuses of nodes and their instances {#statuses}

Node instances can have one of the following statuses:

* `HEALTHY`: The instance is healthy and available for balancing.
* `UNHEALTHY`: There are issues with the instance, it's been excluded from balancing.
* `CREATED`: A VM has been created for the instance.
* `STARTED`: A connection has been established with the instance's VM.
* `PREPARING`: The instance is being prepared for processing requests.
* `DELETING`: The instance is being deleted.
* `UNDEFINED`: The initial state of the instance, the VM has not been created yet.

A {{ ml-platform-name }} node can have one of the following statuses:

* `HEALTHY`: The number of VMs with the `HEALTHY` status in the node is equal to the minimum number of VMs needed.
* `UNHEALTHY`: The number of VMs with the `HEALTHY` status in the node is below the allowable minimum.
* `CREATED`: The node has just been created.
* `DELETING`: The node is being deleted.