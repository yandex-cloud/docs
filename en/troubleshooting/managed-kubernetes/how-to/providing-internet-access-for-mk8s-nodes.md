# How to provide {{ k8s }} nodes with internet access



## Issue description {#case-description}

When connecting to external addresses from nodes without internet access, you get this error:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: 
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Solution {#case-resolution}

You can provide cluster nodes with internet access through one of the two options:

1. [Use a NAT gateway](../../../vpc/concepts/gateways.md#nat-gateway).
1. Use the group settings to assign a public IP address to each node.
