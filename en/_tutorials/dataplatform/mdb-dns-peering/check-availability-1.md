* From the `cluster-vm` virtual machine located on the same cloud network as the cluster.

    The connection will be successful.

* From the `other-vm` virtual machine located on a different cloud network.

    {% if audience != "internal" %}

    The connection will be unsuccessful because it will not be possible to get the IP address of the cluster host using the FQDN from another network. However, you can [get the IP address](../../../vpc/operations/subnet-used-addresses.md) of the cluster host and use this IP address to connect: this connection will be successful.

    {% else %}
    
    The connection will be unsuccessful because it will not be possible to get the IP address of the cluster host using the FQDN from another network. However, you can get the IP address of the cluster host and use this IP address to connect: this connection will be successful.

    {% endif %}

    Next, we will demonstrate how to use shared DNS zone settings to maintain the ability to connect to a cluster from a different cloud network using FQDN.
