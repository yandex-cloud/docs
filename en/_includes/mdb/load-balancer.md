{% note warning %}

We do not recommend creating a [{{ network-load-balancer-short-name }}](../../network-load-balancer/quickstart.md) (NLB) manually for cluster access. The load balancer that is automatically created during cluster deployment has a critically important proxy configuration. Without this configuration, the NLB will block traffic to the handler ports, resulting in loss of access to the cluster.

{% endnote %}

When the load balancer is enabled, it remains possible to connect directly to the database via the [host FQDN]({{ balancer.fqdn-ref }}), bypassing the load balancer.

A separate proxy service based on [{{ balancer.proxy.name }}]({{ balancer.proxy.ref }}) is used to analyze the state and load of hosts. The proxy service is deployed on each host the following functions:

* Monitoring host availability.
* Checking replica lag.
* Verifying host role.

The load balancer provides several special ports for target connections:

* Connection only to the master host: port `{{ balancer.port.master }}`.

* Connection to replicas with lag less than a predefined value: port `{{ balancer.port.non-delayed-replicas }}`.

  For example, to distribute read requests only among replicas with a lag of no more than 30 seconds:
  
  * Create a cluster with the load balancer enabled and specify a replica lag value of 30 seconds in the `{{ balancer.port.non-delayed-replicas }}` port settings.
  * Specify the database connection string with the load balancer FQDN and port `{{ balancer.port.non-delayed-replicas }}` in your application settings.

* Connection to all replicas, regardless of lag: port `{{ balancer.port.replicas }}`.


Traffic from each open port of the load balancer is directed to the proxy service and then distributed to target connections depending on the port number.
