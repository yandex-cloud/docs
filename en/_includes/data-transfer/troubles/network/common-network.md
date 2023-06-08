### No common availability zone {#common-network}

Error message:

```text
Warn(Activate): YC: unable to resolve instance group:
unable to resolve net topology: neither source nor target subnet found:
No common availability zone found for the source and target endpoints:
source zones: [<source zone name>], target zones: [<target zone name>]
```

The error occurs if the source and target hosts are within {{ yandex-cloud }} but have no common [availability zones](../../../../overview/concepts/geo-scope.md).

**Solution:**

* Add a host to a cluster so that the hosts have a common availability zone.
* Change the type of one of the endpoints to `On-premise`.
