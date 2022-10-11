### Overlapping IP address ranges {#ip-collision}

Error message:

```text
YC: unable to resolve instance group:
unable to resolve net topology: subnet address space collision detected:
subnet <ID of subnet 1> [<IP range of subnet 1>]
collides with subnet <ID of subnet 2> [<IP range of subnet 2>]
```

The error occurs if the source and target hosts are in different subnets within {{ yandex-cloud }} but have overlapping IP address ranges.

**Solution:** create a new target cluster and make sure the subnets of the target and source cluster hosts involved in a transfer are not overlapping by IP address range.
