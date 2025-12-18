# {{ managed-k8s-name }} group nodes are not scaling up


## Issue description {#issue-description}

The nodes in the {{ managed-k8s-name }} group do not scale automatically after you increase the **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}** and **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** values.

## Solution {#issue-resolution}

Updating the **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}** and **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** settings does not automatically create new nodes in the {{ managed-k8s-name }} node group.

To trigger node creation, deploy resource-consuming workloads on the cluster. Once this is done, {{ k8s-ca }} can scale up your cluster and maintain node count based on the updated settings. Then, you can remove the deployed workloads.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Description of the {{ managed-k8s-name }} cluster state you expect to get, such as the number of nodes in the group.