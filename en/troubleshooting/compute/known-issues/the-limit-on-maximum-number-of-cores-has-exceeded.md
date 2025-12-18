# Fixing the `The limit on maximum number of cores has exceeded` error


## Issue description {#issue-description}

When trying to create a {{ compute-name }} VM or a {{ managed-k8s-name }} node group, you get the `The limit on maximum number of cores has exceeded` message.

## Solution {#issue-resolution}

This error occurs when the **number of vCPUs for VMs** in your cloud exceeds the quota. Request a quota increase using [this form]({{ link-console-quotas }}).

To create and use new {{ compute-name }} VMs or {{ managed-k8s-name }} nodes, you might also need to increase other quotas, such as the following:

* **Total HDD capacity**
* **Total SSD capacity**
* **Total disk snapshot size**
* **Number of disks**
* **Total VM RAM**
* **Number of VM instances**

Check out your current usage of these quotas.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID for the failed operation of creating a new VM or {{ managed-k8s-name }} node group.
1. Text of the error message you get when trying to create new objects.
