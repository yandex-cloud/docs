# Fixing the `Quota limit vpc.externalStaticAddresses.count exceeded` error


## Issue description {#issue-description}

When creating a resource in {{ yandex-cloud }}, you get this error message:

```
message: Quota limit vpc.externalStaticAddresses.count exceeded; 
status: 429; description: Quota limit vpc.externalStaticAddresses.count exceeded; 
code: GATEWAY_REQUEST_ERROR; Request ID: ******-****-****-****-********;
Trace ID: d************;
```

## Solution {#issue-resolution}

This error means that you exhausted the **Number of static public IP addresses** [quota](../../../vpc/concepts/limits.md#vpc-quotas).

To fix this issue, you need to request the quota increase using [this form in the management console]({{ link-console-quotas }}) or [delete unused IP addresses](../../../vpc/operations/address-delete.md) if you have any. 

You can also decrease the number of addresses in use by providing the internet access to multiple VMs via a [NAT instance](../../../tutorials/routing/nat-instance/index.md) or [NAT gateway](../../../vpc/concepts/gateways.md).
