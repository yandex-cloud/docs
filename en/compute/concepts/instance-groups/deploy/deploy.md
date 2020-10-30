# Deployment algorithm

The deployment algorithm switches an instance group from one state to another using short iterative changes. Each iteration takes into account the restrictions set by the user.

A feature of the deployment algorithm is that before deleting and updating an instance using [update](../../../grpc/instance_service.md#Update), the algorithm always stops the instance using a separate [stop](../../../grpc/instance_service.md#Stop) call. Delete or update is run during the next iteration.

The attributes that don't require the instance to be stopped (such as the `description` fields) are updated simultaneously for all running instances, because this doesn't violate any restrictions.

{% note info %}

If the user rolls back the group settings to their previous values while the instance is stopped, the algorithm may restart the instance.

{% endnote %}

## Algorithm example {#example}

Let's say you have a group of two instances. You need to expand it to three instances and update the two old instances based on a new specification. By setting `max_expansion = 1`, you can create an additional instance during deployment.

Algorithm behavior:

1. Two new instances are created and started.

   At this point, the group will contain two old instances running and two new instances.

1. One of the old instances is stopped by calling `stop` in **Compute Cloud**. One old instance and two new instances are running, one old instance is stopped.

   The target group size is 3. It means that at least three instances must be running at the same time. Therefore, we can't stop the second old instance at this point.

1. The old instance is updated using the `update` call in **Compute Cloud** (if allowed), or deleted and created again.

   Let's assume that a simpler scenario with the `update` call was triggered. When the update is complete, the group will contain one old instance, one new instance stopped, and two new instances running.

1. The updated stopped instance starts. Now the group contains one old running instance and three new running instances.

1. The last old instance is deleted.

The algorithm met the restrictions: three instances were running in the group at any given time.

