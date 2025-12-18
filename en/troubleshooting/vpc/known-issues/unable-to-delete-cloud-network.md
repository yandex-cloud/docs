# Fixing errors when deleting a cloud network


## Issue description {#issue-description}

When trying to delete a cloud network, you get this error message:
```
text message: Network is not empty;
status: 400;
description: Network is not empty; code: GATEWAY_REQUEST_ERROR;
```

## Solution {#issue-resolution}

Before deleting a cloud network, check that it has no:

* [Subnets](../../../vpc/operations/subnet-delete.md)
* [Security groups](../../../vpc/operations/security-group-delete.md)
* [Route tables](../../../vpc/concepts/routing.md)

To check for the remaining resources that may prevent deletion of your cloud network, you can use the [quota list page]({{ link-console-quotas }}) for the cloud.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:
1. ID of the cloud network in question.
1. Issue description.