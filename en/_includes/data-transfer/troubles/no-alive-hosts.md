### No alive hosts found in the cluster {#no-alive-hosts}

Error message:

```
No alive hosts found for cluster
```

This error occurs if {{ data-transfer-name }} could not identify any healthy host in the managed DB cluster specified in the endpoint.

Possible solutions:

* Check the cluster state:

  * Go to the [management console]({{ link-console-main }}) and check the state of your managed DB cluster. Make sure the cluster and its hosts are in the **Alive** or **Running** status.

  * If the cluster or its hosts are down, check the cluster logs to find out the reason and fix it.

* Make sure that configurations of the network, subnets, security groups, and route tables allow {{ data-transfer-name }} to access the cluster hosts.

* If the cluster was temporarily unavailable, e.g., during maintenance or due to a failure, wait until it fully recovers and retry activating the transfer.

* Make sure the correct cluster ID or host FQDN is specified in the endpoint.
