### No server connection {#subnet-without-nat}

There is no connection because the specified subnet has no preconfigured egress NAT gateway.

Error message:

```text
Can't connect to server: Can't ping server:
dial tcp <address of an endpoint's host>:<port>: connect: connection timed out
```

A transfer would fail if it has one `on_premise` endpoint and another endpoint with the subnet that has no egress NAT gateway.

**Solution:** disable the endpoint setting that points to the subnet and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
