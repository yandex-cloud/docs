# Fixing errors at cloud network deletion

## Issue description {#issue-description}

When you try to delete a cloud network, you see this error message:

```
text message: Network is not empty;
status: 400;
description: Network is not empty; code: GATEWAY_REQUEST_ERROR;
```

## Solution {#case-resolution}

Before deleting a cloud network, check that it doesn't include:

* [Subnets](../../../vpc/operations/subnet-delete.md)
* [Security groups](../../../vpc/operations/security-group-delete.md)
* [Routing tables](../../../vpc/concepts/static-routes.md)

To check for the remaining resources that may prevent deletion of your cloud network, you can use the [quota list page](https://console.cloud.yandex.com/cloud?section=quotas) for the cloud.

{% note info %}

The security groups feature is currently in the **Preview** stage. If you haven't requested preview access to this feature, this section will not be available to you in the management console.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Problem cloud network ID.
2. Problem description.