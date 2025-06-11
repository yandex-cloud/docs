# Handling a stateful workload

You can use instance groups to host applications with _stateful_, _stateless_, and combined workloads.

The difference between stateful and stateless workloads lies in whether the application saves data about its states and/or user interaction history:
* Stateful: State data is stored. Examples: RESTless services, databases, message queues, monitoring servers, and log servers.
* Stateless: State data is not stored. Examples: RESTful services and web application frontend.

Application states can be stored on [secondary disks of the group instances](#disks) or in the [cloud resources independent of the instance group](#external-resources).

## Storing states on group instance disks {#disks}

{% note warning %}

We do not recommend storing states on instance _boot_ disks. This significantly restricts operations with an instance group. For example, you cannot freely restart, delete, recreate, and scale an instance in such a group.

{% endnote %}

You can store application states on _secondary_ disks of the group instances if you:
* Do not decrease the group size.
* Do not decrease the instance disk size.
* Use the `max_expansion` parameter (the maximum number of instances by which you can exceed the target size of the group) set to `0` in the [deployment policy](./policies/deploy-policy.md).
* Do not delete VM instances via instance group interfaces:
  * In the [management console]({{ link-console-main }}), on the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}** tab.
  * Using the CLI [{{ yc-compute-ig }} delete-instances](../../../cli/cli-ref/compute/cli-ref/instance-group/delete-instances.md) command.
  * Using the [InstanceGroupService/DeleteInstances](../../instancegroup/api-ref/grpc/InstanceGroup/deleteInstances.md) gRPC API call.
  
  These actions will delete the secondary disk along with the VM. You can directly [delete](../../operations/vm-control/vm-delete.md) a VM in {{ compute-name }} without deleting its secondary disk.

If you meet these conditions, the instance group will not delete secondary disks, even if any VM needs to be recreated. The secondary disks will be saved and attached to the new VM.

## Storing states outside the instance group {#external-resources}

To freely manage group instances with stateful workload applications running, save the application state to cloud resources independent of the instance group:
* Managed databases
* [File storages](../filesystem.md) (for more information, see [{#T}](../../operations/instance-groups/create-with-filesystem.md)).
* {{ objstorage-full-name }} [buckets](../../../storage/concepts/bucket.md) (for more information, see [{#T}](../../operations/instance-groups/create-with-bucket.md)).
