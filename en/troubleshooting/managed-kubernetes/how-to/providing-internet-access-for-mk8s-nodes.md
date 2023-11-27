# Granting internet access to Kubernetes nodes



## Issue description {#case-description}

When connecting to external addresses from nodes without internet access, you see this error:

```text
Failed to pull image "cr.yandex/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://cr.yandex/v2/: net/http:
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Solution {#case-resolution}

There are several ways to provide internet access to cluster nodes:

1. [Enable Egress NAT](https://cloud.yandex.ru/docs/vpc/operations/enable-nat) for the subnet of nodes
2. [Use a NAT gateway](https://cloud.yandex.ru/docs/vpc/concepts/gateways#nat-gateway)
3. Add a public IP address to each node using node group settings.
