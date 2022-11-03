### No server connection {#subnet-without-nat}

There is no connection due to specifying a subnet without egress NAT.

Error message:

```text
Can't connect to server: Can't ping server:
dial tcp <address of an endpoint's host>:<port>: connect: connection timed out
```

A transfer with one endpoint `on_premise` and another one having a subnet with egress NAT disabled fails.

**Solution:** disable the endpoint setting that points to the subnet and [reactivate](../../../../data-transfer/operations/transfer.md#activate) the transfer.
