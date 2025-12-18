# Fixing the `Can't use allocation_policy.locations.subnet_id together with node_template.network_interface_specs` error


## Issue description {#issue-description}

When creating a new node group in a {{ managed-k8s-name }} cluster using the {{ TF }} provider, YC CLI, or API, you get this error:

```
can't use "allocation_policy.locations[0].subnet_id" together with "node_template.network_interface_specs"
```

## Solution {#issue-resolution}

This error means that the command or manifest contains conflicting parameters. Try creating a node group from the [management console]({{ link-console-main }}) or explicitly specify the cloud subnet name or ID before running the command.

{% cut "Example for YC CLI" %}

```bash
yc managed-kubernetes node-group create  \
--name my-sample-k8s-cluster-nodegroup-1 \   
--cluster-name my-sample-k8s-cluster     \
--platform standard-v3                   \
--cores 2                                \
--memory 4                               \
--core-fraction 100                      \
--disk-type network-hdd                  \
--disk-size 30                           \
--fixed-size 1                           \
--network-interface subnets=$SUBNET_ID   \
--async
```

Where `$SUBNET_ID` is the ID of the cloud subnet to host the new node group.

{% endcut %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Date and time of running the node group creation operation.
1. Screenshot or text output of the error message you get when trying to create a node group.