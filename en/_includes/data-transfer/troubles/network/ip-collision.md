### Overlapping IP address ranges {#ip-collision}

Error message:

```text
YC: unable to resolve instance group:
unable to resolve net topology: subnet address space collision detected:
subnet <ID_of_subnet_1> [<IP_range_of_subnet_1>]
collides with subnet <ID_of_subnet_2> [<IP_range_of_subnet_2>]
```

The error occurs if the source and target hosts are in different subnets within {{ yandex-cloud }} but have overlapping IP address ranges.

**Solution:** Create a new target cluster and make sure the subnets of the target and source cluster hosts involved in a transfer are not overlapping by IP address range.
