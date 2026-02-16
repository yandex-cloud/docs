### Failed to connect to... error

Error message:

```
Failed to connect to <host_address>
```

The error occurs if `localhost` or another invalid value was specified as the database host name. {{ data-transfer-full-name }} runs from its own network environment (dedicated VMs in {{ yandex-cloud }}) and cannot resolve the `localhost` name in terms of your database server. `localhost` always points to the same computer on which the program trying to resolve it is running.

**Solution**:

1. If the database is located on a VM in {{ yandex-cloud }}, specify its internal IP address or FQDN.

1. If the database is located outside of {{ yandex-cloud }}, specify its public IP address or FQDN accessible from the internet.

1. For managed database clusters in {{ yandex-cloud }}, we recommend selecting **Managed Service cluster for <DBMS>** as **Installation type** when configuring the endpoint. This way, you select a managed database cluster from the list, and {{ data-transfer-full-name }} identifies the relevant FQDNs of its hosts.

1. If you are connecting to a managed database cluster in {{ yandex-cloud }} as a custom installation via the FQDN of a specific host, make sure the host address is correct.
