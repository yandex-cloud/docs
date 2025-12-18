# The cluster remains in the `STARTING` status for too long


## Issue description {#issue-description}

* When trying to create or run an existing {{ managed-k8s-name }} cluster, its status switches to `STARTING` but even after a while does not switch to `RUNNING`.
* The cluster is stuck in the `STARTING` status.
* The {{ managed-k8s-name }} cluster state does not switch to `RUNNING`.


## Solution {#issue-resolution}

A {{ managed-k8s-name }} cluster may get stuck while being created or started because one or multiple quotas listed below have been exceeded:

* **Number of vCPUs for instances**
* **Total VM RAM**
* **Number of disks**
* **Total HDD capacity**
* **Total SSD capacity**
* **Number of {{ k8s }} clusters**
* **Number of node groups**
* **Number of nodes**
* **Total number of vCPUs for all nodes**
* **Total amount of RAM**
* **Total disk capacity**

Follow these steps to solve the issue:

1. Check your consumption by the quotas listed above. If your consumption exceeds one or multiple quotas or it is close to exceeding, resource creation operations may end in error. You can check the current quota usage and request the quota increase on [this page]({{ link-console-quotas }}).
1. Check whether a service account is attached to your {{ managed-k8s-name }} cluster, and it has all required roles:

   * `{{ roles.k8s.clusters.agent }}` is required for all service accounts attached to any {{ managed-k8s-name }} clusters.
   * `{{ roles-vpc-public-admin }}` is required for the service accounts attached to {{ managed-k8s-name }} clusters that have their master nodes or worker nodes mapped to public IP addresses.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a ticket, specify the {{ managed-k8s-name }} cluster ID in question.