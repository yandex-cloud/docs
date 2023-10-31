### No common availability zone {#common-network}

Error message:

```text
Warn(Activate): YC: unable to resolve instance group:
unable to resolve net topology: neither source nor target subnet found:
No common availability zone found for the source and target endpoints:
source zones: [<source_zone_name>], target zones: [<target_zone_name>]
```

The error occurs if the source and target hosts are within {{ yandex-cloud }} but have no common [availability zones](../../../../overview/concepts/geo-scope.md).

**Solution:**

* Add a host to a cluster so that the hosts have a common availability zone.
* Set up routing through subnets in one availability zone:
   * Check that the network of the endpoint from availability zone 2 has a subnet in availability zone 1. If not, [create one](../../../../vpc/operations/subnet-create.md).
   * Change the type of the endpoint from availability zone 2 to `On-premise`.
   * Specify the subnet from availability zone 1 for this endpoint.
   * As a host, specify the internal IP address (without a port number) of the endpoint hosted in the subnet of availability zone 2.
