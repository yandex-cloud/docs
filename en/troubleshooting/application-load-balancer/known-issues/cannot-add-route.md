# Resolving issues when adding a route


## Issue description {#issue-description}

Applying the {{ alb-name }} manifest fails to add the new route.

## Solution {#issue-resolution}

The issue is most likely caused by exceeding the quota for the number of static public IP addresses.

Unassign the IP address from any unused resource or request a quota increase for the **Number of static public IP addresses** using [this management console form]({{ link-console-quotas }}).