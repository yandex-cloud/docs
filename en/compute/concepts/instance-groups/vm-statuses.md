# Instance statuses in an instance group

## List of statuses

An instance in a group of instances can have one of the following statuses:

| Status | Description |
| ----- | ----- |
| `CREATING` | An instance is being created in the Yandex Compute Cloud system. |
| `STARTING` | The OS and user application are being started. |
| `OPENING` | The instance is ready to receive traffic, from the viewpoint of the network load balancer. |
| `WARMING` | The user application is warming up. |
| `RUNNING` | The instance is running. |
| `CLOSING` | The instance no longer receives traffic, from the viewpoint of the network load balancer. |
| `STOPPING` | The instance is being stopped. |
| `DELETING` | The instance is being removed from the Yandex Compute Cloud system. |
| `UPDATING` | The basic parameters or metadata are being updated without re-creating the instance. |
| `FAILED` | The operation has failed. You should recover the instance from this state yourself. Make sure the [limits](../limits.md) are not exceeded and re-create the group. |

## Operations on an instance group

The following operations can be performed on an instance group:

- [Create](#create).
- [Delete](#delete).
- [Update](#update).

### Create {#create}

When [a group is created](../../operations/instance-groups/create-fixed-group.md), each instance goes through the following stages depending on the [deployment policy](policies.md#deploy-policy):

1. `CREATING`: the instance is allocated computing resources, i.e., the number and performance of processor cores (vCPUs) and the amount of RAM. It is assigned an IP address and its disks are created.
1. `STARTING`: the instance is launched.
1. `OPENING`: the instance is ready to receive traffic, from the viewpoint of the network load balancer.
1. `WARMING`: the instance is warming up, meaning that caches are being filled and various optimizations are in progress.
1. `RUNNING`: the instance has switched to operating mode.

### Delete {#delete}

When [a group is deleted](../../operations/instance-groups/delete.md), each instance goes through the following stages depending on the [deployment policy](policies.md#deploy-policy):

1. `CLOSING`: all current operations are being aborted and traffic stops being delivered to the instance.
1. `STOPPING`: the instance is terminated.
1. `DELETING`: the instance is being deleted. When the deletion is complete, the instance disappears from the list of available resources. After all the instances are deleted, the group also disappears from the list of available resources.

### Update {#update}

When [a group is updated](../../operations/instance-groups/update.md), each instance goes through the following stages depending on the [deployment policy](policies.md#deploy-policy):

1. `CLOSING`: all current operations are being aborted and traffic stops being delivered to the instance.
1. `STOPPING`: the instance is terminated.
1. `DELETING`: the instance is being deleted. When the deletion is complete, the instance disappears from the list of available resources.
1. `CREATING`: a new instance is being created with the updated configuration. At this stage, the instance is allocated computing resources: the number and performance of processor cores (vCPUs) and the amount of RAM. It is assigned an IP address and its disks are created.
1. `STARTING`: the instance is launched.
1. `OPENING`: the instance is ready to receive traffic, from the viewpoint of the network load balancer.
1. `WARMING`: the instance is warming up, meaning that caches are being filled and various optimizations are in progress.
1. `RUNNING`: the instance has switched to operating mode.

